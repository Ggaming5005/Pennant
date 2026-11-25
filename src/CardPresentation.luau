-- Client-side decoration for the existing dropdown. The card owns all created instances.
local CardPresentation = {}

function CardPresentation.matchColumns(columns, record, getValue)
	local available = {}
	for _, col in ipairs(columns) do
		if getValue(record, col) ~= nil then table.insert(available, col) end
		if #available == 4 then break end
	end
	return available
end

function CardPresentation.emblem(options, icons)
	local preset, setting = options.Preset, options.TemplateIcons
	if not preset or setting == false or options.Features.ItemImages == false then return nil end
	local image = icons[preset]
	if type(setting) == "table" and setting[preset] ~= nil then image = setting[preset] end
	if type(image) == "number" and image > 0 then image = "rbxassetid://" .. tostring(image) end
	if type(image) ~= "string" or image == "" then return nil end
	return {Image = image, Position = "Right", Size = 32}
end

function CardPresentation.new(card, inner)
	local frame
	return function(style, asset)
		local custom = if type(style) == "table" then style else {}
		local image = if style == true then "rbxassetid://75286429427852" else asset(custom.Image)
		if image == "" then
			if frame then frame.Visible = false end
			return
		end
		if not frame then
			frame = Instance.new("ImageLabel")
			frame.Name, frame.BackgroundTransparency, frame.ZIndex = "ProfileFrame", 1, 20
			frame.Active, frame.Selectable, frame.ScaleType = false, false, Enum.ScaleType.Slice
			frame.AnchorPoint, frame.Position, frame.Size = inner.AnchorPoint, inner.Position, inner.Size
			frame.Parent = card
		end
		frame.Image = image
		frame.SliceCenter = if typeof(custom.SliceCenter) == "Rect" then custom.SliceCenter else Rect.new(22, 22, 74, 74)
		frame.SliceScale = math.clamp(tonumber(custom.SliceScale) or 0.7, 0.1, 4)
		frame.ImageColor3 = if typeof(custom.Color) == "Color3" then custom.Color else Color3.new(1, 1, 1)
		frame.Visible = true
	end
end

-- Keep the identity and the game-supplied match results on a common grid.
-- "set" restores native properties before a different player's card is drawn.
local function rule(parent, key)
	local line = parent:FindFirstChild(key)
	if line then return line end
	line = Instance.new("Frame")
	line.Name, line.BorderSizePixel, line.Visible = key, 0, false
	line.Active, line.Selectable, line.Parent = false, false, parent
	return line
end

local function material(parent, name, rotation, colors, set)
	local gradient = parent:FindFirstChild(name)
	if not gradient then
		gradient = Instance.new("UIGradient")
		gradient.Name, gradient.Rotation, gradient.Color = name, rotation, colors
		gradient.Enabled, gradient.Parent = false, parent
	end
	set(gradient, "Enabled", true)
end

local graphite = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(223, 234, 255)),
	ColorSequenceKeypoint.new(0.52, Color3.fromRGB(166, 177, 203)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(201, 183, 212)),
})
local rimLight = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(110, 117, 156)),
	ColorSequenceKeypoint.new(0.36, Color3.fromRGB(154, 184, 207)),
	ColorSequenceKeypoint.new(0.70, Color3.fromRGB(71, 76, 97)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 108, 146)),
})
local insetLight = ColorSequence.new(Color3.fromRGB(245, 249, 255), Color3.fromRGB(155, 158, 183))

