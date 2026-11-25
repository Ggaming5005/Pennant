local luau = require("@lune/luau")
local rb = require("@lune/roblox")

return function(moduleSource, presentationSource, api)
	local env = {
		Instance = rb.Instance, Enum = rb.Enum, Color3 = rb.Color3, ColorSequence = rb.ColorSequence,
		ColorSequenceKeypoint = rb.ColorSequenceKeypoint, UDim = rb.UDim, UDim2 = rb.UDim2, Vector2 = rb.Vector2,
		game = {GetService = function() return {} end},
	}
	local ui = luau.load(presentationSource, {environment = env, injectGlobals = true})()
	local cellsSource = moduleSource:gsub("return Roster%s*$", "return actionCells")
	local cells = luau.load(cellsSource, {environment = env, injectGlobals = true})()
	local activate = function() end
	local cfg = {Preset = "Competitive", OnLoadout = activate, OnHighlights = activate}
	local grid = {}
	local enabled, defaults = ui.actionOptions(cfg, grid)
	assert(enabled and grid.Columns == 3)
	assert(defaults[1].Id == "Loadout" and defaults[1].OnActivated == activate)
	assert(defaults[2].Id == "Avatar" and defaults[2].Label == "Inspect")
	assert(defaults[3].Id == "Highlights" and defaults[3].OnActivated == activate)
	for _, width in {155, 240, 304} do
		local positions, height = cells({defaults[1], defaults[2], defaults[3]}, width, grid, true, true)
		assert(positions[1].height >= 44 and positions[1].width + 1 >= positions[2].width)
		if width >= 240 then assert(positions[1].width > positions[2].width) end
		assert(positions[3].width == width - 12 and positions[3].y > positions[2].y)
		assert(height - positions[3].y - positions[3].height == grid.Gap, "Bottom inset must match the row gap")
	end
	for _, gap in {0, 4, 12} do
		local one, height = cells({defaults[3]}, 240, {Gap = gap}, true, true)
		assert(height - one[1].y - one[1].height == gap)
	end
	local plain, height = cells({defaults[3]}, 240, {Gap = 12}, true, false)
	assert(height - plain[1].y - plain[1].height == 4, "Native finish keeps its existing inset")
	assert(not ui.actionOptions({Preset = "Simulator"}, {}))
	assert(ui.actionOptions({Preset = "Simulator"}, {Finish = "Competitive"}))
	local images = {}
	for _, id in {"Loadout", "Inspect", "Highlights"} do
		local uri = api.ActionIcons[id]
		assert(uri:match("^rbxassetid://%d+$") and not images[uri], id .. " needs its own image")
		images[uri] = true
	end
	assert(api.ActionIcons.Highlights == "rbxassetid://77199131926973")
	local mediaSource = assert(moduleSource:match("(local function media%b().-)\n\tlocal function opacity"))
	local liveConfig = {}
	local media = luau.load(mediaSource .. "\nreturn media", {
		environment = {config = liveConfig, finish = true, actionArt = api.ActionIcons, glyphs = {}}, injectGlobals = true,
	})()
	assert(media(defaults[3], {}) == api.ActionIcons.Highlights)
	liveConfig.ActionIcons = {Highlights = 123}
	assert(media(defaults[3], {}) == "rbxassetid://123")
	assert(media({Id = "Highlights", Icon = false}, {}) == nil)
	assert(media({Id = "Highlights", Icon = 456}, {}) == "rbxassetid://456")
	local button = rb.Instance.new("ImageButton")
	local overlay = rb.Instance.new("ImageLabel")
	overlay.Name, overlay.ZIndex, overlay.Parent = "HoverBackground", 2, button
	local picture, caption = rb.Instance.new("ImageLabel"), rb.Instance.new("TextLabel")
	picture.Name, picture.Visible, picture.Parent = "Icon", true, overlay
	caption.Name, caption.Text, caption.Parent = "Text", "Loadout", overlay
	ui.finishAction(button, defaults[1], true, 70, false, false, false)
	local plate, cap = button.MatchButtonSurface, caption.ActionLabelBounds
	assert(cap.MaxSize.X == 70 and caption.AutomaticSize == rb.Enum.AutomaticSize.X and caption.Size.X.Offset == 0)
	assert(plate.ZIndex < overlay.ZIndex and not plate.Active and not plate.Selectable and not plate.Interactable)
	assert(button.ImageTransparency == 1 and button.Selectable)
	caption.Text = ""
	ui.finishAction(button, defaults[1], true, 38, false, false, true)
	assert(not caption.Visible and cap.MaxSize.X == 38)
	picture.Visible = false
	ui.finishAction(button, defaults[2], true, 38, false, false, true)
	assert(caption.Visible and caption.Text == "Inspect" and caption.TextSize == 15)
	local custom = rb.Color3.fromRGB(55, 38, 90)
	ui.finishAction(button, {Id = "Highlights", Color = custom}, true, 195, false, false, false)
	assert(plate:GetAttribute("BaseColor") == custom)
	ui.finishAction(button, defaults[3], true, 120, false, true, false)
	assert(not caption:FindFirstChild("ActionLabelBounds"), "Old horizontal constraint leaked to a watermark")
	ui.finishAction(button, {}, false)
	assert(not plate.Visible and caption.Visible)
	button:Destroy()
	print("PASS Match action callbacks, responsive spans, intrinsic icon-caption grouping, touch targets and surface overrides")
end
