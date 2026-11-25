-- Solo Studio Play. Place only this test in StarterPlayerScripts with ReplicatedStorage.Roster installed.
local runService = game:GetService("RunService")
if not runService:IsStudio() then return end
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Roster = require(game:GetService("ReplicatedStorage"):WaitForChild("Roster"))
assert(not playerGui:FindFirstChild("Roster"), "Disable other Roster startup scripts for this test")

local function check(label, options, expected)
	options.Motion = {Open = "Instant", Close = "Instant"}
	options.StartOpen = true
	options.Features = options.Features or {}
	options.Features.Rankings = false
	local controller = Roster.Start(options)
	local ok, failure = pcall(function()
		assert(controller:SelectPlayer(player), "Could not select the local player")
		local screen = playerGui:WaitForChild("Roster", 5)
		local deadline = os.clock() + 5
		local rendered, mark
		repeat
			runService.RenderStepped:Wait()
			local name = screen:FindFirstChild("DisplayName", true)
			rendered = name and name.Text == player.DisplayName
			local emblem = screen:FindFirstChild("CardEmblem", true)
			mark = emblem and emblem:FindFirstChild("Mark")
		until (rendered and (not expected or (mark and mark:IsA("ImageLabel") and mark.Image == expected)))
			or os.clock() >= deadline
		assert(rendered, "Card did not render")
		if expected then
			assert(mark and mark:IsA("ImageLabel") and mark.Image == expected, "Wrong image on rendered emblem")
		else
			assert(not mark, "Unexpected template emblem")
		end
	end)
	controller:Destroy()
	assert(ok, label .. " failed: " .. tostring(failure))
end

for _, preset in {"Classic", "Simulator", "Competitive", "Roleplay"} do
	local image = Roster.Icons[preset]
	assert(type(image) == "string" and image:match("^rbxassetid://%d+$"), preset .. " has no packaged image URI")
	-- Simulator gives a real player's hatch artwork or odds the entire featured area.
	local hasHatch = preset == "Simulator" and (player:GetAttribute("BestHatchImage") or player:GetAttribute("BestHatchOdds"))
	check(preset, {Preset = preset, Layout = "desktop", Features = {Badges = false}}, if hasHatch or preset == "Competitive" then nil else image)
end
check("touch", {Preset = "Roleplay", Layout = "mobile"}, Roster.Icons.Roleplay)
check("no preset", {Layout = "desktop"})
check("off switch", {Preset = "Roleplay", TemplateIcons = false})
check("item images off", {Preset = "Classic", Features = {ItemImages = false}})
check("owned artwork", {Preset = "Classic", TemplateIcons = {Classic = Roster.Icons.Roleplay}}, Roster.Icons.Roleplay)
check("player override", {Preset = "Classic", StylePlayer = function()
	return {Card = {Emblem = {Image = Roster.Icons.Simulator, Position = "Behind", Size = 40}}}
end}, Roster.Icons.Simulator)
check("player opt-out", {Preset = "Classic", StylePlayer = function() return {Card = {Emblem = false}} end})
check("featured content", {Preset = "Simulator", StylePlayer = function() return {Card = {FeaturedText = "1/100"}} end})
print("PASS · Template icons, touch layout, own artwork, feature gates and player overrides")
