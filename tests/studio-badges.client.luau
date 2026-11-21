-- Solo Studio Play in a fresh place: install ReplicatedStorage.Roster and put only this LocalScript
-- in StarterPlayerScripts. The test mounts and destroys its own controllers.
-- For a manual check, set HOVER_SECONDS to 10 and hover the three desktop badges in each pass.
local HOVER_SECONDS = 0
local RunService = game:GetService("RunService")
if not RunService:IsStudio() then return end

local player = game:GetService("Players").LocalPlayer
local playerGui = assert(player:WaitForChild("PlayerGui", 10))
local Roster = require(assert(game:GetService("ReplicatedStorage"):WaitForChild("Roster", 10)))
assert(not playerGui:FindFirstChild("Roster"), "Disable the other roster startup script for this standalone test.")

local badges = {
	{Emoji = "⭐", Position = "Right", Size = 14, Tooltip = "Top scorer"},
	{Emoji = "🛡️", Position = "Right", Size = 14, Tooltip = "Team captain"},
	{Emoji = "🎖️", Position = "Right", Size = 14, Tooltip = "Tournament medal"},
}

local function visible(node, screen)
	while node and node ~= screen do
		if node:IsA("GuiObject") and not node.Visible then return false end
		node = node.Parent
	end
	return node == screen and screen.Enabled
end

local function placed(screen, layout)
	local rowName = if layout == "mobile" then "TitlePlayer" else "PlayerEntry_" .. tostring(player.UserId)
	local row = screen:FindFirstChild(rowName, true)
	local frame = row and row:FindFirstChild("NameFrame", true)
	if not frame then return false end
	local label = frame.PlayerName.PlayerName
	if label.Text ~= player.DisplayName or label.TextBounds.X <= 0 or not visible(label, screen) then return false end
	local edge = label.AbsolutePosition.X + math.min(label.TextBounds.X, label.AbsoluteSize.X)
	local host = label.Parent
	local right = math.min(frame.AbsolutePosition.X + frame.AbsoluteSize.X, host.AbsolutePosition.X + host.AbsoluteSize.X)
	for i, sample in ipairs(badges) do
		local badge = frame:FindFirstChild("Badge" .. i, true)
		if not badge or not visible(badge, screen) or not visible(badge.Text, screen) or badge.Text.Text ~= sample.Emoji then return false end
		local width = badge.AbsoluteSize.X
		if width < 1 then return false end
		local scale = width / badge.Size.X.Offset
		-- TextBounds and AbsolutePosition are screen pixels. The configured gap is in GUI units.
		if math.abs(badge.AbsolutePosition.X - edge - 3 * scale) > math.max(1.5, scale) then return false end
		edge = badge.AbsolutePosition.X + width
		if edge > right + 1 then return false end
	end
	return true
end

local function check(layout, tooltips)
	local controller = Roster.Start({
		Preset = "Classic", Layout = layout, Columns = {}, StartOpen = true,
		Features = {Rankings = false, Badges = true}, Motion = {Open = "Instant", Close = "Instant"},
		MaxBadges = 3, NameBadgeGap = 3, Tooltips = tooltips,
		StylePlayer = function() return {Badges = badges, NameTag = {Font = Enum.Font.BuilderSansBold}} end,
	})
	local ok, reason = pcall(function()
		controller:SetOpen(true)
		local screen = assert(playerGui:WaitForChild("Roster", 10))
		assert(screen:GetAttribute("RosterLayout") == layout, "Unexpected layout. Run this test without another startup script.")
		local deadline = os.clock() + 8
		repeat
			RunService.RenderStepped:Wait()
		until placed(screen, layout) or os.clock() >= deadline
		assert(placed(screen, layout), layout .. " did not show three adjacent badges inside the name column.")
		if layout == "desktop" and HOVER_SECONDS > 0 then
			print(if tooltips then "Hover each badge now. Expect Top scorer, Team captain, and Tournament medal."
				else "Hover the same badges now. The tooltip should stay hidden.")
			task.wait(HOVER_SECONDS)
		end
		if not tooltips then
			assert(not screen:FindFirstChild("RosterBadgeTooltip", true), "A tooltip was created with Tooltips = false.")
		end
	end)
	controller:Destroy()
	assert(ok, reason)
end

for _, tooltips in ipairs({true, false}) do
	check("desktop", tooltips)
	check("mobile", tooltips)
end
print("PASS · Three adjacent badges fit the desktop row and mobile pin. Disabled tooltips created no label.")