local function matchFinish(header, banner, portrait, identity, spec, left, inset, set)
	local shell = header.Parent
	material(shell, "MatchSurface", 63, graphite, set)
	if spec.Frame == nil then
		local rim = shell:FindFirstChild("MatchRim")
		if not rim then
			rim = Instance.new("UIStroke")
			rim.Name, rim.ApplyStrokeMode, rim.Thickness = "MatchRim", Enum.ApplyStrokeMode.Border, 1.2
			rim.Color, rim.Transparency = Color3.new(1,1,1), 0.27
			rim.Enabled, rim.Parent = false, shell
		end
		material(rim, "RimLight", 24, rimLight, set)
		set(rim, "Enabled", true)
	end
	local panel = rule(banner, "IdentityPanel")
	if not panel:FindFirstChildOfClass("UICorner") then
		local corner = Instance.new("UICorner")
		corner.CornerRadius, corner.Parent = UDim.new(0, 5), panel
	end
	panel.ZIndex, panel.BackgroundColor3 = banner.ZIndex, (spec.BannerColor or shell.BackgroundColor3):Lerp(Color3.fromRGB(9,13,23), 0.46)
	panel.Position, panel.Size = UDim2.fromOffset(left - 5, 5), UDim2.new(1, -left + 1, 1, -10)
	set(panel, "Visible", true)
	material(panel, "InsetLight", 22, insetLight, set)
	local line = rule(panel, "IdentityRule")
	line.BackgroundColor3, line.BackgroundTransparency = Color3.fromRGB(133, 151, 177), 0.79
	line.Position, line.Size = UDim2.new(0, 8, 0.5, 4), UDim2.new(1, -16, 0, 1)
	set(line, "Visible", true)
	set(identity, "Position", UDim2.fromOffset(left + 3, 0))
	set(identity, "Size", UDim2.new(1, -left-inset, 1, 0))
	set(identity, "ZIndex", panel.ZIndex + 2)
	for _, label in {identity.DisplayName, identity.PlayerName} do
		set(label, "ZIndex", identity.ZIndex)
	end
	local ring = portrait:FindFirstChild("AvatarRing")
	if ring and ring.Enabled then material(ring, "RingLight", 62, insetLight, set) end
end

function CardPresentation.match(header, stats, role, cover, spec, width, tiles, count, large, set)
	local banner, portrait = header.Background, header.AvatarImage
	local identity = banner.TextContainerFrame
	local name, handle, layout = identity.DisplayName, identity.PlayerName, identity.Layout
	local height = if large then 85 else 71
	local inset = if width < 230 then 6 else 8
	local portraitSize = math.clamp(portrait.Size.X.Offset, 1, math.min(height-12, math.max(width*0.25,1)))
	local left = if portrait.Visible then portraitSize + inset + 10 else inset
	set(header, "Size", UDim2.new(1,0,0,height+10))
	set(banner, "Size", UDim2.new(1,-12,0,height))
	cover.Visible = false
	set(portrait,"Position",UDim2.fromOffset(inset+5,5+height/2))
	set(portrait,"Size",UDim2.fromOffset(portraitSize,portraitSize))
	set(portrait,"BackgroundTransparency",0)
	local corner = portrait:FindFirstChild("CardCorner")
	if corner then set(corner,"CornerRadius",UDim.new(0,4)) end
	local ring = portrait:FindFirstChild("AvatarRing")
	if ring then set(ring,"Thickness",1) end
	local team = if role.Visible then role.Text else ""
	set(identity,"Position",UDim2.fromOffset(left,0))
	set(identity,"Size",UDim2.new(1,-left-inset,1,0))
	if spec.Finish ~= false then matchFinish(header, banner, portrait, identity, spec, left, inset, set) end
	set(layout,"Padding",UDim.new(0,7))
	set(role,"Visible",false)
	set(name,"TextSize",if large then 23 else 19)
	set(name,"Size",UDim2.new(1,0,0,if large then 28 else 24))
	set(handle,"TextSize",if large then 15 else 12)
	set(handle,"Size",UDim2.new(1,0,0,if large then 19 else 16))
	set(handle,"TextColor3",Color3.fromRGB(181,190,203))
	if team ~= "" then set(handle,"Text",handle.Text .. "  ·  " .. team) end
	if count == 0 then return end
	local rowHeight = if large then 67 else 55
	local captionHeight = if large then 19 else 15
	local valueHeight = if large then 28 else 23
	local top = math.floor((rowHeight - captionHeight - 1 - valueHeight) / 2)
	set(stats,"Size",UDim2.new(1,0,0,rowHeight))
	for i=1,count do
		local tile = tiles[i]
		set(tile.cell,"Position",UDim2.new((i-1)/count,0,0,0))
		set(tile.cell,"Size",UDim2.new(1/count,0,1,0))
		set(tile.cell,"BackgroundTransparency",1)
		set(tile.pic,"Visible",false)
		set(tile.outline,"Enabled",false)
		local divider = rule(tile.cell,"StatDivider")
		divider.BackgroundColor3 = Color3.fromRGB(61,69,81)
		divider.Position, divider.Size = UDim2.fromOffset(0,9), UDim2.new(0,1,1,-18)
		set(divider,"Visible",i>1)
		set(tile.caption,"Position",UDim2.fromOffset(4,top))
		set(tile.caption,"Size",UDim2.new(1,-8,0,captionHeight))
		set(tile.caption,"TextXAlignment",Enum.TextXAlignment.Center)
		set(tile.caption,"TextYAlignment",Enum.TextYAlignment.Center)
		set(tile.caption,"TextColor3",Color3.fromRGB(176,186,200))
		set(tile.value,"Position",UDim2.fromOffset(4,top + captionHeight + 1))
		set(tile.value,"Size",UDim2.new(1,-8,0,valueHeight))
		set(tile.value,"TextXAlignment",Enum.TextXAlignment.Center)
		set(tile.value,"TextYAlignment",Enum.TextYAlignment.Center)
		set(tile.value,"TextSize",if large then 23 else 20)
		set(tile.value,"FontFace",Font.fromEnum(Enum.Font.BuilderSansBold))
		set(tile.value,"TextColor3",if typeof(tile.tint)=="Color3" then tile.tint else Color3.fromRGB(238,241,245))
	end
