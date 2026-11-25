-- Run from the repository root with lune run tests/social-profile.luau.
local luau = require("@lune/luau")
local fs = require("@lune/fs")
local roblox = require("@lune/roblox")
local function signal()
	local callbacks = {}
	return {
		Connect = function(_, fn)
			callbacks[fn] = true
			return {Disconnect = function() callbacks[fn] = nil end}
		end,
		fire = function(...) for fn in pairs(callbacks) do fn(...) end end,
	}
end
local tasks, timers, users = {}, {}, {}
local time, requests, reads, maxPending, filtered = 0, 0, 0, 0, {}
local players = {PlayerAdded = signal(), PlayerRemoving = signal(), GetPlayers = function() return users end}
local function player(id, permitted)
	local attrs = {PennantShareAccountBio = permitted}
	local change = signal()
	local p = {UserId = id, Parent = players,
		GetAttribute = function(_, key) return attrs[key] end,
		SetAttribute = function(_, key, value)
			if key == "PennantFilteredBio" then assert(value == nil or value:sub(1, 7) == "public ", "Raw text replicated") end
			if attrs[key] ~= value then
				attrs[key] = value
				if key == "PennantShareAccountBio" then change.fire() end
			end
		end,
		GetAttributeChangedSignal = function(_, key) assert(key == "PennantShareAccountBio"); return change end,
	}
	table.insert(users, p)
	return p
end
local consent, suppressed = player(11, true), player(12, false)
local invisible, filterError = player(13, true), player(14, true)
local failedHttp, wrongId = player(15, true), player(16, true)
local http = {}
local keyObject = {}
function http:GetSecret(name) assert(name == "BioKey"); return keyObject end
function http:RequestAsync(req)
	assert(req.Method == "GET" and req.Headers["x-api-key"] == keyObject)
	local id = assert(req.Url:match("^https://apis%.roblox%.com/cloud/v2/users/(%d+)$"))
	assert(id ~= "12", "Accessed a Roblox account bio without permission")
	requests += 1
	return {Success = id ~= "15", Body = id}
end
function http:JSONDecode(id)
	return {id = if id == "16" then "999" else id,
		about = if id == "13" then nil else "account " .. id, socialNetworkProfiles = {ignored = true}}
end
local moderation = {}
function moderation:FilterStringAsync(raw, id, _context)
	table.insert(filtered, id)
	if id == 14 then error("filter unavailable") end
	return {GetNonChatStringForBroadcastAsync = function() return "public " .. raw end}
end
local function flush()
	while #tasks > 0 do
		maxPending = math.max(maxPending, #tasks)
		table.remove(tasks, 1)()
	end
end
local env = {
	Instance = roblox.Instance, Enum = roblox.Enum, Color3 = roblox.Color3, UDim2 = roblox.UDim2, Vector2 = roblox.Vector2,
	game = {GetService = function(_, name)
		return assert(({Players = players, TextService = moderation, HttpService = http})[name])
	end},
	task = {
		defer = function(fn) table.insert(tasks, fn) end,
		delay = function(_, fn) timers[fn] = true; return fn end,
		cancel = function(fn) timers[fn] = nil end,
	},
	os = {clock = function() return time end},
}
local profile = luau.load(fs.readFile("src/SocialProfile.luau"), {environment = env, injectGlobals = true})()
local ctrl = profile.serve({
	ApiKeySecret = "BioKey",
	ReadBio = function(p) reads += 1; return "game " .. p.UserId end,
})
flush()
local function bio(p) return p:GetAttribute("PennantFilteredBio") end
assert(bio(consent) == "public account 11" and bio(suppressed) == "public game 12")
assert(bio(invisible) == "public game 13" and bio(filterError) == nil)
assert(bio(failedHttp) == "public game 15" and bio(wrongId) == "public game 16")
assert(requests == 5 and reads == 4 and maxPending == 2)
assert(not ctrl:Refresh(consent), "No duplicate refresh inside cooldown")
consent:SetAttribute("PennantShareAccountBio", false)
assert(bio(consent) == nil and next(timers), "Revocation must synchronously clear biography")
time = 61
for fn in pairs(timers) do timers[fn] = nil; fn() end
flush()
assert(bio(consent) == "public game 11" and requests == 5)
assert(ctrl:Refresh(invisible))
ctrl:Clear(invisible)
flush()
assert(bio(invisible) == nil)
assert(ctrl:Refresh(failedHttp))
players.PlayerRemoving.fire(failedHttp)
flush()
assert(bio(failedHttp) == nil)
ctrl:Destroy()
for _, p in ipairs(users) do assert(bio(p) == nil) end
assert(not ctrl:Refresh(consent))
print("PASS Profile Open Cloud contract, consent, omitted About, ID match, private fallback, filtering, throttling and cleanup")

local parent = roblox.Instance.new("Frame")
function moderation:GetTextSize(text, size, _, bounds)
	assert(size >= 15 and bounds.X > 0)
	return roblox.Vector2.new(bounds.X, if #text > 32 then 120 else size)
end
local render = profile.section(parent)
assert(render(nil, 270, false) == 0 and not parent:FindFirstChild("About"))
local long = string.rep("猫", 320)
local height = render(long, 220, true)
local section = assert(parent:FindFirstChild("About"))
assert(section.Visible and section.Heading.Text == "About" and section.Bio.RichText == false)
assert(utf8.len(section.Bio.Text) == 300 and height == section.Size.Y.Offset and height > 0)
assert(render(nil, 270, false) == 0 and not section.Visible)
render("<b>literal profile</b>", 280, false)
assert(section.Visible and section.Bio.Text == "<b>literal profile</b>" and #parent:GetChildren() == 1)
parent:Destroy()
print("PASS About collapses, wraps safely, handles Unicode and reuses the section across selections")
