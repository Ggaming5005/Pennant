local rb = require("@lune/roblox")
local luau = require("@lune/luau")

return function(source)
	local ui = luau.load(source, {injectGlobals = true, environment = {
		Instance = rb.Instance, Enum = rb.Enum, Font = rb.Font, UDim = rb.UDim, UDim2 = rb.UDim2,
		Color3 = rb.Color3, ColorSequence = rb.ColorSequence, ColorSequenceKeypoint = rb.ColorSequenceKeypoint,
	}})()
	local function add(parent, class, name)
		local node = rb.Instance.new(class)
		node.Name, node.Parent = name, parent
		return node
	end
	local shell = rb.Instance.new("Frame")
	local header = add(shell, "Frame", "Header")
	local banner = add(header, "ImageLabel", "Background")
	add(header, "ImageLabel", "AvatarImage")
	local identity = add(banner, "Frame", "TextContainerFrame")
	add(identity, "UIListLayout", "Layout")
	add(identity, "TextLabel", "DisplayName")
	add(identity, "TextLabel", "PlayerName")
	local role = add(identity, "TextLabel", "Role")
	local cover = add(banner, "ImageLabel", "Cover")
	local stats = add(shell, "Frame", "Stats")
	local tiles = {}
	for index = 1, 4 do
		local cell = add(stats, "Frame", "Stat" .. index)
		tiles[index] = {cell = cell, caption = add(cell, "TextLabel", "Caption"), value = add(cell, "TextLabel", "Value"),
			pic = add(cell, "ImageLabel", "Art"), outline = add(cell, "UIStroke", "Outline")}
	end
	local function assign(node, key, value) node[key] = value end
	for _, large in {false, true} do
		for count = 1, 4 do
			ui.match(header, stats, role, cover, {Finish = false}, 300, tiles, count, large, assign)
			for index = 1, count do
				local tile = tiles[index]
				assert(math.abs(tile.cell.Size.X.Scale - 1/count) < 0.001)
				assert(math.abs(tile.cell.Position.X.Scale - (index-1)/count) < 0.001)
				for _, label in {tile.caption, tile.value} do
					assert(label.TextXAlignment == rb.Enum.TextXAlignment.Center)
					assert(label.Size.X.Scale == 1 and 2*label.Position.X.Offset + label.Size.X.Offset == 0)
				end
				local bottom = stats.Size.Y.Offset - tile.value.Position.Y.Offset - tile.value.Size.Y.Offset
				assert(math.abs(tile.caption.Position.Y.Offset - bottom) <= 1)
			end
		end
	end
	shell:Destroy()
	print("PASS Match stat labels and values stay centered across one to four columns and both text sizes")
end
