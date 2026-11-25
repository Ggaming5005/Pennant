-- From the repository root: lune run tests/rankings.luau
local fs = require("@lune/fs")
local luau = require("@lune/luau")
local roblox = require("@lune/roblox")
local serde = require("@lune/serde")

-- A manual clock and a FIFO scheduler let the real RemoteFunction handler yield and
-- resume normally, including two requests waiting on a single in-flight refresh.
local now = 100
local queue = {}
local function defer(callback, ...)
	table.insert(queue, {thread = if type(callback) == "thread" then callback else coroutine.create(callback),
		args = table.pack(...)})
end
local function drain()
	local i = 1
	while i <= #queue do
		local job = queue[i]
		local ok, issue = coroutine.resume(job.thread, table.unpack(job.args, 1, job.args.n))
		assert(ok, tostring(issue))
		i += 1
	end
	table.clear(queue)
end

local module = {attributes = {}}
local remote
function module:FindFirstChild(name)
	if remote and remote.Parent == self and remote.Name == name then return remote end
end
function module:SetAttribute(key, value) self.attributes[key] = value end
local function newInstance(class)
	if class == "BindableEvent" then
		return {Fire = function() end, Destroy = function() end}
	end
	assert(class == "RemoteFunction", "Unexpected instance " .. class)
	remote = {Destroy = function(self) self.Parent = nil end}
	return remote
end

local players = {PlayerRemoving = {Connect = function() return {Disconnect = function() end} end}}
local online = {}
function players:GetPlayerByUserId(id) return online[id] end
local function player(id, friends)
	local p = {UserId = id, DisplayName = "Viewer" .. id, Parent = players, socialReads = 0}
	function p:GetFriendsWhoPlayedAsync()
		self.socialReads += 1
		return friends
	end
	online[id] = p
	return p
end
local alice = player(101, {202, 201, 150, 201, 101})
local bob = player(102, {301, 150})
local scores = {["91"]=1000, ["92"]=1000, ["93"]=800, ["201"]=70, ["202"]=70, ["101"]=12, ["102"]=20, ["301"]=25}
local stores = {}
local readBudget = 100
local dataStoreService = {}
function dataStoreService:GetRequestBudgetForRequestType(kind)
	assert(kind == "OrderedRead" or kind == "OrderedList", "Unexpected budget")
	return if kind == "OrderedRead" then readBudget else 100
end
function dataStoreService:GetOrderedDataStore(name, scope)
	assert(scope == "global", "Unexpected store scope")
	return assert(stores[name], "Unexpected store " .. name)
