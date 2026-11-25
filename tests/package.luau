-- From the repository root: lune run tests/package.luau
local fs = require("@lune/fs")
local luau = require("@lune/luau")
local roblox = require("@lune/roblox")

local roots = roblox.deserializeModel(fs.readFile("Roster.rbxm"))
assert(#roots == 1, "Roster.rbxm must import as one root")
local root = roots[1]
assert(root.Name == "Roster" and root:IsA("ModuleScript"), "Expected one Roster ModuleScript")
local expected = {
	Settings = "ModuleScript", CardPresentation = "ModuleScript", SocialProfile = "ModuleScript",
	StockPlayerList = "ScreenGui", StockMobilePlayerList = "ScreenGui",
}
for _, child in root:GetChildren() do
	assert(expected[child.Name] == child.ClassName, "Unexpected or duplicate child: " .. child.Name)
	expected[child.Name] = nil
end
assert(next(expected) == nil, "Missing template, Settings or private presentation module")
assert(root:GetAttribute("RosterBoards") == nil, "The package should start without a published board catalog")
for _, node in root:GetDescendants() do
	if node:IsA("LuaSourceContainer") then
		assert(node.Parent == root and node:IsA("ModuleScript"), "Unexpected script inside package: " .. node:GetFullName())
	end
	assert(not node:IsA("RemoteFunction") and not node:IsA("RemoteEvent"), "A runtime remote was baked into the package")
	if node:IsA("TextLabel") and (node.Name == "PlayerName" or node.Name == "PlayerStatDisplay" or node.Name == "DisplayName") then
		assert(node.Text == "", "Captured player text must start empty: " .. node:GetFullName())
	end
end
assert(root.StockPlayerList:FindFirstChild("OffsetFrame",true) and root.StockPlayerList:FindFirstChild("PlayerEntry_Template",true))
assert(root.StockMobilePlayerList:FindFirstChild("BodyBackground",true) and root.StockMobilePlayerList:FindFirstChild("TitlePlayer",true))
print("PASS Single importable model, Settings, private presentation modules and clean desktop/mobile templates")

local function codeIn(modelScript, path)
	local source = fs.readFile(path)
	-- Git checkouts may normalize newlines; every other byte must match the model.
	assert(source:gsub("\r\n", "\n") == modelScript.Source:gsub("\r\n", "\n"), "Model/source mismatch: " .. path)
	assert(luau.compile(source))
	return source
end
local moduleSource = codeIn(root, "src/Roster.luau")
for _, symbol in {"—", "…"} do
	assert(moduleSource:find(symbol, 1, true), "Missing UI punctuation: " .. symbol)
end
assert(not moduleSource:find("â€", 1, true), "A fallback label contains misdecoded UTF-8 punctuation")
local settingsSource = codeIn(root.Settings, "src/Settings.luau")
local presentationSource = codeIn(root.CardPresentation, "src/CardPresentation.luau")
require("./card-badges")(presentationSource)
require("./match-stats")(presentationSource)
codeIn(root.SocialProfile, "src/SocialProfile.luau")
local config = luau.load(settingsSource)()
assert(type(config) == "table" and config.Motion.Open == "Stock" and config.Motion.Close == "Stock")
for _, key in {"Preset", "Columns", "Boards", "StylePlayer", "Actions", "Tabs", "OnTrade"} do
	assert(config[key] == nil, "Fresh install unexpectedly supplies " .. key)
end
local imports = {RunService = {}, HttpService = {}}
local api = luau.load(moduleSource, {
	environment = {
		Color3 = roblox.Color3, Vector2 = roblox.Vector2,
		game = {GetService = function(_, name) return assert(imports[name], "Unexpected import-time service: " .. name) end},
	},
	injectGlobals = true,
})()
assert(type(api.Start) == "function" and type(api.Serve) == "function")
print("PASS Model/source parity, inert module import, automatic stats and Stock motion defaults")
require("./match-actions")(moduleSource, presentationSource, api)

local atlasCopy = api.MakeBadgeAtlas(12345)
local shared = api.Badges.MVP.Image
assert(shared:match("^rbxassetid://%d+$"), "Badge atlas needs a published Roblox image")
for index, name in ipairs({"MVP", "VIP", "Creator", "Moderator", "Champion", "Founder"}) do
	local badge = api.Badges[name]
	local cell = index - 1
	assert(badge.Image == shared and badge.ImageRectSize == roblox.Vector2.new(256, 256))
	assert(badge.ImageRectOffset == roblox.Vector2.new((cell % 3) * 256, math.floor(cell / 3) * 256))
	assert(badge.Tooltip == name and badge.Position == "Right" and table.isfrozen(badge))
	assert(atlasCopy[name].Image == "rbxassetid://12345" and atlasCopy[name].ImageRectOffset == badge.ImageRectOffset)
end
for _, name in ipairs({"Classic", "Simulator", "Competitive", "Roleplay"}) do
	assert(api.Icons[name]:match("^rbxassetid://%d+$"), name .. " needs a published image")
end
print("PASS Four template images and six optional graphic badges on one replaceable atlas")

local examples = {}
for _, file in fs.readDir("examples") do
	if file:sub(-5) == ".luau" then
		local content = fs.readFile("examples/" .. file)
		assert(luau.compile(content), "Example did not compile: " .. file)
		examples[file] = content
	end
end
assert(examples["start.client.luau"] and examples["hatch-settings.luau"] and examples["rankings.server.luau"])
local startCount, destroyCount, disconnect = 0, 0, nil
local starter = {
	Start = function(...)
		assert(select("#", ...) == 0, "Client bootstrap should use the user's Settings")
		startCount += 1
		return {Destroy = function() destroyCount += 1 end}
	end,
}
local storage = {WaitForChild = function(_, name) assert(name == "Roster"); return root end}
luau.load(examples["start.client.luau"], {
	environment = {
		game = {GetService = function(_, name) assert(name == "ReplicatedStorage"); return storage end},
		require = function(target) assert(target == root); return starter end,
		script = {Destroying = {Connect = function(_, callback) disconnect = callback end}},
	},
	injectGlobals = true,
})()
assert(startCount == 1 and disconnect)
disconnect()
assert(destroyCount == 1)
-- Execute the actual sample with IsStudio() false. Any attempt to build boards, get a
-- datastore, require the module or access other services makes this test fail.
luau.load(examples["rankings.server.luau"], {
	environment = {
		game = {GetService = function(_, name)
			assert(name == "RunService", "Ranking fixtures ran outside Studio: " .. name)
			return {IsStudio = function() return false end}
		end},
		require = function() error("Ranking fixtures required a package outside Studio") end,
	},
	injectGlobals = true,
})()
print("PASS Examples compile, default client starts without overrides, and sample ranking data is Studio-only")

require("./moving-gradient")(moduleSource)
