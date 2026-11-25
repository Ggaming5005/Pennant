-- Run in a solo Studio playtest with ReplicatedStorage.Roster and no other Roster bootstrap.
local runService = game:GetService("RunService")
if not runService:IsStudio() then return end
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Roster = require(game:GetService("ReplicatedStorage"):WaitForChild("Roster"))
assert(not playerGui:FindFirstChild("Roster"), "Disable the other Roster bootstrap")
local key = "PennantAtlasTestMode"
local previous = player:GetAttribute(key)

local function display(layout, tooltips)
	player:SetAttribute(key, "atlas")
	local controller = Roster.Start({
		Preset = "Classic", Layout = layout, StartOpen = true, Columns = {}, Tooltips = tooltips,
		Motion = {Open = "Instant", Close = "Instant"}, Features = {Rankings = false},
		StyleAttributes = {key},
		StylePlayer = function(target)
			local mode = target:GetAttribute(key)
			if mode == "image" then
				return {Badges = {{Image = Roster.Icons.Classic, Position = "Right"}}}
			elseif mode == "text" then
				return {Badges = {{Text = "QA", Position = "Right"}, {Emoji = "★", Position = "Right"}}}
			end
			return {Badges = {Roster.Badges.VIP, Roster.Badges.Founder}}
		end,
	})
	local ok, failure = pcall(function()
		controller:SetOpen(true)
		local screen = playerGui:WaitForChild("Roster", 5)
		local rowName = if layout == "mobile" then "TitlePlayer" else "PlayerEntry_" .. tostring(player.UserId)
		local function waitFor(predicate)
			local deadline = os.clock() + 5
			repeat
				runService.RenderStepped:Wait()
				local row = screen:FindFirstChild(rowName, true)
				local first = row and row:FindFirstChild("Badge1", true)
				local second = row and row:FindFirstChild("Badge2", true)
				if first and predicate(first, second) then return first end
			until os.clock() >= deadline
			error("Timed out checking " .. tostring(player:GetAttribute(key)) .. " on " .. layout)
		end
		local slot = waitFor(function(first, second)
			return second and first.Image.Image == Roster.Badges.VIP.Image and second.Image.Image == first.Image.Image
				and first.Image.ImageRectSize == Vector2.new(256, 256) and second.Image.ImageRectSize == first.Image.ImageRectSize
				and first.Image.ImageRectOffset == Vector2.new(256, 0) and second.Image.ImageRectOffset == Vector2.new(512, 256)
				and first.Image.ImageColor3 == Color3.new(1, 1, 1)
		end)
		player:SetAttribute(key, "image")
		assert(waitFor(function(first, second)
			return first.Image.Image == Roster.Icons.Classic and first.Image.ImageRectOffset == Vector2.zero
				and first.Image.ImageRectSize == Vector2.zero and first.Image.Visible and not second.Visible
		end) == slot, "The pooled slot was unexpectedly replaced")
		player:SetAttribute(key, "text")
		assert(waitFor(function(first, second)
			return second and first.Text.Text == "QA" and first.Text.Visible and not first.Image.Visible
				and second.Text.Text == "★" and second.Text.Visible and not second.Image.Visible
		end) == slot)
		if not tooltips then assert(not screen:FindFirstChild("RosterBadgeTooltip", true)) end
	end)
	controller:Destroy()
	assert(ok, failure)
end

local success, reason = pcall(function()
	for _, layout in ipairs({"desktop", "mobile"}) do
		for _, tips in ipairs({true, false}) do display(layout, tips) end
	end
end)
player:SetAttribute(key, previous)
assert(success, reason)
print("PASS · Atlas cells, pooled standalone images, legacy text and emoji, and optional badge hints")