end
local function makeStore(name)
	local store = {sortedReads = 0, batches = {}, unavailable = false}
	function store:GetSortedAsync(ascending, count, min, max)
		self.sortedReads += 1
		assert(not self.unavailable, "Simulated ordered list outage")
		local result = {}
		for key, value in scores do
			if (not min or value >= min) and (not max or value <= max) then
				table.insert(result, {key = key, value = value})
			end
		end
		table.sort(result, function(a,b)
			if a.value == b.value then return a.key > b.key end -- Backend returns the tie reversed.
			return if ascending then a.value < b.value else a.value > b.value
		end)
		assert(#result <= count, "Fixture added too many rows for one fake page")
		return {IsFinished = true, GetCurrentPage = function() return result end}
	end
	function store:BatchGetAsync(keys)
		table.insert(self.batches, table.clone(keys))
		local result = {}
		for _, key in keys do
			if scores[key] ~= nil then result[key] = {value = scores[key]} end
		end
		return result
	end
	stores[name] = store
	return store
end
local main = makeStore("MainScores")
local small = makeStore("SmallBudget")
local services = {
	Players = players, DataStoreService = dataStoreService, UserService = {},
	RunService = {IsServer = function() return true end},
	HttpService = {JSONEncode = function(_, value) return serde.encode("json", value) end},
}
local environment = {
	game = {GetService = function(_, id) return assert(services[id], "Unexpected service " .. id) end},
	script = module, Instance = {new = newInstance}, task = {defer = defer},
	Color3 = roblox.Color3, Vector2 = roblox.Vector2,
	Enum = {DataStoreRequestType = {OrderedRead = "OrderedRead", OrderedList = "OrderedList"}},
	os = {clock = function() return now end}, warn = function() end,
}
local Roster = luau.load(fs.readFile("src/Roster.luau"), {environment=environment, injectGlobals=true})()
local session = Roster.Serve({Boards = {
	{Id = "Score", Store = "MainScores", Limit = 3, ResolveNames = false},
	{Id = "Small", Store = "SmallBudget", Limit = 3, ResolveNames = false},
	{Id = "Time", Store = "MainScores", Ascending = true, Limit = 2, ResolveNames = false},
}})
assert(module:FindFirstChild("GetRankings") and #serde.decode("json",module.attributes.RosterBoards)==3)
local function request(viewer, board, scope)
	local ticket = {}
	defer(function() ticket.result = remote.OnServerInvoke(viewer, board, scope) end)
	return ticket
end
local function ask(viewer, board, scope)
	local ticket = request(viewer, board, scope)
	drain()
	return assert(ticket.result, "Unresolved rankings request")
end
local function ranks(result, ids)
	assert(result.ok and #result.rows == #ids, "Unexpected number of rows")
	for i, id in ids do
		local row = result.rows[i]
		assert(row.userId == id and row.rank == i and row.score == scores[tostring(id)], "Incorrect row at rank " .. i)
	end
end

local first, second = request(alice,"Score"), request(bob,"Score","Global")
drain()
ranks(first.result,{91,92,93})
ranks(second.result,{91,92,93})
ranks(ask(alice,"Score","Global"),{91,92,93})
assert(main.sortedReads == 1, "Concurrent and cached global reads should share the snapshot")
ranks(ask(alice,"Time","Global"),{101,102})
print("PASS Global ascending and descending, deterministic displayed ties, coalescing and cache")

local a = ask(alice,"Score","Friends")
local b = ask(bob,"Score","Friends")
ranks(a,{201,202,101})
ranks(b,{301,102})
assert(not a.partial and a.checked == 4 and a.total == 4, "Duplicate IDs or missing score mishandled")
assert(not b.partial and b.total == 3 and a.rows[1].userId ~= b.rows[1].userId, "Viewer cache was shared")
assert(alice.socialReads == 1 and bob.socialReads == 1 and main.sortedReads == 2)
ranks(ask(alice,"Score","Friends"),{201,202,101})
assert(#main.batches == 2, "Repeated personal request issued another batch")
print("PASS Friends include self and offline players outside global leaders, skip missing keys and isolate viewers")

readBudget = 1
local partial = ask(alice,"Small","Friends")
assert(partial.partial and partial.checked == 1 and partial.total == 4 and partial.retryAfter > 0)
ranks(partial,{101})
assert(ask(alice,"Small","Friends").checked == 1 and #small.batches == 1, "Immediate retry reread the first key")
readBudget = 0
now += partial.retryAfter
local paused = ask(alice,"Small","Friends")
assert(paused.partial and paused.checked == 1 and #small.batches == 1)
readBudget = 1
local cursor = paused
for i = 2, 4 do
	now += cursor.retryAfter
	cursor = ask(alice,"Small","Friends")
	assert(cursor.checked == i and cursor.partial == (i < 4), "Scan did not resume at the next key")
end
for n,key in {"101","202","201","150"} do
	assert(#small.batches[n] == 1 and small.batches[n][1]==key, "Wrong incremental batch " .. n)
end
ranks(cursor,{201,202,101})
assert(alice.socialReads == 1, "Retry unnecessarily reread the social graph")
print("PASS Partial Friends results pause with zero budget and resume to an exact ranking")

now += 61
main.unavailable = true
local stale = ask(alice,"Score","Global")
ranks(stale,{91,92,93})
assert(stale.stale and stale.retryAfter > 0 and main.sortedReads == 3)
assert(ask(bob,"Score","Global").stale and main.sortedReads == 3, "Outage retried before backoff")
main.unavailable = false
now += stale.retryAfter
local recovered = ask(bob,"Score","Global")
ranks(recovered,{91,92,93})
assert(not recovered.stale and main.sortedReads == 4)
assert(not ask(bob,"Unknown","Global").ok and not ask(bob,"Score","Invalid").ok)
session:Destroy()
assert(not module:FindFirstChild("GetRankings") and module.attributes.RosterBoards == nil)
print("PASS Stale global snapshot, retry backoff, recovery, public request validation and shutdown")
