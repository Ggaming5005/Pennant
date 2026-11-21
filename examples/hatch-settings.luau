-- Copy into ReplicatedStorage > Roster > Settings (ModuleScript).
-- The game supplies Eggs in leaderstats and BestHatchOdds / BestHatchImage on each Player.
local function oddsText(value)
	if type(value) == "number" and value >= 1 and value < math.huge then
		return "1/" .. string.format("%.0f", value)
	end
	return "—"
end

return {
	Preset = "Simulator",
	Features = {Rankings = true},
	Columns = {
		{Id = "Eggs", Stat = "Eggs"},
		{
			Id = "Rarest", Label = "Rarest hatch", Attribute = "BestHatchOdds", Width = 115,
			Format = oddsText,
			Image = function(_, player)
				return player:GetAttribute("BestHatchImage")
			end,
		},
	},
	StyleAttributes = {"BestHatchImage", "BestHatchOdds"},
	StylePlayer = function(player)
		local odds = player:GetAttribute("BestHatchOdds")
		if type(odds) ~= "number" or odds < 1000000 then return {} end
		return {
			Title = "Rare hatch collector",
			NameTag = {
				Font = Enum.Font.BuilderSansBold,
				Color = Color3.fromRGB(255, 211, 100),
				Effect = "Shimmer",
			},
		}
	end,
}
