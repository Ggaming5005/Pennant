-- Opt-in Studio playtest. See examples/rankings.server.luau for the matching test board.
-- Place this LocalScript in StarterPlayerScripts and that Script in ServerScriptService.
-- Use the packaged ReplicatedStorage.Roster with its default Settings or the hatch settings example.
if not game:GetService("RunService"):IsStudio() then return end

local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui", 10)
local module = game:GetService("ReplicatedStorage"):WaitForChild("Roster", 10)
assert(playerGui and module, "Install Roster under ReplicatedStorage and start a client playtest.")
local remote = module:WaitForChild("GetRankings", 10)
assert(remote and remote:IsA("RemoteFunction"), "Run examples/rankings.server.luau in ServerScriptService.")

local expected = {
	Global = {
		{810000000001, "Sample Juniper", 96},
		{810000000002, "Sample Ember", 82},
		{810000000003, "Sample Sol", 75},
	},
	Friends = {
		{810000000004, "Sample Rowan", 68},
		{810000000005, "Sample Iris", 61},
	},
}

local function await(check, message)
	local deadline = os.clock() + 10
	repeat
		if check() then return end
		task.wait(0.05)
	until os.clock() >= deadline
	error(message, 2)
end

local function readBoard(scope)
	local finished, ok, result = false, false, nil
	task.spawn(function()
		ok, result = pcall(remote.InvokeServer, remote, "Eggs", scope)
		finished = true
	end)
	await(function() return finished end, scope .. " API call timed out.")
	assert(ok and type(result) == "table" and result.ok, scope .. " API failed: " .. tostring(if ok and type(result) == "table" then result.error else result))
	local rows = result.rows
	assert(#rows == #expected[scope], scope .. " returned the wrong number of rows.")
	for rank, entry in ipairs(expected[scope]) do
		local row = rows[rank]
		assert(row.rank == rank and row.userId == entry[1] and row.name == entry[2] and row.score == entry[3],
			("%s API rank %d should be %s with %d eggs."):format(scope, rank, entry[2], entry[3]))
	end
	return rows
end

local global, friends = readBoard("Global"), readBoard("Friends")
for _, row in ipairs(global) do
	assert(row.userId ~= friends[1].userId, "The highest-scoring sample friend must be outside the global top three.")
end

local controller = require(module).Start()
controller:SetOpen(true)
local screen = assert(playerGui:WaitForChild("Roster", 10), "The mounted roster ScreenGui is missing.")
local function visible(node)
	while node and node ~= screen do
		if node:IsA("GuiObject") and not node.Visible then return false end
		node = node.Parent
	end
	return node == screen and screen.Enabled
end

local metrics = assert(screen:FindFirstChild("Metrics", true), "Missing roster metrics control.")
local scopes = assert(screen:FindFirstChild("Scopes", true), "Missing roster scopes control.")
local host = assert(screen:FindFirstChild("TeamList_Neutral", true), "Missing roster rows.")
await(function() return metrics:FindFirstChild("Eggs") end, "Eggs board missing. Enable both ranking scopes in Settings.")

for _, scope in ipairs({"Global", "Friends"}) do
	assert(controller:SelectTab("Eggs", scope), "Cannot select " .. scope .. ". Check the board and Features settings.")
	await(function()
		local marker = scopes[scope]:FindFirstChild("ActiveUnderline")
		if not marker or not visible(marker) or not visible(metrics.Eggs) then return false end
		local count = 0
		for _, row in ipairs(host:GetChildren()) do
			if not row.Name:match("^PlayerEntry_") or not visible(row) then continue end
			count += 1
			local rank = row.LayoutOrder
			local entry = expected[scope][rank]
			if not entry or row.Name ~= "PlayerEntry_" .. tostring(entry[1]) then return false end
			local frame = row:FindFirstChild("NameFrame", true)
			local name = frame and frame.PlayerName:FindFirstChild("PlayerName")
			local cell = row:FindFirstChild("GameStat", true)
			local score = cell and cell:FindFirstChild("PlayerStatDisplay")
			if not name or not score or not visible(name) or not visible(score) then return false end
			if name.Text:gsub("%s+", " ") ~= ("#%d %s"):format(rank, entry[2]) or score.Text ~= tostring(entry[3]) then return false end
		end
		return count == #expected[scope]
	end, scope .. " UI failed to show the selected tab and expected ranked names and scores.")
end

print("PASS · Roster Studio rankings: Global and Friends API results and visible rows match. Rowan is #1 among friends.")
