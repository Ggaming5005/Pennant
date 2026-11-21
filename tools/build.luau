-- Run from the repository root with: lune run tools/build.luau
local fs = require("@lune/fs")
local luau = require("@lune/luau")
local roblox = require("@lune/roblox")

local path = "Roster.rbxm"
local templateNames = {"StockPlayerList", "StockMobilePlayerList"}

local function readSource(file)
	-- Keep the installed source identical across LF and CRLF checkouts.
	local source = fs.readFile(file):gsub("\r\n", "\n")
	assert(#source <= 200000, file .. " exceeds Studio's 200,000-byte source limit")
	local ok, message = pcall(luau.compile, source)
	if not ok then error(file .. " failed to compile: " .. tostring(message)) end
	return source
end

local function readPackage(bytes)
	local roots = roblox.deserializeModel(bytes)
	local root = roots[1]
	assert(#roots == 1 and root.Name == "Roster" and root:IsA("ModuleScript"), "Expected a single Roster ModuleScript")
	assert(#root:GetChildren() == 3, "Expected Settings and two GUI templates under Roster")
	local settings = root:FindFirstChild("Settings")
	assert(settings and settings:IsA("ModuleScript"), "Missing Roster.Settings ModuleScript")
	for _, name in ipairs(templateNames) do
		local template = root:FindFirstChild(name)
		assert(template and template:IsA("ScreenGui"), "Missing ScreenGui template: " .. name)
	end
	return root, settings
end

local source = readSource("src/Roster.luau")
local settingsSource = readSource("src/Settings.luau")
local previous = fs.readFile(path)
local root, settings = readPackage(previous)
root.Source, settings.Source = source, settingsSource

local bytes = roblox.serializeModel({root})
local verified, verifiedSettings = readPackage(bytes)
assert(verified.Source == source and verifiedSettings.Source == settingsSource, "Source changed during serialization")
for _, name in ipairs(templateNames) do
	assert(roblox.serializeModel({verified[name]}) == roblox.serializeModel({root[name]}), name .. " changed during serialization")
end
if bytes ~= previous then fs.writeFile(path, bytes) end
print(("Verified %s (%d bytes), both sources, and both GUI templates."):format(path, #bytes))