end

local buttonTones = {
	Loadout = Color3.fromRGB(39, 65, 96),
	Inspect = Color3.fromRGB(52, 58, 69),
	Highlights = Color3.fromRGB(67, 53, 78),
}
local edges = {
	Loadout = Color3.fromRGB(107, 154, 199),
	Inspect = Color3.fromRGB(118, 132, 146),
	Highlights = Color3.fromRGB(139, 111, 155),
}
local function actionKind(id)
	return if id == "Avatar" then "Inspect" else id
end

function CardPresentation.actionOptions(config, grid)
	local match = config.Preset == "Competitive"
	local enabled = if grid.Finish == nil then match else grid.Finish == "Competitive"
	if enabled then
		grid.Columns = grid.Columns or 3
		grid.MinCellWidth = grid.MinCellWidth or 65
		grid.RowHeight = grid.RowHeight or 43
		grid.Gap = grid.Gap or 6
	end
	if not match then return enabled end
	return enabled, {
		{Id = "Loadout", Span = "Wide", Audience = "Both", OnActivated = config.OnLoadout},
		{Id = "Avatar", Span = if type(config.OnLoadout) == "function" then 1 else "Full", Label = "Inspect"},
		{Id = "Highlights", Label = "View highlights", Span = "Full", Audience = "Both", OnActivated = config.OnHighlights},
		"Spectate", "Friend", "Block",
	}
end

local function newButtonPlate(node)
	local plate = Instance.new("Frame")
	plate.Name, plate.BorderSizePixel, plate.BackgroundColor3 = "MatchButtonSurface", 0, Color3.new(1, 1, 1)
	plate.Active, plate.Selectable, plate.Interactable = false, false, false
	plate.Position, plate.Size = UDim2.fromOffset(1, 1), UDim2.new(1, -2, 1, -2)
	plate.ZIndex = math.max(1, node.HoverBackground.ZIndex - 1)
	local corners = Instance.new("UICorner")
	corners.CornerRadius, corners.Parent = UDim.new(0, 5), plate
	local fill = Instance.new("UIGradient")
	fill.Name, fill.Rotation, fill.Parent = "Fill", 90, plate
	local edge = Instance.new("UIStroke")
	edge.Name, edge.Thickness, edge.Color, edge.Parent = "Edge", 1.3, Color3.new(1, 1, 1), plate
	local light = Instance.new("UIGradient")
	light.Name, light.Rotation, light.Parent = "Light", 12, edge
	plate.Parent = node
	return plate
end

function CardPresentation.finishAction(node, def, enabled, room, vertical, behind, large)
	local content = node.HoverBackground
	local text = content.Text
	local plate = node:FindFirstChild("MatchButtonSurface")
	local cap = text:FindFirstChild("ActionLabelBounds")
	if not enabled then
		if plate then plate.Visible = false end
		if cap then cap:Destroy() end
		text.Visible = true
		return
	end
	local kind = actionKind(def.Id)
	local base = if typeof(def.Color) == "Color3" then def.Color else buttonTones[kind] or buttonTones.Inspect
	local accent = if typeof(def.Color) == "Color3" then base:Lerp(Color3.new(1, 1, 1), 0.32) else edges[kind] or edges.Inspect
	plate = plate or newButtonPlate(node)
	plate.Visible, node.ImageTransparency = true, 1
	if plate:GetAttribute("BaseColor") ~= base or plate:GetAttribute("EdgeColor") ~= accent then
		plate:SetAttribute("BaseColor", base)
		plate:SetAttribute("EdgeColor", accent)
		plate.Fill.Color = ColorSequence.new(base:Lerp(Color3.new(1, 1, 1), 0.055), base:Lerp(Color3.new(), 0.18))
		plate.Edge.Light.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, accent:Lerp(base, 0.35)),
			ColorSequenceKeypoint.new(0.48, accent:Lerp(Color3.new(1, 1, 1), 0.12)),
			ColorSequenceKeypoint.new(1, accent:Lerp(base, 0.58)),
		})
	end
	text.TextSize = if large then 15 else 13
	local glyph, watermark = content:FindFirstChild("ActionGlyph"), node:FindFirstChild("ActionWatermark")
	if text.Text == "" and not content.Icon.Visible and not (glyph and glyph.Visible) and not (watermark and watermark.Visible) then
		text.Text = if def.Id == "Avatar" then "Inspect" else def.Id
	end
	text.Visible = text.Text ~= ""
	if vertical or behind then
		if cap then cap:Destroy() end
		return
	end
	if not cap then
		cap = Instance.new("UISizeConstraint")
		cap.Name, cap.Parent = "ActionLabelBounds", text
	end
	-- Intrinsic width is based on the actual localized font, including narrow characters.
	-- UIListLayout then centers the icon and the clipped caption as one group.
	cap.MaxSize = Vector2.new(math.max(1, room), 22)
	text.AutomaticSize, text.Size = Enum.AutomaticSize.X, UDim2.fromOffset(0, if large then 20 else 18)
