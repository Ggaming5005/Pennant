local luau = require("@lune/luau")
local rb = require("@lune/roblox")

return function(presentationSource)
	local slots, hints, signals = {}, {}, {}
	local label = {
		Parent = true, Size = rb.UDim2.new(1, 0, 0, 24), AbsoluteSize = rb.Vector2.new(160, 24),
		TextBounds = rb.Vector2.new(43, 17), TextXAlignment = rb.Enum.TextXAlignment.Left, TextFits = true, ZIndex = 4,
	}
	function label:GetPropertyChangedSignal(property)
		return {Connect = function(_, callback) signals[property] = callback end}
	end
	local presentation = luau.load(presentationSource, {
		environment = {
			Color3 = rb.Color3, ColorSequence = rb.ColorSequence, ColorSequenceKeypoint = rb.ColorSequenceKeypoint,
			UDim2 = rb.UDim2, Vector2 = rb.Vector2, Enum = rb.Enum,
			Instance = {new = function(class)
				assert(class == "ImageLabel")
				local slot = {}
				table.insert(slots, slot)
				return slot
			end},
		},
		injectGlobals = true,
	})()
	local function asset(image) return image or "" end
	local draw = presentation.badges(label, function(slot, hint) hints[slot] = hint end, asset, 3, 16)
	local vip = {Image = "atlas", ImageRectSize = rb.Vector2.new(256, 256), ImageRectOffset = rb.Vector2.new(256, 0), Tooltip = "VIP"}
	draw({vip, {Text = "Team"}, {Image = "private", Size = 14, Tooltip = "Guide"}, {Image = "third"}, {Image = "fourth"}})
	assert(#slots == 3 and slots[1].Visible and slots[3].Visible)
	assert(slots[1].Position.X.Offset == 47 and slots[2].Position.X.Offset == 67)
	assert(slots[1].ImageRectOffset == vip.ImageRectOffset and hints[slots[2]] == "Guide")
	label.AbsoluteSize, label.TextBounds = rb.Vector2.new(320, 48), rb.Vector2.new(86, 34)
	signals.AbsoluteSize()
	assert(slots[1].Position.X.Offset == 47, "Scaling changed the logical gap")
	label.TextBounds = rb.Vector2.new(264, 34)
	signals.TextBounds()
	assert(slots[1].Visible and not slots[2].Visible and not slots[3].Visible)
	label.TextFits = false
	signals.TextBounds()
	assert(not slots[1].Visible, "A truncated name must keep the space")
	label.TextBounds, label.TextFits = rb.Vector2.new(86, 34), true
	draw({{Image = "new"}})
	assert(slots[1].Visible and slots[1].ImageRectSize == rb.Vector2.zero and slots[1].ImageRectOffset == rb.Vector2.zero)
	assert(hints[slots[1]] == nil and hints[slots[2]] == nil and not slots[2].Visible)
	draw(nil)
	assert(not slots[1].Visible)
	print("PASS Card name badges measure native text, honor UI scale and overflow, and clear crops and hints on reuse")
end
