-- Solo Studio Play with ReplicatedStorage.Roster and this LocalScript as the only bootstrap.
local runService = game:GetService("RunService")
if not runService:IsStudio() then return end
local player = game:GetService("Players").LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local Roster = require(game:GetService("ReplicatedStorage"):WaitForChild("Roster"))
assert(not gui:FindFirstChild("Roster"), "Disable the other roster bootstrap for this test")

local key = "PennantProfileFrameTest"
local before = player:GetAttribute(key)
local customCenter = Rect.new(12, 12, 68, 68)
local tint = Color3.fromRGB(153, 184, 230)
local function waitFor(description, predicate)
	local untilTime = os.clock() + 5
	repeat
		runService.RenderStepped:Wait()
		if predicate() then return end
	until os.clock() >= untilTime
	error(description)
end

local function check(layout)
	player:SetAttribute(key, "profile")
	local ctl = Roster.Start({
		Preset = "Profile", Layout = layout, StartOpen = true,
		Motion = {Open = "Instant", Close = "Instant"}, Features = {Rankings = false},
		StyleAttributes = {key},
		StylePlayer = function(target)
			local mode = target:GetAttribute(key)
			if mode == "plain" then return {Card = false} end
			if mode == "compact" then
				return {Card = {HeaderLayout = "Compact", BannerImage = "", Frame = false}}
			end
			if mode == "custom" then
				return {Card = {
					BannerImage = Roster.Icons.Classic,
					Frame = {Image = Roster.Icons.Roleplay, SliceCenter = customCenter, SliceScale = 1.25, Color = tint},
				}}
			end
			return {}
		end,
	})
	local ok, problem = pcall(function()
		assert(ctl:SelectPlayer(player), "Could not select the local player")
		local screen = gui:WaitForChild("Roster", 5)
		local frame, cover, card
		waitFor("Missing default cover or nine-slice frame on " .. layout, function()
			frame = screen:FindFirstChild("ProfileFrame", true)
			cover = screen:FindFirstChild("ProfileCover", true)
			if not (frame and frame.Visible and cover and cover.Visible) then return false end
			card = frame.Parent
			local inner = card.InnerFrame
			return frame.AbsoluteSize.X > 0 and (inner.AbsoluteSize - frame.AbsoluteSize).Magnitude < 2
				and (inner.AbsolutePosition - frame.AbsolutePosition).Magnitude < 2
		end)
		assert(frame.ScaleType == Enum.ScaleType.Slice and not frame.Active and not frame.Selectable)
		local originalImage, originalCover = frame.Image, cover.Image
		local originalCenter, originalScale = frame.SliceCenter, frame.SliceScale
		assert(originalImage ~= "" and originalCover ~= "")
		local identity = assert(card:FindFirstChild("DisplayName", true))
		assert(identity.Text == player.DisplayName, "Cover displaced the player's identity")
		assert(not card.InnerFrame.Stats.Visible, "Social card showed an unused stat strip")
		player:SetAttribute(key, "custom")
		waitFor("Custom frame or cover failed to replace previous art", function()
			return frame.Visible and frame.Image == Roster.Icons.Roleplay and cover.Image == Roster.Icons.Classic
				and cover.Visible and frame.SliceCenter == customCenter and frame.SliceScale == 1.25 and frame.ImageColor3 == tint
		end)
		player:SetAttribute(key, "compact")
		waitFor("Compact opt-out left prior art visible", function() return not frame.Visible and not cover.Visible end)
		player:SetAttribute(key, "profile")
		waitFor("Remount retained a previous crop, tint or compact heading", function()
			return frame.Visible and cover.Visible and frame.Image == originalImage and cover.Image == originalCover
				and frame.SliceCenter == originalCenter and math.abs(frame.SliceScale - originalScale) < 0.001
				and frame.ImageColor3 == Color3.new(1, 1, 1)
		end)
		player:SetAttribute(key, "plain")
		waitFor("Unstyled player inherited another player's imagery", function() return not cover.Visible and not frame.Visible end)
		ctl:SetOpen(false)
		waitFor("Closing left the profile card visible", function() return not card.Visible end)
	end)
	ctl:Destroy()
	assert(ok, problem)
end

local ok, problem = pcall(function() check("desktop"); check("mobile") end)
player:SetAttribute(key, before)
assert(ok, problem)
print("PASS · Desktop and mobile profile frame sizing, cover and frame overrides, identity and close")