end

-- Add earned artwork to the native name label. Its own TextBounds accounts for
-- custom fonts and localization; a long name keeps precedence over trailing badges.
function CardPresentation.badges(name, bindHint, asset, limit, defaultSize)
	local slots, widths, count = {}, {}, 0
	local function layout()
		if not name.Parent or count == 0 then return end
		local scale = if name.Size.Y.Scale == 0 and name.Size.Y.Offset > 0
			then name.AbsoluteSize.Y / name.Size.Y.Offset else 1
		if scale <= 0 then return end
		local width, ink = name.AbsoluteSize.X / scale, name.TextBounds.X / scale
		local edge = if name.TextXAlignment == Enum.TextXAlignment.Center then (width + ink) / 2
			elseif name.TextXAlignment == Enum.TextXAlignment.Right then width else ink
		local fits = name.TextFits and ink > 0
		for i = 1, count do
			local slot = slots[i]
			local size = math.min(widths[i], math.floor(name.AbsoluteSize.Y / scale))
			local x = math.ceil(edge) + 4
			fits = fits and size >= 8 and x + size <= width
			slot.Visible = fits
			if fits then
				slot.Position, slot.Size = UDim2.new(0,x,0.5,0), UDim2.fromOffset(size,size)
				edge = x + size
			end
		end
	end
	name:GetPropertyChangedSignal("TextBounds"):Connect(layout)
	name:GetPropertyChangedSignal("AbsoluteSize"):Connect(layout)
	name:GetPropertyChangedSignal("TextXAlignment"):Connect(layout)
	return function(definitions)
		local previous = count
		count = 0
		for _, definition in ipairs(if type(definitions) == "table" then definitions else {}) do
			if count >= limit then break end
			local spec = if type(definition) == "table" then definition else {}
			local image = asset(if type(definition) == "table" then spec.Image else definition)
			if image == "" then continue end
			count += 1
			local slot = slots[count]
			if not slot then
				slot = Instance.new("ImageLabel")
				slot.Name, slot.BackgroundTransparency = "EarnedBadge" .. count, 1
				slot.Active, slot.Selectable, slot.Interactable = false, false, false
				slot.ScaleType, slot.AnchorPoint = Enum.ScaleType.Fit, Vector2.new(0,0.5)
				slot.ZIndex, slot.Parent = name.ZIndex+2, name
				slots[count] = slot
			end
			local requested = tonumber(spec.Size) or tonumber(defaultSize) or 16
			widths[count] = math.clamp(if requested == requested then requested else 16, 10, 20)
			slot.Image = image
			slot.ImageRectOffset = if typeof(spec.ImageRectOffset) == "Vector2" then spec.ImageRectOffset else Vector2.zero
			slot.ImageRectSize = if typeof(spec.ImageRectSize) == "Vector2" then spec.ImageRectSize else Vector2.zero
			slot.ImageColor3 = if typeof(spec.Color) == "Color3" then spec.Color else Color3.new(1,1,1)
			local transparency = tonumber(spec.Transparency)
			slot.ImageTransparency = if transparency and transparency == transparency then math.clamp(transparency,0,1) else 0
			bindHint(slot, spec.Tooltip)
		end
		for i = count+1, previous do
			slots[i].Visible = false
			bindHint(slots[i], nil)
		end
		layout()
	end
end

return CardPresentation
