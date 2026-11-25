-- Roster.Settings · Edit the player list here.
-- Save your changes in Edit mode, then press Play. Roster.Start({...}) can override individual settings.
-- To try a multi-line example, remove its opening and closing block-comment lines.
return {
	-- Profile includes a jersey banner and a frame around the entire card.
	-- Competitive shows the player's @handle, team and match stats from Columns.
	-- Return Card = {Identity = "UserId"} from StylePlayer to show the player's numeric ID.
	-- Card = {ShowBadges = false, Finish = false} hides the Competitive name pins and header finish.
	-- ProfileFrame = false, -- Or true to use the same frame on any preset.
	-- ProfileFrame = {Image = 75286429427852, SliceCenter = Rect.new(22,22,74,74), SliceScale = 0.7},
	-- Choose "Classic", "Simulator", "Competitive", "Roleplay", or "Profile".
	-- Profile is a social card with an optional filtered About section. See docs/profile.md for the server setup.
	-- nil discovers existing leaderstats and any rankings served by your game.
	Preset = nil,
	-- Classic, Simulator and Roleplay can show a preset emblem on a live player's card.
	-- TemplateIcons = false, -- Hide preset art. Your own badges and card images still work.
	-- TemplateIcons = {Competitive = "rbxassetid://YOUR_IMAGE_ID"}, -- Or replace one icon.
	Tooltips = true, -- Set to false to turn off badge hints everywhere.
	-- NameBadgeGap = 3, -- Pixels between the end of the name and a right-side badge.
	-- MaxBadges = 4,    -- Per player. Increase up to 8 if the list has room.
	-- Layout = "mobile",          -- "desktop" also works. Omit for automatic layout.
	-- MobileTitle = "Leaderboard", -- Use "" to hide the title.

	-- Open and Close can differ. Stock follows the normal desktop or phone animation.
	-- Try "SlideLeft", "SlideRight", "SlideTop", "SlideBottom", "CenterPop",
	-- "CenterZoom", "CartoonBounce", "FloatUp", "Fade", "Pop", "Slide", or "Instant".
	Motion = {
		Open = "Stock", -- Or use {Preset = "SlideLeft", Duration = 0.3}
		Close = "Stock",
	},

	-- An explicit preset starts on Here only. Ranked tabs need a server board.
	-- This example enables Friends. Set Global to true for the Global tab too.
	-- Set Rankings = false inside Features to disable both ranked tabs.
	--[[
	Features = {
		Friends = true, Global = false,
		Cards = true, CardStats = true, SocialActions = true, AvatarAction = true,
		Badges = true, NameEffects = true, ItemImages = true, Trade = false,
	},
	]]

	-- Optional rankings. Use the name of an existing OrderedDataStore keyed by user ID.
	-- Call Roster.Serve() from a server Script to use these board definitions.
	-- Boards = {{Id = "Coins", Label = "Coins", Store = "Coins_AllTime", Limit = 25}},

	-- The native reduced-motion preference automatically stops movement.
	-- Effects = {FPS = 24, MaxAnimatedNames = 6, MaxGlyphs = 14},
	-- Appearance = {RowHeight = 42, Font = Enum.Font.BuilderSans, SurfaceTransparency = 0.2},
	-- IconSizes = {Badge = 18, Stat = 20, Avatar = 48, Featured = 40, Tile = 18},

	-- Explicit columns replace auto-discovery. Stat reads a leaderstat on each player.
	-- Attribute reads a public player attribute, such as player:GetAttribute("Level").
	--[[
	Columns = {
		{Id = "Coins", Stat = "Coins", Label = "Coins", Width = 84},
		{Id = "Level", Attribute = "Level", Label = "Level", Width = 68},
	},
	]]

	-- Give each player a name, badge and card treatment. The accent follows their team.
	-- Name effects include Wave, Glitch, Rainbow, Cycle, Shimmer, Gradient and MovingGradient.
	-- MovingGradient travels Right by default. Try Left, Up or Down, or Speed = 0 to freeze it.
	-- BandWidth is one palette's width or height relative to the name (0.25 to 1).
	-- Image asset IDs can replace Emoji on a badge or emblem via the Image field.
	--[[
	StyleAttributes = {"IsMVP", "IsVIP"}, -- Public flags supplied by your game.
	StylePlayer = function(player)
		local accent = if player.Team then player.Team.TeamColor.Color else Color3.fromRGB(255, 205, 110)
		local art = require(script.Parent).Badges
		local badges = {}
		if player:GetAttribute("IsMVP") == true then table.insert(badges, art.MVP) end
		if player:GetAttribute("IsVIP") == true then table.insert(badges, art.VIP) end
		return {
			NameTag = {
				Font = Enum.Font.BuilderSansBold, Color = accent,
				Effect = {Preset = "MovingGradient", Direction = "Right", Speed = 0.65, BandWidth = 0.85,
					Colors = {accent, Color3.fromRGB(255, 246, 219), Color3.fromRGB(245, 146, 111)}},
			},
			Badges = badges,
			Card = {
				BannerColor = Color3.fromRGB(69, 33, 45), AvatarRingColor = accent,
				Emblem = {Image = require(script.Parent).Icons.Competitive, Position = "Behind", Align = "Right", Size = 64, Transparency = 0.82},
			},
		}
	end,
	]]

	-- Actions appear in array order. Span can be a column count or "Full".
	-- IconPosition accepts "Left", "Right", "Top", or "Behind". Use Icon for an asset ID.
	-- This custom button shows the target's team in a Roblox notification.
	--[[
	ActionGrid = {Columns = 2, MinCellWidth = 84, RowHeight = 44, Gap = 4, FillLastRow = true},
	Actions = {
		{Id = "Avatar", Span = "Full"},
		{
			Id = "Team", Label = "Show team", Audience = "Both", BreakBefore = true,
			Icon = require(script.Parent).Icons.Classic, IconPosition = "Right", IconSize = 20,
			OnActivated = function(target)
				local team = target.Team
				local gui = game:GetService("StarterGui")
				pcall(gui.SetCore, gui, "SendNotification", {
					Title = target.DisplayName, Text = if team then team.Name else "No team", Duration = 3,
				})
			end,
		},
		"Friend", "Block",
	},
	]]
}
