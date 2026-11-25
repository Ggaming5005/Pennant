-- Run from the repository root with: lune run tools/build.luau
local fs = require("@lune/fs")
local luau = require("@lune/luau")
local roblox = require("@lune/roblox")

local path = "Roster.rbxm"
local templateNames = {"StockPlayerList", "StockMobilePlayerList"}
local moduleNames = {"Settings", "CardPresentation", "SocialProfile"}

local function readSource(file)
	-- Keep the installed source identical across LF and CRLF checkouts.
	local source = fs.readFile(file):gsub("\r\n", "\n")
	assert(#source <= 200000, file .. " exceeds Studio's 200,000-byte source limit")
	local ok, message = pcall(luau.compile, source)
	if not ok then error(file .. " failed to compile: " .. tostring(message)) end
	return source
end

local function readPackage(bytes, allowPreviousRelease)
	local roots = roblox.deserializeModel(bytes)
	local root = roots[1]
	assert(#roots == 1 and root.Name == "Roster" and root:IsA("ModuleScript"), "Expected a single Roster ModuleScript")
	local children = root:GetChildren()
	local expected = {Settings = "ModuleScript", StockPlayerList = "ScreenGui", StockMobilePlayerList = "ScreenGui"}
	if not allowPreviousRelease or #children ~= 3 then
		expected.CardPresentation, expected.SocialProfile = "ModuleScript", "ModuleScript"
	end
	for _, child in children do
		assert(expected[child.Name] == child.ClassName, "Unexpected, duplicate or misnamed package child: " .. child.Name)
		expected[child.Name] = nil
	end
	assert(next(expected) == nil, "Incomplete Roster package")
	return root
end

local source = readSource("src/Roster.luau")
local previous = fs.readFile(path)
local root = readPackage(previous, true)
local templateBytes = {}
for _, name in templateNames do
	templateBytes[name] = roblox.serializeModel({root[name]})
end
root.Source = source
local sources = {}
for _, name in moduleNames do
	local text = readSource("src/" .. name .. ".luau")
	local child = root:FindFirstChild(name)
	if not child then
		child = roblox.Instance.new("ModuleScript")
		child.Name, child.Parent = name, root
	end
	child.Source, sources[name] = text, text
end

local bytes = roblox.serializeModel({root})
local verified = readPackage(bytes, false)
assert(verified.Source == source, "Roster source changed during serialization")
for _, name in moduleNames do
	assert(verified[name].Source == sources[name], name .. " source changed during serialization")
end
for _, name in ipairs(templateNames) do
	assert(roblox.serializeModel({verified[name]}) == templateBytes[name], name .. " changed during serialization")
end
if bytes ~= previous then fs.writeFile(path, bytes) end
print(("Verified %s (%d bytes), four sources, and both stock GUI templates."):format(path, #bytes))
