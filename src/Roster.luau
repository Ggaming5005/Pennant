-- Open the Settings child to customize Roster. Start with Roster.Start() in a LocalScript.

-- The model contains editable ScreenGuis. The source-only install rebuilds those same
-- objects from a local Zstandard-compressed JSON capture. Records contain typed Roblox
-- property values, per-class defaults, ordered nodes and selection references.
local function restoreStockTemplate(name)
	if name ~= "StockPlayerList" and name ~= "StockMobilePlayerList" then return nil end
	local encoded = [[
KLUv/WB6VMWAANpitBEm8JLmAUgF4L1hkhYEdGkmACIO2JEj7gz3kKdpy9ScnuJxWBwWpyodARUBEgEVx3k6gMrpXkmry2MOASrn
JdhE8vIMk85JbgzgDYvQizkZc5kRE1uIme9PbKQHJaBsbgF3Ggi8fipJc7qy4H7mHbCkB5YAPECptZjUMimaycVHM4PrBGsO6v+N
MKXVJk86LTNLarIS+ZfgN+Rjl0oJaKgovVQrG5FtwcCsBvDfKms+DwxE8mMsNZbrPNXmXBVEtGdhovw3P7WpPJWRk2klN96AUpPE
H+Gc5/q54kpCN5nyk7wIjkXFZ+hH5DrlzbhaSTclI3xw7cxIzBdUO+lTpmkgsSbN1YNkG+5L1xZkMPd4e6D3k+GcvX4cdi21kgzn
q3X4j0mJZpaTzRWB8zhTVQ+qm5+M9azH8Wtz9BMOxvOYyg2MiIO/ojLjgARUQl8zIWIEvoiziepfKW/FRZynRVjEMnhkWkxUOzNz
RAAiZbSGLbp7PwhCrhd0aToAX+ckNQeOi5A9zpqGpjU0LtP8x1A+z0tRpolEeHoxt/wFdL8YTfpcgyy6O3TvXgquzDJD4PEOAxlP
hvsbSSE6PtaWawdBGNd6apH1MRQOPUDzHnwstvtr74GqfgP13HKkK61FvvaA6KxJ1BbgaqOJxkV2RBJCVgwVjDnnKWUfwsGXizfk
YEy+09KeZ0qkbKV1hlsuOrY8RujFfiDzh2nqtAvfYTeUoizVu7Ib+ZCvdfLGM8iPea3C18kwfZ5QOhE0TxEmElI9yAQuwjalb8BV
Uu5LdFYFFvclU71MSlCRZVSrW4kB8hUw5dCClEELghoD0cgyY+bQ29M8Ky+yyFbD+5n7lPZWi9A9bAS2yIr1qMDYEdapos+t2FqL
EMLn4EZisDXI4F+JTgzItfhWkn4WBsbTabENHZHNmFIh3hBG1s+reyDtgTDvS52SJCEWRXCR2FHnxcAIj5DH4WpKMuJ+vVYykWiO
OXfuLYiiiLA9x1prmGiyW2X5CPWpB8c/PYaSN0Ej3ytEEmE1BkX4GHMN468d0cRUGHPWbC4WgVZDLDNVSkKeR1xjkqLUh/z1YCMp
haeBrfSsEpi7Q/QtkuHprPjyCCQ9i7Clx/gvBJXQ442Nh3b3M1YBYs4TMvGc2GTmTSVQEh7WoPNyHijCIjmSk4/wG2BqBiEhGRlQ
RyjChhF2ZNE1CHvBhp67aPJ6unOjQfjea4f+3GuPSlUq5IqqE+gt5v2eiw66BddzM+MaNqeR/phjrpm79Vyv5aAGxQfv1zqBzzXK
XoNm77XWWrvz5pi3Zs7aan0/8/DUUlmDFp+Q+B5kpSrBXousnep2yCFr586du9egt7c35t6uMcba2WzWIPixB0EtYjwn5v28V2Pe
7u4vMuYZ7csbWxq7H9ivHWv37mYAC2C555prrr3mGmsQWw1ikb2KxubmetAajTXW2Goqb67eQWOSD0X4OjMNqMyzTp4/56u9V6+G
EPQcWmPtkZKwHHL3hMAHgUAHNQZJAYUjqJNII9MxIk0qpeVTUSAUIhBMp1PyruwBUwLxMBKIBOJSIIthEcNgiKWIIooQIiIlIyIy
qjk2A5pU7KuYLAWl/rXPKih9tYOl/yUW5RuW0172VJiVjUgFsfdBarDz/A8VMWYsFw5jM8rmVTS4l6k7htqlp/OUKyb6vARqFXa2
ZkgzWeWSFExEIB7uImLLBpaOnO5W0m0WBTedMsQbVLa0/kuWdgob3mn34iwDTG0sBlvBRN5efrAgfa3J4jbjNrdc9/pwF7xcnBhd
XBu2Ffdu97Kp1HEhTHC4HN8hNh6IJmJRfi7mDCOemkObcMWjeU9M3CuwnttsQC2ysfifDD6ZsylurgzfNNdaBAr0jNvo5czrz7Je
FGlUVvXZn+MjSwsfWZD8rFTrQ7ts9k1D6hC8gkFNytP6jgBw+jOjCalY6jHTeHDzEaG9DpwgAoGHa175maSW+IfY+2ZsGGgS4OyB
gD+yY1C0AhHr3xNEqoEbFwBJj4wG+TqxzwwHFArBj7cMP46Rm3Q4iI76iO9aTFwwggxQYIFkuLkHJ/cPICHYI8rFOx1xq4JMERCZ
dqrxIxAyhe3l3N2JiQIuk4xoEVUjr959iN9E6G1Ibc7cfz+L9qbgPDSgbCv3Oh+NcUx/iT4GdiflTYvmIyfcFgbW5EhFxUQucCmw
MMoq/Ut8OqyILmFQxuPHWTCaG1bKCP1k0ORgYAI9Il8KwdJ5pVZ7C5WBABaxm9kDxbZL5Qly49VfnKeyH/fDzBp5RJBN4TvFH3qX
hmA7ciVCo8DJ3ylmWJJJ3nY1ZdCF0EMo5x7vT7g6w55pbbxkZK6tu1EMKpxM3bjgn9P6Atai0xZetQ7UwrO4/Pcj643LghNZ/NOH
XBW47qZ50Ab0yRfvNxwNaPiOKSLMGOFe/N0p+ZSFSr36xTpWz3aEK5vsWkB+8bEjti0iQV0stX9GDxRTaYlP0wcSQeNMDMceiRPN
TTaF2GdP0rEHG/m5iuVBQZSTd953lRGSx7dYZPfqyScUPayHL6YCIYQZxU39ZM/NbhdM6UJAMxy+hbH94m+H4PFeFMuQjvn3zGIY
Cs1mHz/iVHCJON0mVGodmp/UD0LdjpvnEXNRM9BF3hpZ+PvLVaZCaNZCgxjgSXV+VTnAVYBuYkOut2HCyoijbziBFJXnw54J6qAB
1sE+5bxWHbHPCHIeCsz3qz4ePqsojQeFi0d4ceeacg8lD9udVBzMMZRh7piVsAPFwZsz/xPapguYMBDEZ5wi4sNZNIn4whNKl41z
D9SnEnKv3zYBaadD+NMFuZrZ5TbTU6yW8+1PrFXCtZMXIwmyFQ8oWBnCej+f4RHFqFgpt+VsrF+lLXS33ct1l6lrIuvo6LFHJ7nP
qZ+lNA0QJnL43zvtdWhyYeBLuVTNkEnlKm6zGd2qG7zBNimHl7AnKu6DaFp07bT2mcIKWtCh41hv6Q7UDQvN9hpx5pgdCZVAxq/o
S5Am8oQADca/JIOCwuMCvTgCkfq1VTQdIhInNJ3OQU9J/qcNwg45cVXCjtYs2kO2hT3zXgMlR7OSIVsuB5xihMD/CMU32J8BQ7BI
ceDaNnx6qT+ijKFlI94zIMSmsygC8I4t2WheZmHRHlCJ8VRBthnfkUvPZ6iegtX7hPeGJzCRczz0zTOTxO1GybT5WtcGPnmZkT8E
AYlQsrWA2FG9AtfBImtkH94is0SPBBlIilnEN5CjYQJUUXL/1c8F4tvRwqpQXOODZwVD0nLPuMaIBogF1C7ZL3M8gO2MP7pxMgV8
KyjHTwICGpL4FMaSanruNE7E5bEQqVoZ9yjGQSDSFjIRwSeFgt2DVw/w+HX5+zb3clh3ao8/hEQRmlKaGtxQUSuLkaRUWHj4LF6J
SVnPYch1W+TuobU0JHsmC8R5Cyl9+ChpHZXUzF9F/8n8UR6Oh72RZ82OJrXBkAvgHzl+12+9si+ngLeKAtKqcQmPrDtr1gxPn2uP
oqvgeg3+BgWL/3Ncrt2L2tWLY2KAIG0eeURpkzmAy7Kwd/Cak3ltSIo4/w7uAm9G51e0sMc+AxdNIZXWjMDAJyykBpS1fLxvQa/p
I42KT8hxSZjTmhXTz0qKaZ3wOGM2G3yBG3xd0XWUsedd0XyVLuppxl4KSURsBOQpws7M4GKfMiRjJ9wzE5e+MokDT1eNCjSimq2q
9MyQjWbifjBaC3c0IPfYIpkmbC27eCZMCTagBmh3p3YV1kYyrL1QkVs0bNwooG8uDXTPMHahNimzPl2OdL7boi0btySjdRmarxXt
pxYcyS1rzYdXf80oQEqe61Y0O5+8pGVyRqjbV2rBYSXVC2/qeOinIiyaFifr8Qq8cWhxoP7sIKZ1OYxEQJn9UYoLf0Dmrvv4M4GP
STsbCjy4hStDM3SQb5sVhhhRCYcwLD8W5x18W8MDN44i05ehm7DIJIQBjtA9u/+sAUEwkaYX2y7MvSLgrB3DHiKm9SBJwqHz1I3s
uc+zhZnaqdbInkU5/GSrmi3gWVrXOW0qUijqi1GtBQ4H76qct8xOkPvDRCpDCL0xXK74r0h/tCru36v2SA3tEwPc4S6pYsF/rTdo
cIa8JCa1vTkbZR7q/2C2jQhbnLkyk9hVUPBcAZGa7rAp0lxB0UT3O192CPQrG87Woj8PYWl9qVFqisxBaoJNtypa2d/hLIBSiBbM
eZq9KaLTk/xaY8IIcHAKTys5F+SJTADGMqQ0B2gmYtTTkXOfNB2LoTuEgb6Lxr+EmOHrpvnbTGFJNlOaHWeACg3UA7fy3EHfDt+h
E2bLB85AhkggYX1+JMMmmCCDFidpmrICBZJuFxOla58HxVAKkX6PqqtJlro7rn0u5euCbI+AW3C3qdhqkvqWQMhrmhcJQN3VUHwz
oYC1Z4xvB7WrnKB47bIgemNncOtDS+/C1CTgvSKWoX3vOe6lSgxJ7EwaL8ySzMtzzuhxtziODPF2E/9wBYAzfGW1yJ0fv0rMa8NU
6EmrRg3tJZHltdTpoVUHGCC+6sYRPWqYtzBLZeus/KKLdQaOlqZQNpQ6SNSy4YKt+VJ1bbYfsoUX2TaGPrQbBNh6p2uNkIj4qro+
FPdfs/FdhTGN4OWa71KwWq8u6Er8CKAAhAB7Du5qcwvY3OtRwK0c7oO55wuiWAHl+q5n0LwjKSyF3Cdh/p27mE1JhianM9oj2NH7
ConkRSrnGivKNZPDUILDsiAiNMCJBvIB/QKQZIQPXZj5A4qQJyq9nopvkwDrLK481A4FuhbaA17c0iZLXkCGBjoMnURasbIlN7AX
IPHf8Is5Pu2hX3fIUHpEMAFMGO6GqhhpQDy2zS4NCWo41KBULolmR1sKqVSiWHn9413dLVOq8nFz+f0Tjv7A9F5ImOJpw5QPMR1a
QfHQELReeMSkQJnMnYQuGBBZIxO+2HHBbBPSW8sPwG5LkiTAQym3clETC3zvc9Vi8DJ8CTGy2wZ5Do/0g2nGD+ndEURD/FOV8qkn
gwDdtVI5p78DZbNtw2OUhx+YCFkMb2AtW5IgNy5AmRa524kKsp+2OdJbVeQsdiOzmbOd+YfBjN6AxCZ6ZF05UVPlOIZgJySYnKlQ
E/GcEasAcCoDoGyaGlKIh9cEx8j5sonh0x3ViEXqhoOlUKvDK6QrSqis7dasddAYZt+WuahbZvs9NHMzI4n6XeuICQCcGguaVdZc
aa/6kFn9W7w+8IXW0j8aRoXmniwai66DrBRdkI32FMu3paT9xOUYKdpBsw2PlwfF1VAZ1yOZBwmYq6UKqiQI/i0vbYVQ6q6qKF68
r4AkELvA95DxoJsH4cApegY8EIMoVLEESo2vMoivOz23L1tWneNW9Dx0EYAYvW7gW7snYevF0WpuxW026C87WPhy4tM/r5mOhYFC
HF76QXYAbpV7OosegcU2vZBoPZ7pviAmU3w8YUFEFVFLHCjJZpCM93Sj0m4QnRlF8tyCc82CsNJKxdxqKhdQIsr2hmRfjo6KhZm8
IMoMdAU=
]]
	local encoding = game:GetService("EncodingService")
	local packed = encoding:Base64Decode(buffer.fromstring((encoded:gsub("%s", ""))))
	local json = encoding:DecompressBuffer(packed, Enum.CompressionAlgorithm.Zstd)
	local capture = game:GetService("HttpService"):JSONDecode(buffer.tostring(json))

	local constructors = {
		Color3 = Color3.fromRGB,
		Rect = Rect.new,
		UDim = UDim.new,
		UDim2 = UDim2.new,
		Vector2 = Vector2.new,
		UnboundedSize = function() return Vector2.new(math.huge, math.huge) end,
		Enum = function(enumType, item) return Enum[enumType][item] end,
		Font = function(family, weight, style)
			return Font.new(family, Enum.FontWeight[weight], Enum.FontStyle[style])
		end,
		Content = function(uri) return if uri then Content.fromUri(uri) else Content.none end,
	}
	local values = capture.values
	for index, value in ipairs(values) do
		if type(value) == "table" then
			values[index] = constructors[value[1]](table.unpack(value, 2))
		end
	end

	-- Each node gives its parent index, class, name, optional property overrides and
	-- selection image index. Assign references after every target has been created.
	local nodes = capture.templates[name]
	local instances = table.create(#nodes)
	for index, node in ipairs(nodes) do
		local className, overrides = node[2], node[4]
		local instance = Instance.new(className)
		instance.Name = node[3]
		for property, defaultIndex in pairs(capture.defaults[className]) do
			local valueIndex = if overrides then overrides[property] or defaultIndex else defaultIndex
			instance[property] = values[valueIndex]
		end
		if node[1] ~= 0 then instance.Parent = instances[node[1]] end
		instances[index] = instance
	end
	for index, node in ipairs(nodes) do
		if node[5] then instances[index].SelectionImageObject = instances[node[5]] end
	end
	return instances[1]
end

local function rosterIconSize(value, fallback, maximum)
	if type(value) ~= "number" or not (value > 0 and value < math.huge) then value = fallback end
	if type(value) ~= "number" or not (value > 0 and value < math.huge) then return nil end
	local pixels = math.max(1, math.round(value))
	return if maximum then math.min(pixels, math.max(0, math.floor(maximum))) else pixels
end

-- Omitted options retain the template and existing Start() behavior.
local function configureRoster(input, tabSource)
	local config = table.clone(input or {})
	local iconSizes = if type(config.IconSizes) == "table" then config.IconSizes else {}
	config.IconSizes = {}
	for _, name in ipairs({"Badge", "Stat", "Avatar", "Featured", "Tile"}) do
		config.IconSizes[name] = rosterIconSize(iconSizes[name])
	end
	local features = table.clone(config.Features or {})
	config.Features = features
	if features.Rankings == false then
		features.Global, features.Friends = false, false
	end
	for _, name in ipairs({"Global", "Friends", "Cards", "Badges", "NameEffects", "ItemImages", "AvatarAction", "Trade"}) do
		if features[name] == nil then features[name] = true end
	end
	if features.CardStats ~= nil then config.ShowCardStats = features.CardStats end
	if features.SocialActions ~= nil then config.ShowSocialActions = features.SocialActions end
	if features.Trade == false then config.OnTrade = nil end
	if not features.Cards then
		config.ShowCardStats, config.ShowSocialActions, config.OnTrade = false, false, nil
	end
	if features.Global and features.Friends then return config, tabSource end
	if not features.Global and not features.Friends then
		config.Tabs = {}
		return config, nil
	end

	local function filterTabs(tabs)
		local available = {}
		for _, board in ipairs(tabs or {}) do
			if type(board) == "table" and (features.Global or board.Friends == true) then
				if not features.Friends and board.Friends then
					local copy = table.clone(board)
					copy.Friends = false
					table.insert(available, copy)
				else
					table.insert(available, board)
				end
			end
		end
		return available
	end
	if config.Tabs then
		config.Tabs = filterTabs(config.Tabs)
		return config, nil
	end
	if tabSource then
		local upstream = tabSource
		tabSource = {
			Changed = upstream.Changed,
			Read = function() return filterTabs(upstream.Read()) end,
		}
	end
	return config, tabSource
end

-- Accent only the original surfaces/labels. Hand-authored descendants and
-- the BuilderIcons glyph labels keep the properties set by their creator.
local function applyAppearance(screen, appearance)
	if type(appearance) ~= "table" or next(appearance) == nil then return end
	local surfaceParents = {
		DismissIconFrame = "TopRoundedRect", LegacyTwoTabsTabsRow = "Column", TitleBar = "Column",
		Body = "Column", ["1"] = "BottomRoundedRect", BodyBackground = "Children",
	}
	local rowHeight = appearance.RowHeight
	local setHeight = type(rowHeight) == "number" and rowHeight > 0 and rowHeight < math.huge
	local rowHost = screen:FindFirstChild("TeamList_Neutral", true)
	local templateRow = rowHost and (rowHost:FindFirstChild("PlayerEntry_Template") or rowHost:FindFirstChildWhichIsA("Frame"))
	local button = templateRow and templateRow:FindFirstChild("PlayerEntryContentFrame")
	local nameFrame = templateRow and templateRow:FindFirstChild("NameFrame", true)
	local pinned = screen:FindFirstChild("TitlePlayer", true)
	local pinnedName = pinned and pinned:FindFirstChild("NameFrame", true)
	local face = appearance.FontFace or appearance.Font
	for _, node in ipairs(screen:GetDescendants()) do
		local parent = node.Parent
		local name = node.Name
		if node:IsA("Frame") and surfaceParents[name] == parent.Name then
			if typeof(appearance.SurfaceColor) == "Color3" then node.BackgroundColor3 = appearance.SurfaceColor end
			if type(appearance.SurfaceTransparency) == "number" then
				node.BackgroundTransparency = math.clamp(appearance.SurfaceTransparency, 0, 1)
			end
		elseif node:IsA("TextLabel") then
			local header = parent.Name == "ChildrenFrame" and (name == "playersHeader" or name:sub(1, 5) == "stat_")
			local handle = name == "PlayerName" and parent.Name == "TextContainerFrame"
			local nameOrValue = (name == "PlayerName" and parent.Name == "PlayerName") or name == "PlayerStatDisplay"
				or (name == "TitleText" and parent.Name == "BodyBackground")
				or (name == "DisplayName" and parent.Name == "TextContainerFrame") or (name == "Text" and parent.Name == "HoverBackground")
			if header or handle or nameOrValue then
				local color = if header or handle then appearance.MutedTextColor else appearance.TextColor
				if typeof(color) == "Color3" then node.TextColor3 = color end
				if typeof(face) == "Font" then node.FontFace = face
				elseif typeof(face) == "EnumItem" and face.EnumType == Enum.Font then node.Font = face end
			end
		end
		if setHeight and (node == templateRow or node == button or node == nameFrame or node == pinned or node == pinnedName) then
			local x = node.Size.X
			node.Size = UDim2.new(x.Scale, x.Offset, 0, math.max(1, math.round(rowHeight)))
		end
	end
end

-- Original template artwork. Values are image URIs, also accepted by badge and action settings.
local templateIconAssets = table.freeze({
	Classic = "rbxassetid://87826894403473", -- classic-pennant.png
	Simulator = "rbxassetid://128914419072525", -- simulator-hatch.png
	Competitive = "rbxassetid://139509767660461", -- competitive-chevron.png
	Roleplay = "rbxassetid://79894440258449", -- roleplay-service.png
})
local competitiveCover = "rbxassetid://131659092836215"

local function makeBadgeAtlas(image)
	if type(image) == "number" then
		assert(image > 0 and image < math.huge and image % 1 == 0, "Expected a positive image asset ID")
		image = "rbxassetid://" .. tostring(image)
	end
	assert(type(image) == "string" and image ~= "", "Expected an image asset ID or URI")
	local cellSize = Vector2.new(256, 256)
	local badges = {}
	for index, name in ipairs({"MVP", "VIP", "Creator", "Moderator", "Champion", "Founder"}) do
		local cell = index - 1
		badges[name] = table.freeze({
			Image = image, ImageRectSize = cellSize,
			ImageRectOffset = Vector2.new((cell % 3) * 256, math.floor(cell / 3) * 256),
			Position = "Right", Tooltip = name,
		})
	end
	return table.freeze(badges)
end

-- Presets describe game data and card structure. Callers retain ownership of their tables.
local function withRosterPreset(input)
	local preset = input.Preset
	if preset == nil then return input end
	assert(preset == "Classic" or preset == "Simulator" or preset == "Competitive" or preset == "Roleplay" or preset == "Profile",
		"Unknown Roster.Preset")
	local options = table.clone(input)
	local features = table.clone(input.Features or {})
	options.Features = features
	for _, key in {"Global", "Friends"} do
		if features[key] == nil then features[key] = features.Rankings == true end
	end
	if preset == "Classic" then return options end
	local color = Color3.fromRGB
	local watch = table.clone(options.StyleAttributes or {})
	local function observe(key)
		if not table.find(watch, key) then table.insert(watch, key) end
	end
	options.StyleAttributes = watch
	if options.ShowCardStats == nil then options.ShowCardStats = preset ~= "Profile" end
	local columns
	if preset == "Simulator" then
		columns = {{Id="Rebirths"}, {Id="Eggs"}}
		for _, key in {"Title", "BestHatchImage", "BestHatchOdds"} do observe(key) end
	elseif preset == "Competitive" then
		columns = {{Id="Kills"}, {Id="Deaths"}, {Id="Assists"}}
	elseif preset == "Profile" then
		columns = {}
		observe("PennantFilteredBio")
	else
		columns = {{Id="Job", Attribute="Job", Width=98}, {Id="Department", Attribute="Department", Width=112}}
		if not options.ActionGrid then options.ActionGrid={FillLastRow=true} end
		observe("Callsign")
	end
	options.Columns = options.Columns or columns
	local stylePlayer = options.StylePlayer
	options.StylePlayer = function(player)
		local title, base
		if preset == "Simulator" then
			title = player:GetAttribute("Title")
			local odds = player:GetAttribute("BestHatchOdds")
			base = {BackgroundColor=color(28,26,33), BannerColor=color(98,31,40),
				AvatarRingColor=color(210,200,194), FeaturedImage=player:GetAttribute("BestHatchImage"),
				FeaturedText=if odds then "1/" .. tostring(odds) else nil}
		elseif preset == "Profile" then
			base = {HeaderLayout="Profile", BannerImage=competitiveCover, BackgroundColor=color(23,29,38),
				BannerColor=color(30,38,50), AvatarBackgroundColor=color(24,32,44), AvatarRingColor=color(93,111,137)}
		elseif preset == "Competitive" then
			local team = player.Team
			title = if team then team.Name else nil
			local accent = if team then team.TeamColor.Color else color(149,178,202)
			base = {BackgroundColor=color(43,43,55), BannerColor=color(37,42,55), HeaderLayout="Match", Emblem=false,
				AccentColor=accent, AvatarBackgroundColor=color(49,67,91), AvatarRingColor=accent:Lerp(color(158,180,209),0.75)}
		else
			title = player:GetAttribute("Callsign")
			base = {BackgroundColor=color(28,36,36), BannerColor=color(40,53,51),
				AccentColor=color(168,222,198), AvatarBackgroundColor=color(48,70,61),
				AvatarRingColor=color(144,181,160), TitleColor=color(178,218,196)}
		end
		local supplied = if stylePlayer then stylePlayer(player) else nil
		local style = if type(supplied) == "table" then table.clone(supplied) else {}
		if style.Title == nil then style.Title = title end
		if style.Card == false then return style end
		if type(style.Card) == "table" then
			for key,value in pairs(style.Card) do base[key] = value end
		end
		style.Card = base
		return style
	end
	return options
end

-- Reflow the native card's identity and data cells. Undo touched properties before
-- borrowing the same card for another selection (including an offline ranking).
local function createGenreLayout(header, stats, role, presentation)
	local banner, avatar = header.Background, header.AvatarImage
	local identity = banner.TextContainerFrame
	local saved = {}
	local cover = Instance.new("ImageLabel")
	cover.Name, cover.BackgroundTransparency, cover.Visible = "ProfileCover", 1, false
	cover.ScaleType, cover.Parent = Enum.ScaleType.Crop, banner
	local coverCorner = Instance.new("UICorner")
	coverCorner.CornerRadius, coverCorner.Parent = UDim.new(0,4), cover
	local function set(node, property, value)
		if node[property] == value then return end
		local properties = saved[node]
		if not properties then properties = {}; saved[node] = properties end
		if properties[property] == nil then properties[property] = node[property] end
		node[property] = value
	end
	local function reset()
		for node, properties in pairs(saved) do
			for key, value in pairs(properties) do node[key] = value end
		end
		table.clear(saved)
		cover.Visible = false
	end
	local function apply(preset, spec, width, tiles, count, large)
		local arena = preset == "Competitive"
		if arena and spec.HeaderLayout == "Match" and presentation then
			presentation.match(header, stats, role, cover, spec, width, tiles, count, large, set)
			return
		end
		local left = Enum.TextXAlignment.Left
		local accent = spec.AccentColor or spec.TitleColor or Color3.fromRGB(216,230,238)
		local profile = (preset == "Profile" or (arena and spec.HeaderLayout == "Profile")) and banner.Image ~= "" and spec.HeaderLayout ~= "Compact"
		local height = if profile then (if large then 116 else 100) elseif arena then (if large then 78 else 65) else (if large then 93 else 79)
		local portrait = math.min(avatar.Size.X.Offset, height-14)
		local portraitX = if arena and not profile then width-portrait-15 else 14
		set(header, "Size", UDim2.new(1,0,0,height+11))
		set(banner, "Size", UDim2.new(1,-12,0,height))
		set(avatar,"Position",UDim2.fromOffset(portraitX,if profile then 43 else 5+height/2))
		set(avatar,"Size",UDim2.fromOffset(portrait,portrait))
		local start = if (arena and not profile) or not avatar.Visible then 13 else portrait+17
		local finish = if arena and not profile and avatar.Visible then portrait+16 else 8
		local inset = if profile then 35 else 0
		set(identity,"Position",UDim2.fromOffset(start,inset))
		set(identity,"Size",UDim2.new(1,-start-finish,1,-inset))
		if profile then
			cover.Position = UDim2.fromScale(0,0)
			cover.Image, cover.ImageColor3, cover.ImageTransparency = banner.Image, banner.ImageColor3, banner.ImageTransparency
			cover.Size, cover.Visible = UDim2.new(1,0,0,32), cover.Image ~= ""
			set(banner,"ImageTransparency",1)
			set(role,"LayoutOrder",3)
		elseif arena then
			set(role,"LayoutOrder",0)
		end
		for _, key in {"FeaturedImage","FeaturedText"} do
			local node = banner:FindFirstChild(key)
			if node then set(node,"Visible",false) end
		end
		if count == 0 then return end
		local line = if large then 33 else 29
		set(stats,"Size",UDim2.new(1,0,0,if arena then (if large then 62 else 54) else count*line+8))
		for i=1,count do
			local tile = tiles[i]
			set(tile.pic,"Visible",false)
			set(tile.outline,"Enabled",false)
			if arena then
				set(tile.cell,"Position",UDim2.new((i-1)/count,5,0,3))
				set(tile.cell,"Size",UDim2.new(1/count,-10,1,-6))
				set(tile.cell,"BackgroundTransparency",1)
				set(tile.value,"Position",UDim2.fromOffset(0,0))
				set(tile.value,"Size",UDim2.new(1,0,1,-16))
				set(tile.value,"TextSize",if large then 24 else 21)
				set(tile.value,"FontFace",Font.fromEnum(Enum.Font.BuilderSansBold))
				set(tile.caption,"Position",UDim2.new(0,0,1,-17))
				set(tile.caption,"Size",UDim2.new(1,0,0,16))
				set(tile.caption,"TextXAlignment",Enum.TextXAlignment.Center)
				set(tile.caption,"TextColor3",accent)
			else
				set(tile.cell,"Position",UDim2.fromOffset(6,4+(i-1)*line))
				set(tile.cell,"Size",UDim2.new(1,-12,0,line-1))
				set(tile.cell,"BackgroundTransparency",if i%2==1 then 0.3 else 1)
				set(tile.caption,"Position",UDim2.fromOffset(8,0))
				set(tile.caption,"Size",UDim2.new(0.41,-8,1,0))
				set(tile.caption,"TextXAlignment",left)
				set(tile.caption,"TextSize",if large then 14 else 12)
				set(tile.value,"Position",UDim2.new(0.41,2,0,0))
				set(tile.value,"Size",UDim2.new(0.59,-10,1,0))
				set(tile.value,"TextXAlignment",Enum.TextXAlignment.Right)
			end
		end
	end
	return {reset=reset, apply=apply}
end

local baseActions = {"Trade", "Friend", "Avatar", "Block"}
local actionArt = table.freeze({Loadout="rbxassetid://82813232808526", Inspect="rbxassetid://120396119214414", Highlights="rbxassetid://77199131926973"})
local presetActions = {
	Profile = {"Avatar", "Friend", "Block"},
	Simulator = {{Id="Trade", Color=Color3.fromRGB(54,91,218)}, "Friend", "Avatar", "Block"},
	Competitive = {"Spectate", "Friend", "Avatar", "Block"},
	Roleplay = {"ShowID", "Friend", "Avatar", "Block"},
}

local function actionNumber(value, fallback, low, high)
	return if type(value)=="number" and value==value and math.abs(value)<math.huge then math.clamp(math.round(value),low,high) else fallback
end

local function actionCells(actions, width, grid, touch, finish)
	local pad = math.min(6,math.max(0,math.floor((width-1)/2)))
	local gap = actionNumber(grid.Gap,4,0,24)
	local available = math.max(1,width-2*pad)
	local columns = math.min(actionNumber(grid.Columns,2,1,6),
		math.max(1,math.floor((available+gap)/(actionNumber(grid.MinCellWidth,84,44,300)+gap))))
	local height = math.max(if touch then 44 else 28,actionNumber(grid.RowHeight,44,28,96))
	local nextCol, line = 0,0
	local cells = {}
	for i, action in ipairs(actions) do
		local span = if action.Span=="Full" or (#actions==1 and action.Span==nil) then columns
			elseif action.Span=="Wide" then math.max(1, columns-1)
			else actionNumber(action.Span,1,1,columns)
		if nextCol>0 and (action.BreakBefore==true or nextCol+span>columns) then nextCol,line=0,line+1 end
		if grid.FillLastRow == true and i == #actions and action.Span == nil then span=columns-nextCol end
		local x = math.floor(nextCol*(available+gap)/columns)
		local edge = math.floor((nextCol+span)*(available+gap)/columns)-gap
		cells[i] = {x=pad+x,y=4+line*(height+gap),width=edge-x,height=height}
		nextCol+=span
	end
	return cells, if #actions>0 then (line+1)*height+line*gap+4+(if finish then gap else 4) else 0
end

local function actionAllowed(def, viewer, target, defaultAudience)
	local audience = def.Audience or defaultAudience
	if target == nil then return false end
	if audience == "Self" then
		if target ~= viewer then return false end
	elseif audience ~= "Both" then
		if audience ~= nil and audience ~= "Other" then return false end
		if target == viewer then return false end
	end
	if def.When ~= nil then
		if type(def.When)~="function" then return false end
		local ok, show = pcall(def.When,viewer,target)
		return ok and show == true
	end
	return true
end

local function createRosterActionLayout(config, inner, builtins, activate, getTarget, viewer, presentation)
	local inspect = builtins.Avatar
	local template = inspect:Clone()
	local panel = Instance.new("Frame")
	panel.Name,panel.LayoutOrder,panel.BackgroundTransparency,panel.Visible,panel.Parent = "CardActions",5,1,false,inner
	local saved, custom, delegated, active = {},{},{},{}
	local pressed, builtInConnections, captions = setmetatable({}, {__mode="k"}),{},{}
	local feedback, services, finish = {},nil,false
	local revision, destroyed = 0,false
	local glyphs = {Trade="⇄",Friend="+",Block="⊘",Spectate="◉",ShowID="≡"}
	local function remember(node, keys)
		local values={}
		for _,key in ipairs(keys) do values[key]=node[key] end
		saved[node]=values
	end
	local function dropTween(state)
		if state.tween then state.tween:Cancel();state.tween:Destroy();state.tween=nil end
	end
	local function usingMouse()
		return services.input.PreferredInput==Enum.PreferredInput.KeyboardAndMouse and services.input:GetLastInputType()~=Enum.UserInputType.Touch
	end
	local function reflect(node,state,snap)
		if not state.enabled then return end
		local preferred=services.input.PreferredInput
		local focus=services.gui.SelectedObject==node and preferred~=Enum.PreferredInput.Touch
		local alpha=if state.pointer then state.pressAlpha elseif focus then state.focusAlpha
			elseif state.inside and usingMouse() then state.hoverAlpha else 1
		if not snap and state.goal==alpha then return end
		dropTween(state)
		state.goal=alpha
		local overlay=node.HoverBackground
		overlay.ImageColor3=state.color
		if snap or state.pointer or services.gui.ReducedMotionEnabled or overlay.ImageTransparency==alpha then
			overlay.ImageTransparency=alpha
		else
			state.tween=services.tweens:Create(overlay,services.fade,{ImageTransparency=alpha})
			state.tween:Play()
		end
	end
	local function cancelPress(state)
		if state.pointer then
			local press=pressed[state.pointer]
			if press then press.cancelled=true end
			state.cancelledKind=state.pointer.UserInputType
			state.pointer=nil
		end
	end
	local function clearInteraction()
		for node,state in pairs(feedback) do
			cancelPress(state)
			state.inside,state.goal,state.target,state.key=false,nil,nil,nil
			dropTween(state)
			if state.enabled then node.HoverBackground.ImageTransparency=1 end
			state.enabled=false
		end
	end
	local function begin(node,pointer)
		local target,key=getTarget()
		pressed[pointer]={node=node,target=target,key=key}
		local state=feedback[node]
		if not state or not state.enabled or not node.Visible then return end
		local kind=pointer.UserInputType
		if kind~=Enum.UserInputType.Touch and kind~=Enum.UserInputType.MouseButton1 and pointer.KeyCode~=Enum.KeyCode.ButtonA then return end
		if kind==Enum.UserInputType.Touch then state.inside=false end
		state.pointer,state.cancelledKind=pointer,nil
		reflect(node,state,false)
	end
	local function trackPress(node)
		return node.InputBegan:Connect(function(pointer) begin(node,pointer) end)
	end
	local function enableServices()
		if services then return end
		local input=game:GetService("UserInputService")
		local gui=game:GetService("GuiService")
		services={input=input,gui=gui,tweens=game:GetService("TweenService"),fade=TweenInfo.new(0.09,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)}
		local function on(signal,fn) table.insert(builtInConnections,signal:Connect(fn)) end
		on(input.InputBegan,function(pointer)
			-- The next physical press clears cancelled drag state.
			for _,state in pairs(feedback) do
				if state.cancelledKind==pointer.UserInputType then state.cancelledKind=nil end
			end
			local node=gui.SelectedObject
			if pointer.KeyCode==Enum.KeyCode.ButtonA and node and feedback[node] and feedback[node].enabled then begin(node,pointer) end
		end)
		on(input.InputEnded,function(pointer)
			local record=pressed[pointer]
			local state=record and feedback[record.node]
			if state and state.pointer==pointer then state.pointer=nil;reflect(record.node,state,false);return end
			if pointer.UserInputType==Enum.UserInputType.MouseButton1 or pointer.KeyCode==Enum.KeyCode.ButtonA then
				for node,s in pairs(feedback) do
					if s.pointer and s.pointer.UserInputType==pointer.UserInputType and s.pointer.KeyCode==pointer.KeyCode then
						s.pointer=nil;reflect(node,s,false)
					end
				end
			end
		end)
		on(input.TouchMoved,function(pointer)
			local start=pressed[pointer]
			local state=start and feedback[start.node]
			if not state or state.pointer~=pointer then return end
			local node=start.node
			local p,origin,size=pointer.Position,node.AbsolutePosition,node.AbsoluteSize
			if p.X<origin.X or p.Y<origin.Y or p.X>=origin.X+size.X or p.Y>=origin.Y+size.Y then
				cancelPress(state)
				reflect(node,state,false)
			end
		end)
		on(input.WindowFocusReleased,function()
			for node,state in pairs(feedback) do
				cancelPress(state);state.inside=false
				reflect(node,state,true)
			end
		end)
		local function sync()
			for node,state in pairs(feedback) do
				if state.pointer and state.pointer.KeyCode==Enum.KeyCode.ButtonA and gui.SelectedObject~=node then cancelPress(state) end
				if input.PreferredInput~=Enum.PreferredInput.KeyboardAndMouse then state.inside=false end
				reflect(node,state,false)
			end
		end
		on(gui:GetPropertyChangedSignal("SelectedObject"),sync)
		on(input:GetPropertyChangedSignal("PreferredInput"),sync)
		on(gui:GetPropertyChangedSignal("ReducedMotionEnabled"),function()
			for node,state in pairs(feedback) do reflect(node,state,true) end
		end)
	end
	local function disableFeedback(node,forget)
		local state=feedback[node]
		if not state then return end
		cancelPress(state);dropTween(state)
		state.enabled,state.inside,state.goal,state.target,state.key=false,false,nil,nil,nil
		if forget then
			state.enter:Disconnect();state.leave:Disconnect()
			feedback[node]=nil
		end
	end
	for id,node in pairs(builtins) do
		local content=node.HoverBackground
		captions[id]=content.Text.Text
		table.insert(builtInConnections,trackPress(node))
		remember(node,{"Parent","Position","Size","LayoutOrder","ImageColor3","ImageTransparency","AutoButtonColor","Selectable"})
		remember(content,{"ImageColor3","ImageTransparency"})
		remember(content.Icon,{"Size","Image","ImageRectOffset","ImageRectSize","Visible","LayoutOrder","ImageColor3","ImageTransparency","ScaleType","ZIndex"})
		remember(content.Text,{"Size","AutomaticSize","TextSize","TextXAlignment","TextTruncate","LayoutOrder","ZIndex"})
		remember(content.ListLayout,{"FillDirection","HorizontalAlignment","VerticalAlignment","Padding","SortOrder"})
		remember(content.InitalPadding,{"PaddingLeft"})
	end
	local function permitted(id,node,pointer)
		local binding=delegated[id]
		if destroyed or not binding or not node.Visible then return false end
		local state=feedback[node]
		if node.Parent==panel and state and (not state.enabled or (pointer and state.cancelledKind~=nil and state.cancelledKind==pointer.UserInputType)) then return false end
		local current,key=getTarget()
		local start=if pointer then pressed[pointer] else nil
		if start and (start.cancelled or start.node~=node or start.target~=current or start.key~=key) then return false end
		if current~=binding.target or key~=binding.key then return false end
		if binding.gated and not actionAllowed(binding.spec,viewer,current,if id=="Avatar" then "Both" else nil) then return false end
		local latest,latestKey=getTarget()
		return not destroyed and delegated[id]==binding and node.Visible and current==latest and key==latestKey
	end
	local function customButton(id)
		if custom[id] then return custom[id] end
		local node=template:Clone()
		node.Name,node.Visible,node.Parent="Action_"..id,false,panel
		trackPress(node)
		activate(node,function(pointer)
			if custom[id]==node and permitted(id,node,pointer) then
				local binding=delegated[id]
				binding.callback(binding.target,viewer)
			end
		end)
		custom[id]=node
		return node
	end
	local function media(def,grid)
		local id=def.Id
		local image,emoji=def.Icon,def.Emoji
		if image==nil and emoji==nil then
			local icons=config.ActionIcons or {}
			image=icons[id]
			if image==nil and finish and id=="Avatar" then image=icons.Inspect end
			if image==nil then image,emoji=grid.Icon,grid.Emoji end
			if finish and image==nil and emoji==nil then image=actionArt[if id=="Avatar" then "Inspect" else id] end
		end
		if type(emoji)=="string" and emoji~="" then return nil,emoji end
		if type(image)=="number" and image>0 and image<math.huge then image="rbxassetid://"..tostring(image) end
		if type(image)=="string" and image~="" then return image,nil end
		if image~=nil or emoji~=nil then return nil,nil end
		local native=if id=="Avatar" then saved[inspect.HoverBackground.Icon] else nil
		if native and native.Visible then return native.Image,nil,native end
		return nil,glyphs[id]
	end
	local function opacity(value,fallback)
		return if type(value)=="number" and value==value then math.clamp(value,0,1) else fallback
	end
	local function skin(node,def,grid,target,key)
		enableServices()
		local state=feedback[node]
		if not state then
			state={}
			feedback[node]=state
			state.enter=node.MouseEnter:Connect(function()
				if state.enabled and usingMouse() then
					state.inside=true;reflect(node,state,false)
				end
			end)
			state.leave=node.MouseLeave:Connect(function()
				state.inside=false
				if state.pointer and state.pointer.UserInputType==Enum.UserInputType.MouseButton1 then cancelPress(state) end
				reflect(node,state,false)
			end)
		end
		local rebound=not state.enabled or state.target~=target or state.key~=key
		if rebound then
			cancelPress(state)
			state.inside=node.GuiState==Enum.GuiState.Hover and usingMouse()
		end
		local color=if typeof(def.HighlightColor)=="Color3" then def.HighlightColor
			elseif typeof(grid.HighlightColor)=="Color3" then grid.HighlightColor else Color3.fromRGB(208,217,251)
		local recolor=state.color~=color
		state.color,state.target,state.key,state.enabled=color,target,key,true
		state.hoverAlpha=opacity(def.HoverTransparency,opacity(grid.HoverTransparency,0.92))
		state.focusAlpha=opacity(def.FocusTransparency,opacity(grid.FocusTransparency,0.88))
		state.pressAlpha=opacity(def.PressTransparency,opacity(grid.PressTransparency,0.88))
		node.AutoButtonColor,node.Selectable=false,true
		reflect(node,state,rebound or recolor)
	end
	local function decoration(parent,class,name)
		local art=Instance.new(class)
		art.Name,art.BackgroundTransparency,art.BorderSizePixel=name,1,0
		art.Active,art.Selectable,art.Interactable=false,false,false
		if class=="TextLabel" then
			art.Font,art.AutoLocalize,art.RichText=Enum.Font.BuilderSansBold,false,false
			art.TextWrapped,art.TextXAlignment,art.TextYAlignment=false,Enum.TextXAlignment.Center,Enum.TextYAlignment.Center
		end
		art.Parent=parent
		return art
	end
	local function drawMedia(pic,glyph,image,symbol,native,size,tint,alpha)
		if pic then
			pic.Visible,pic.Image=image~=nil,image or ""
			pic.ImageRectOffset,pic.ImageRectSize=if native then native.ImageRectOffset else Vector2.zero,if native then native.ImageRectSize else Vector2.zero
			pic.ImageColor3,pic.ImageTransparency,pic.ScaleType=tint,alpha,if native and native.ScaleType then native.ScaleType else Enum.ScaleType.Fit
			pic.Size=UDim2.fromOffset(size,size)
		end
		if glyph then
			glyph.Visible,glyph.Text,glyph.TextSize=symbol~=nil,symbol or "",size
			glyph.TextColor3,glyph.TextTransparency,glyph.Size=tint,alpha,UDim2.fromOffset(size,size)
		end
	end
	local function hideWatermark(node)
		local slot=node:FindFirstChild("ActionWatermark")
		if not slot or not slot.Visible then return end
		slot.Visible=false
		local image=slot:FindFirstChild("Art")
		local emoji=slot:FindFirstChild("Emoji")
		if image then image.Visible,image.Image=false,"" end
		if emoji then emoji.Visible,emoji.Text=false,"" end
	end
	local function watermark(node,image,symbol,native,size,tint,alpha,align,width,height)
		local slot=node:FindFirstChild("ActionWatermark") or decoration(node,"Frame","ActionWatermark")
		slot.Visible,slot.ClipsDescendants=true,true
		slot.ZIndex=math.max(1,node.HoverBackground.ZIndex-1)
		local corner=node:FindFirstChildWhichIsA("UICorner")
		local short=math.min(width,height)
		local radius=if corner then math.clamp(corner.CornerRadius.Scale*short+corner.CornerRadius.Offset,0,short/2) else 4
		local inset=math.min(math.ceil(radius*(1-math.sqrt(0.5))),math.floor((short-1)/2))
		slot.Position,slot.Size=UDim2.fromOffset(inset,inset),UDim2.new(1,-2*inset,1,-2*inset)
		local pic=slot:FindFirstChild("Art")
		local glyph=slot:FindFirstChild("Emoji")
		if image and not pic then pic=decoration(slot,"ImageLabel","Art") end
		if symbol and not glyph then glyph=decoration(slot,"TextLabel","Emoji") end
		drawMedia(pic,glyph,image,symbol,native,size,tint,alpha)
		local x=if align=="Left" then 0 elseif align=="Right" then 1 else 0.5
		local art=if image then pic else glyph
		art.ZIndex,art.AnchorPoint,art.Position=slot.ZIndex,Vector2.new(x,0.5),UDim2.fromScale(x,0.5)
	end
	local function paint(node,def,grid,position,bg,width,height,large)
		local content=node.HoverBackground
		local pic,text,layout=content.Icon,content.Text,content.ListLayout
		local behind=position=="Behind"
		local vertical=position=="Top" and height>=40
		local image,symbol,native=media(def,grid)
		local alpha=opacity(def.IconTransparency,opacity(grid.IconTransparency,if behind then 0.8 else 0))
		local tint=if typeof(def.IconColor)=="Color3" then def.IconColor elseif typeof(grid.IconColor)=="Color3" then grid.IconColor
			elseif symbol then text.TextColor3 else Color3.new(1,1,1)
		local defaultSize=if behind then math.ceil(height*1.35) else 17
		local size=actionNumber(def.IconSize,actionNumber(grid.IconSize,defaultSize,1,256),1,256)
		if not behind then
			local room=if vertical then math.min(width-8,height-22) else math.min(height-4,width-13-math.min(42,math.floor(width*0.4)))
			size=math.min(size,math.max(0,room))
		end
		if size<=0 or alpha>=1 then image,symbol=nil,nil end
		if behind and (image or symbol) then
			watermark(node,image,symbol,native,size,tint,alpha,def.IconAlign or grid.IconAlign,width,height)
		else hideWatermark(node) end
		local glyph=content:FindFirstChild("ActionGlyph")
		if symbol and not behind and not glyph then glyph=decoration(content,"TextLabel","ActionGlyph") end
		drawMedia(pic,glyph,if behind then nil else image,if behind then nil else symbol,native,math.max(1,size),tint,alpha)
		local artOrder=if position=="Right" then 3 else 1
		pic.LayoutOrder=artOrder
		pic.ZIndex=content.ZIndex+1
		if glyph then glyph.LayoutOrder,glyph.ZIndex=artOrder,content.ZIndex+1 end
		content.InitalPadding.PaddingLeft=UDim.new()
		layout.FillDirection=if vertical then Enum.FillDirection.Vertical else Enum.FillDirection.Horizontal
		layout.SortOrder,layout.HorizontalAlignment,layout.VerticalAlignment=Enum.SortOrder.LayoutOrder,Enum.HorizontalAlignment.Center,Enum.VerticalAlignment.Center
		layout.Padding=UDim.new(0,if vertical then 1 else 5)
		text.AutomaticSize,text.LayoutOrder,text.ZIndex=Enum.AutomaticSize.None,2,content.ZIndex+1
		text.TextSize,text.TextTruncate,text.TextXAlignment=13,Enum.TextTruncate.AtEnd,Enum.TextXAlignment.Center
		local room=width-8-(if not behind and not vertical and (image or symbol) then size+5 else 0)
		local textWidth=math.min(math.max(1,room),math.max(28,math.ceil(text.TextBounds.X)+5,(utf8.len(text.Text) or #text.Text)*8))
		if behind or vertical then textWidth=math.max(1,width-8) end
		text.Size=UDim2.fromOffset(textWidth,17)
		node.ImageTransparency,node.ImageColor3=0,if typeof(def.Color)=="Color3" then def.Color else bg
		if presentation then presentation.finishAction(node,def,finish,room,vertical,behind,large) end
	end
	local styled=false
	local function update(spec, width, target, touch, large)
		revision+=1
		local generation=revision
		local _,key=getTarget()
		local grid=table.clone(config.ActionGrid or {})
		for key,value in pairs((spec and spec.ActionGrid) or {}) do grid[key]=value end
		local defaults
		if presentation then finish,defaults=presentation.actionOptions(config,grid) end
		local definitions=(spec and spec.Actions) or config.Actions or defaults or presetActions[config.Preset] or baseActions
		local modern=spec~=nil or config.Actions~=nil or config.ActionGrid~=nil or presetActions[config.Preset]~=nil
		table.clear(delegated)
		if not modern then
			for _,node in pairs(custom) do node.Visible=false end
			if styled then
				clearInteraction()
				for node,props in pairs(saved) do for key,value in pairs(props) do node[key]=value end end
				for id,node in pairs(builtins) do
					hideWatermark(node)
					if presentation then presentation.finishAction(node,{},false) end
					local glyph=node.HoverBackground:FindFirstChild("ActionGlyph")
					if glyph then glyph.Visible=false end
					if id~="Friend" and id~="Block" then node.HoverBackground.Text.Text=captions[id] end
				end
			end
			styled,panel.Visible=false,false
			local height=0
			for id,node in pairs(builtins) do
				if node.Visible then
					height+=node.Size.Y.Offset
					delegated[id]={target=target,key=key}
				end
			end
			return height
		end
		styled=true
		if large then grid.RowHeight=math.max(50,actionNumber(grid.RowHeight,44,28,96)) end
		local allowed={}
		for id,node in pairs(builtins) do allowed[id]=node.Visible end
		local ordered,seen={},{}
		table.clear(active)
		for _,entry in ipairs(definitions) do
			local def=if type(entry)=="string" then {Id=entry} else entry
			if type(def)~="table" or type(def.Id)~="string" or seen[def.Id] then continue end
			local id=def.Id
			seen[id]=true
			local node=builtins[id]
			local callback
			local gated=not node or def.Audience~=nil or def.When~=nil
			if node then
				if not allowed[id] then continue end
			else
				callback=def.OnActivated or (if id=="Spectate" then config.OnSpectate elseif id=="ShowID" then config.OnShowID else nil)
				if type(callback)~="function" then continue end
			end
			local eligible=not gated or actionAllowed(def,viewer,target,if id=="Avatar" then "Both" else nil)
			local latest,latestKey=getTarget()
			if generation~=revision or target~=latest or key~=latestKey then return if panel.Visible then panel.Size.Y.Offset else 0 end
			if not eligible then continue end
			if not node then node=customButton(id) end
			delegated[id]={spec=def,target=target,key=key,callback=callback,gated=gated}
			local caption=if id=="Avatar" then "View Avatar" elseif id=="ShowID" then "Show ID" else id
			if id~="Friend" and id~="Block" or def.Label then node.HoverBackground.Text.Text=def.Label or caption end
			node.Visible,node.Parent=true,panel
			table.insert(ordered,def)
			table.insert(active,node)
		end
		local cells,height=actionCells(ordered,math.max(1,width+inner.Size.X.Offset),grid,touch,finish)
		local base=if spec and typeof(spec.BackgroundColor)=="Color3" then spec.BackgroundColor else Color3.fromRGB(27,28,34)
		for i,node in ipairs(active) do
			local cell,def=cells[i],ordered[i]
			node.Position,node.Size=UDim2.fromOffset(cell.x,cell.y),UDim2.fromOffset(cell.width,cell.height)
			local position=def.IconPosition or grid.IconPosition or (if config.Preset=="Simulator" and #active>1 then "Top" else "Left")
			paint(node,def,grid,position,base:Lerp(Color3.new(1,1,1),0.07),cell.width,cell.height,large)
			skin(node,def,grid,target,key)
		end
		for id,node in pairs(builtins) do
			if not delegated[id] then node.Visible=false;disableFeedback(node,false) end
		end
		panel.Size,panel.Visible=UDim2.new(1,0,0,height),height>0
		for id,node in pairs(custom) do
			if not delegated[id] then
				node.Visible=false
				disableFeedback(node,not seen[id])
				if not seen[id] then node:Destroy(); custom[id]=nil end
			end
		end
		return height
	end
	return {update=update, clearInteraction=clearInteraction, allowsBuiltin=function(id,pointer)
		return builtins[id]~=nil and permitted(id,builtins[id],pointer)
	end, destroy=function()
		destroyed=true
		revision+=1
		for _,connection in ipairs(builtInConnections) do connection:Disconnect() end
		table.clear(delegated)
		table.clear(pressed)
		for node in pairs(feedback) do disableFeedback(node,true) end
		template:Destroy()
	end}
end

-- The native label retains the complete name, its layout, and its input behavior.
-- All decorative lettering lives inside a clipped, noninteractive child.
local function createRosterNameEffects(settings, guiService, runService)
	settings = if type(settings) == "table" then settings else {}
	local function number(value, default, low, high)
		return if typeof(value) == "number" and value == value and math.abs(value) < math.huge
			then math.clamp(value, low, high) else default
	end
	local interval = 1 / number(settings.FPS, 24, 5, 60)
	local capacity = math.floor(number(settings.MaxAnimatedNames, 6, 0, 32))
	local glyphLimit = math.floor(number(settings.MaxGlyphs, 14, 0, 32))
	local tau = math.pi * 2
	local white = Color3.new(1, 1, 1)
	local rainbow = {
		Color3.fromRGB(255, 153, 172), Color3.fromRGB(255, 221, 143), Color3.fromRGB(138, 237, 196),
		Color3.fromRGB(135, 202, 255), Color3.fromRGB(192, 159, 255), Color3.fromRGB(255, 153, 172),
	}
	local records, legacy, ticking = {}, {}, {}
	local opened, destroyed, queued = false, false, false
	local heartbeat, serial, elapsed, phaseTime = nil, 0, 0, 0

	local function sample(stops, x)
		x = math.clamp(x, 0, 1)
		for i = 2, #stops do
			local a, b = stops[i - 1], stops[i]
			if x <= b.Time then
				return a.Value:Lerp(b.Value, math.clamp((x - a.Time) / math.max(b.Time - a.Time, 0.00001), 0, 1))
			end
		end
		return stops[#stops].Value
	end
	local function palette(colors, defaults)
		if typeof(colors) == "ColorSequence" then
			local stops = colors.Keypoints
			if #stops <= 6 then return colors end
			local reduced = {}
			for i = 0, 5 do reduced[i + 1] = ColorSequenceKeypoint.new(i / 5, sample(stops, i / 5)) end
			return ColorSequence.new(reduced)
		end
		local values = {}
		if type(colors) == "table" then
			for _, value in ipairs(colors) do
				if typeof(value) == "Color3" then table.insert(values, value) end
				if #values == 6 then break end
			end
		end
		if #values == 0 then values = defaults end
		if #values == 1 then return ColorSequence.new(values[1]) end
		local stops = {}
		for i, value in ipairs(values) do
			stops[i] = ColorSequenceKeypoint.new((i - 1) / (#values - 1), value)
		end
		return ColorSequence.new(stops)
	end
	local glacier = {Color3.fromRGB(83, 201, 234), Color3.fromRGB(221, 216, 255), Color3.fromRGB(171, 118, 238)}
	local colorModes = {Cycle=true, Rainbow=true, Shimmer=true, Gradient=true, MovingGradient=true}
	local mirroredTiles
	local function supportsMirroredTiles()
		if mirroredTiles == nil then
			local probe = Instance.new("UIGradient")
			mirroredTiles = pcall(function()
				probe.TileMode = Enum.GradientTileMode.Mirror
				probe.Scale = 1
			end)
			probe:Destroy()
		end
		return mirroredTiles
	end
	local function describe(spec, label)
		local definition = if type(spec) == "table" then spec else {Preset = spec}
		local preset = definition.Preset
		local motion = definition.Motion or preset
		if motion ~= "Wave" and motion ~= "Glitch" then motion = nil end
		local mode = definition.ColorMode or (if colorModes[preset] then preset else nil)
		if not colorModes[mode] then mode = nil end
		if mode == nil and definition.Colors then mode = "Gradient" end
		if not motion and not mode then return nil end
		local color = label.TextColor3
		local edge = color:Lerp(Color3.new(0, 0, 0), 0.22)
		local defaults = if mode == "MovingGradient" then glacier elseif mode == "Rainbow" or mode == "Cycle" then rainbow
			elseif mode == "Shimmer" then {edge, color:Lerp(white, 0.8), edge} else {color}
		local colors = palette(definition.Colors, defaults)
		if mode == "MovingGradient" and not supportsMirroredTiles() then mode = "Gradient" end
		local direction = definition.Direction
		return {
			motion = motion, mode = mode, colors = colors, stops = colors.Keypoints,
			dynamic = motion ~= nil or (mode ~= nil and mode ~= "Gradient"),
			speed = number(definition.Speed, 1, 0, 4), amplitude = number(definition.Amplitude, 2, 0, 6),
			frequency = number(definition.Frequency, 1, 0.2, 4), phase = number(definition.Phase, 0, -100, 100),
			rotation = number(definition.Rotation, 0, -360, 360),
			vertical = direction == "Up" or direction == "Down",
			travel = if direction == "Left" or direction == "Up" then -1 else 1,
			bandWidth = number(definition.BandWidth, 1, 0.25, 1),
			shadowA = if typeof(definition.EchoColor) == "Color3" then definition.EchoColor else Color3.fromRGB(99, 227, 255),
			shadowB = if typeof(definition.EchoColor2) == "Color3" then definition.EchoColor2 else Color3.fromRGB(255, 116, 183),
		}
	end

	local function unmount(record)
		if not record.root then return end
		record.root:Destroy()
		record.root, record.main, record.gradient, record.glyphs, record.echoes = nil, nil, nil, nil, nil
		local label = record.label
		label.TextTransparency, label.TextStrokeTransparency = record.alpha, record.strokeAlpha
		if record.stroke and record.stroke.Parent == label then record.stroke.Enabled = record.strokeEnabled end
		record.stroke = nil
	end
	local function frame(parent, name)
		local f = Instance.new("Frame")
		f.Name, f.BackgroundTransparency, f.BorderSizePixel = name, 1, 0
		f.Active, f.Selectable, f.Size = false, false, UDim2.fromScale(1, 1)
		f.ZIndex, f.Parent = parent.ZIndex, parent
		return f
	end
	local function copyText(record, parent, name)
		local label = record.label
		local t = Instance.new("TextLabel")
		t.Name, t.BackgroundTransparency, t.BorderSizePixel = name, 1, 0
		t.Active, t.Selectable, t.AutoLocalize = false, false, false
		t.Size, t.ZIndex = UDim2.fromScale(1, 1), parent.ZIndex
		t.FontFace, t.TextSize = label.FontFace, label.TextSize
		t.TextScaled, t.TextWrapped, t.TextTruncate = label.TextScaled, label.TextWrapped, label.TextTruncate
		t.TextXAlignment, t.TextYAlignment, t.TextDirection = label.TextXAlignment, label.TextYAlignment, label.TextDirection
		t.LineHeight, t.OpenTypeFeatures = label.LineHeight, label.OpenTypeFeatures
		t.TextColor3, t.TextTransparency = label.TextColor3, record.alpha
		t.TextStrokeColor3 = if record.strokeEnabled then record.stroke.Color else label.TextStrokeColor3
		t.TextStrokeTransparency = if record.strokeEnabled then record.stroke.Transparency else record.strokeAlpha
		t.MaxVisibleGraphemes = label.MaxVisibleGraphemes
		t.RichText, t.Text = false, label.ContentText
		local constraint = label:FindFirstChildWhichIsA("UITextSizeConstraint")
		if constraint then constraint:Clone().Parent = t end
		t.Parent = parent
		return t
	end
	local function markGlyphs(label)
		local text = label.ContentText
		if glyphLimit == 0 or text == "" or not label.TextFits or label.TextBounds.X + 3 > label.AbsoluteSize.X
			or label.TextScaled or label.RichText or label.MaxVisibleGraphemes ~= -1
			or label.TextDirection == Enum.TextDirection.RightToLeft then return nil end
		local chars = {}
		for first, last in utf8.graphemes(text) do
			-- Joining scripts, emoji sequences and mixed-direction names use the unsplit renderer.
			if utf8.codepoint(text, first) > 0x024F or #chars == glyphLimit then return nil end
			local escaped = text:sub(first, last):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
			table.insert(chars, escaped)
		end
		return if #chars > 1 then chars else nil
	end
	local function invisible(text)
		return if text == "" then "" else '<font transparency="1">' .. text .. '</font>'
	end
	local function fittedGradient(label, fx)
		-- Fit colors without resizing the native text rectangle.
		local width, bounds = label.AbsoluteSize.X, label.TextBounds.X
		if width <= 0 or bounds <= 0 or not label.TextFits or label.TextScaled or label.TextWrapped
			or fx.rotation % 180 ~= 0 then return fx.colors, 1 end
		local span = math.clamp((bounds + 3) / width, 0.01, 1)
		if span >= 0.9999 then return fx.colors, 1 end
		local align = if label.TextXAlignment == Enum.TextXAlignment.Right then 1
			elseif label.TextXAlignment == Enum.TextXAlignment.Center then 0.5 else 0
		if fx.rotation % 360 == 180 then align = 1 - align end
		local start = (1 - span) * align
		local stops = {}
		if align > 0 then table.insert(stops, ColorSequenceKeypoint.new(0, fx.stops[1].Value)) end
		for i, stop in ipairs(fx.stops) do
			local time = if i == #fx.stops and align == 1 then 1 else start + span * stop.Time
			table.insert(stops, ColorSequenceKeypoint.new(time, stop.Value))
		end
		if align < 1 then table.insert(stops, ColorSequenceKeypoint.new(1, fx.stops[#fx.stops].Value)) end
		return ColorSequence.new(stops), span
	end
	-- Fit mirrored tiles to the ink once. Animation changes only Offset.
	local function movingGradient(record, gradient)
		local label, fx = record.label, record.fx
		local size, bounds = label.AbsoluteSize, label.TextBounds
		local extent = if fx.vertical then size.Y else size.X
		local ink = if fx.vertical then bounds.Y else bounds.X
		local span = if extent > 0 and ink > 0 and label.TextFits and not label.TextWrapped
			then math.clamp(ink / extent, 0.01, 1) else 1
		local align
		if fx.vertical then
			align = if label.TextYAlignment == Enum.TextYAlignment.Bottom then 1
				elseif label.TextYAlignment == Enum.TextYAlignment.Center then 0.5 else 0
		else
			align = if label.TextXAlignment == Enum.TextXAlignment.Right then 1
				elseif label.TextXAlignment == Enum.TextXAlignment.Center then 0.5 else 0
		end
		local scale = math.max(0.01, span * fx.bandWidth)
		local axis = if fx.vertical then Vector2.new(0, 1) else Vector2.new(1, 0)
		record.gradientOrigin = axis * ((align - 0.5) * (1 - span))
		record.gradientStep = axis * (scale * fx.travel)
		gradient.Color, gradient.TileMode = fx.colors, Enum.GradientTileMode.Mirror
		gradient.Rotation, gradient.Scale = if fx.vertical then 90 else 0, scale
		gradient.Offset = record.gradientOrigin + record.gradientStep * (fx.phase % 2)
	end
	local function mount(record, animated)
		local label, fx = record.label, record.fx
		record.alpha, record.strokeAlpha = label.TextTransparency, label.TextStrokeTransparency
		record.stroke = label:FindFirstChild("RosterNameStroke")
		record.strokeEnabled = record.stroke ~= nil and record.stroke:IsA("UIStroke") and record.stroke.Enabled
		local root = frame(label, "RosterNameEffect")
		root.ClipsDescendants = true
		record.root, record.animated = root, animated
		local split = animated and fx.motion == "Wave" and not (fx.mode == "MovingGradient" and fx.vertical)
		local chars = if split then markGlyphs(label) else nil
		if chars then
			-- Keep the full line for native kerning.
			record.glyphs = {}
			for i, char in ipairs(chars) do
				local t = copyText(record, root, "Glyph" .. i)
				local middle = char
				if t.TextStrokeTransparency < 1 then
					middle = ('<stroke color="#%s" transparency="%.3f" thickness="%.2f">%s</stroke>'):format(
						t.TextStrokeColor3:ToHex(), t.TextStrokeTransparency,
						if record.strokeEnabled then record.stroke.Thickness else 1, char)
				end
				t.TextStrokeTransparency, t.RichText = 1, true
				t.Text = invisible(table.concat(chars, "", 1, i - 1)) .. middle .. invisible(table.concat(chars, "", i + 1))
				record.glyphs[i] = t
			end
		else
			if animated and fx.motion == "Glitch" then
				record.echoes = {}
				for i, color in ipairs({fx.shadowA, fx.shadowB}) do
					local t = copyText(record, root, "Echo" .. i)
					t.TextColor3, t.TextStrokeTransparency, t.Visible = color, 1, false
					t.TextTransparency = 0.5 + record.alpha * 0.5
					record.echoes[i] = t
				end
			end
			record.main = copyText(record, root, "Lettering")
			record.main.ZIndex += 1
			if fx.mode == "Gradient" or fx.mode == "MovingGradient" or fx.mode == "Shimmer" or fx.mode == "Rainbow" then
				local gradient = Instance.new("UIGradient")
				if fx.mode == "MovingGradient" then
					movingGradient(record, gradient)
				else
					gradient.Color, record.gradientSpan = fittedGradient(label, fx)
					gradient.Rotation = fx.rotation
				end
				gradient.Parent = record.main
				record.main.TextColor3, record.gradient = white, gradient
			elseif fx.mode == "Cycle" then record.main.TextColor3 = fx.stops[1].Value end
		end
		label.TextTransparency, label.TextStrokeTransparency = 1, 1
		if record.strokeEnabled then record.stroke.Enabled = false end
	end
	local function animate(record, time)
		local fx = record.fx
		local t = time * fx.speed + fx.phase
		local angle = t * tau
		local amplitude = math.min(fx.amplitude, record.label.TextSize * 0.24)
		if fx.motion == "Wave" then
			local spare = math.max(0, record.label.AbsoluteSize.Y - record.label.TextBounds.Y)
			amplitude = math.min(amplitude, spare / 2)
		end
		if record.glyphs then
			local count = #record.glyphs
			for i, glyph in ipairs(record.glyphs) do
				local x = (i - 1) / math.max(1, count - 1)
				glyph.Position = UDim2.fromOffset(0, math.round(math.sin(angle - x * fx.frequency * tau) * amplitude))
				if fx.mode then
					local coordinate = if fx.mode == "Gradient" then x
						elseif fx.mode == "MovingGradient" then
							1 - math.abs((((x - 0.5) / fx.bandWidth + 0.5 - fx.travel * t) % 2) - 1)
						elseif fx.mode == "Shimmer" then math.clamp(x + math.sin(angle * 0.28) * 0.7, 0, 1)
						elseif fx.mode == "Rainbow" then (x * 0.68 + t * 0.18) % 1 else (1 - math.cos(angle * 0.35)) * 0.5
					glyph.TextColor3 = sample(fx.stops, coordinate)
				end
			end
		else
			if fx.motion == "Wave" then
				record.main.Position = UDim2.fromOffset(0, math.round(math.sin(angle) * amplitude))
			elseif record.echoes then
				-- Keep the primary letters steady; briefly offset two colored impressions.
				local beat = (time * math.min(2, fx.speed * fx.frequency * 0.7) + fx.phase) % 1
				local burst = beat > 0.82
				for i, echo in ipairs(record.echoes) do
					echo.Visible = burst
					if burst then
						local sign = if i == 1 then -1 else 1
						echo.Position = UDim2.fromOffset(sign * math.round(amplitude * 1.5), sign)
					end
				end
			end
			if fx.mode == "Cycle" then record.main.TextColor3 = sample(fx.stops, (1 - math.cos(angle * 0.35)) * 0.5)
			elseif fx.mode == "MovingGradient" then
				record.gradient.Offset = record.gradientOrigin + record.gradientStep * (t % 2)
			elseif record.gradient and fx.mode ~= "Gradient" then
				record.gradient.Offset = Vector2.new(math.sin(angle * 0.28) * 0.65 * record.gradientSpan, 0)
			end
		end
	end

	local function stop()
		if heartbeat then heartbeat:Disconnect(); heartbeat = nil end
		elapsed = 0
	end
	local function step(dt)
		phaseTime += dt
		elapsed += dt
		if elapsed < interval then return end
		elapsed %= interval
		local legacyOffset = Vector2.new(math.sin(phaseTime * 1.5) * 0.7, 0)
		for _, record in ipairs(ticking) do
			if record.legacy then record.legacy.Offset = legacyOffset else animate(record, phaseTime) end
		end
	end
	local function reconcile()
		queued = false
		if destroyed then return end
		local candidates = {}
		for _, record in pairs(records) do
			if opened and record.visible and record.label.Parent then table.insert(candidates, record)
			else unmount(record) end
		end
		if opened then for _, record in pairs(legacy) do table.insert(candidates, record) end end
		table.sort(candidates, function(a, b)
			if a.priority ~= b.priority then return a.priority > b.priority end
			return a.serial < b.serial
		end)
		table.clear(ticking)
		local canMove = not guiService.ReducedMotionEnabled
		for _, record in ipairs(candidates) do
			local dynamic = record.legacy ~= nil or (record.fx.dynamic and record.fx.speed > 0)
			local moving = dynamic and canMove and #ticking < capacity
			if record.legacy then
				if not moving then record.legacy.Offset = Vector2.zero end
			elseif not record.root or record.animated ~= moving or record.dirty then
				unmount(record)
				mount(record, moving)
				record.dirty = false
				if moving then animate(record, phaseTime) end
			end
			if moving then table.insert(ticking, record) end
		end
		if #ticking == 0 then stop()
		elseif not heartbeat then heartbeat = runService.Heartbeat:Connect(step) end
	end
	local function queue()
		if destroyed or queued then return end
		queued = true
		task.defer(reconcile)
	end
	local reduced = guiService:GetPropertyChangedSignal("ReducedMotionEnabled"):Connect(queue)
	local api = {}
	function api:Release(label)
		local record = records[label]
		if not record then return end
		record.sizeConnection:Disconnect()
		record.textConnection:Disconnect()
		if record.boundsConnection then record.boundsConnection:Disconnect() end
		unmount(record)
		records[label] = nil
		-- The shared ticker may run before the deferred budget pass.
		local index = table.find(ticking, record)
		if index then table.remove(ticking, index) end
		queue()
	end
	function api:Bind(label, spec)
		if destroyed then return end
		local previous = records[label]
		if previous and previous.spec == spec then return end
		local visible, priority = previous and previous.visible or false, previous and previous.priority or 0
		self:Release(label)
		if not spec then return end
		local fx = describe(spec, label)
		if not fx then return end
		serial += 1
		local record = {label=label, spec=spec, fx=fx, serial=serial, priority=priority, visible=visible}
		local function changed() record.dirty = true; queue() end
		record.sizeConnection = label:GetPropertyChangedSignal("AbsoluteSize"):Connect(changed)
		record.textConnection = label:GetPropertyChangedSignal("ContentText"):Connect(changed)
		if fx.mode == "MovingGradient" then
			record.boundsConnection = label:GetPropertyChangedSignal("TextBounds"):Connect(changed)
		end
		records[label] = record
		queue()
	end
	function api:SetVisible(label, visible, priority)
		local record = records[label]
		if not record then return end
		priority = priority or 0
		if record.visible == visible and record.priority == priority then return end
		record.visible, record.priority = visible, priority
		queue()
	end
	function api:SetLegacyGradient(gradient, visible, priority)
		if not gradient or destroyed then return end
		local record = legacy[gradient]
		priority = priority or 0
		if visible then
			if record and record.priority == priority then return end
			if not record then
				serial += 1
				record = {legacy=gradient, serial=serial}
				legacy[gradient] = record
			end
			record.priority = priority
		elseif record then
			gradient.Offset = Vector2.zero
			legacy[gradient] = nil
			local index = table.find(ticking, record)
			if index then table.remove(ticking, index) end
		else return end
		queue()
	end
	function api:SetOpen(value)
		if destroyed or opened == value then return end
		opened = value
		if not opened then stop() end
		queue()
	end
	function api:Destroy()
		if destroyed then return end
		destroyed = true
		reduced:Disconnect()
		stop()
		for label in pairs(records) do self:Release(label) end
		for gradient in pairs(legacy) do gradient.Offset = Vector2.zero end
		table.clear(legacy)
		table.clear(ticking)
	end
	return api
end

-- Paint an optional mark after the active card layout has placed the portrait,
-- identity and featured item. An inline mark borrows only unused identity space.
local function createRosterCardEmblem(banner, identity)
	local header = banner.Parent
	local textService = game:GetService("TextService")
	local host, mark
	local metrics = {}
	local originalPosition, originalSize, originalHeader

	local function restore()
		if originalSize then
			identity.Position, identity.Size = originalPosition, originalSize
			originalPosition, originalSize = nil, nil
		end
		if originalHeader then
			header.Size, originalHeader = originalHeader, nil
		end
	end
	local function clear()
		restore()
		if host then host:Destroy() end
		host, mark = nil, nil
		table.clear(metrics)
	end
	local function pixels(dimension, total)
		return dimension.Scale * total + dimension.Offset
	end
	local function textWidth(available)
		local required = 0
		for _, label in ipairs(identity:GetChildren()) do
			if not label:IsA("TextLabel") or not label.Visible or label.Text == "" then continue end
			-- An uploaded FontFace may have no equivalent legacy Font for GetTextSize.
			-- Preserve its full existing area instead of measuring in a different font.
			if label.Font == Enum.Font.Unknown then return available end
			local measured = metrics[label]
			if not measured or measured.text ~= label.Text or measured.size ~= label.TextSize or measured.font ~= label.Font then
				measured = {text = label.Text, size = label.TextSize, font = label.Font}
				measured.width = textService:GetTextSize(measured.text, measured.size, measured.font, Vector2.new(10000, 1000)).X
				metrics[label] = measured
			end
			required = math.max(required, measured.width)
		end
		return math.min(available, math.ceil(required) + 6)
	end
	local function ensure(kind)
		if not host then
			host = Instance.new("Frame")
			host.Name, host.BackgroundTransparency, host.BorderSizePixel = "CardEmblem", 1, 0
			host.ClipsDescendants, host.Active, host.Selectable = true, false, false
		end
		if mark and not mark:IsA(kind) then mark:Destroy(); mark = nil end
		if not mark then
			mark = Instance.new(kind)
			mark.Name, mark.BackgroundTransparency, mark.BorderSizePixel = "Mark", 1, 0
			mark.Active, mark.Selectable = false, false
			if kind == "ImageLabel" then
				mark.ScaleType = Enum.ScaleType.Fit
			else
				mark.Font, mark.AutoLocalize = Enum.Font.BuilderSans, false
				mark.TextScaled, mark.RichText = true, false
			end
			mark.Parent = host
		end
	end
	local function finite(value, default)
		return if type(value) == "number" and value == value and math.abs(value) < math.huge then value else default
	end
	local function apply(spec, cardWidth, images)
		restore()
		if type(spec) ~= "table" then clear(); return end
		local image = if images then spec.Image else nil
		if type(image) == "number" and image > 0 and image < math.huge then image = "rbxassetid://" .. tostring(image) end
		local hasImage = type(image) == "string" and image ~= ""
		if not hasImage and (type(spec.Emoji) ~= "string" or spec.Emoji == "") then clear(); return end
		local position = spec.Position
		local behind = position == "Behind"
		local alpha = math.clamp(finite(spec.Transparency, if behind then 0.8 else 0), 0, 1)
		if alpha == 1 then clear(); return end
		local headerWidth = pixels(header.Size.X, pixels(header.Parent.Size.X, cardWidth))
		local bannerWidth = math.max(0, pixels(banner.Size.X, headerWidth))
		local bannerHeight = math.max(0, pixels(banner.Size.Y, header.Size.Y.Offset))
		if bannerWidth < 3 or bannerHeight < 3 then clear(); return end
		ensure(if hasImage then "ImageLabel" else "TextLabel")
		local color = if typeof(spec.Color) == "Color3" then spec.Color else Color3.new(1, 1, 1)
		if hasImage then
			mark.Image, mark.ImageColor3, mark.ImageTransparency = image, color, alpha
		else
			mark.Text, mark.TextColor3, mark.TextTransparency = spec.Emoji, color, alpha
		end
		local requested = finite(spec.Size, if behind then bannerHeight * 1.35 else 24)
		local size = math.max(1, math.round(requested))
		local parent = banner
		local rect, offset, align
		if behind then
			align = if spec.Align == "Left" then 0 elseif spec.Align == "Right" then 1 else 0.5
			size = math.min(size, bannerWidth * 2, bannerHeight * 2)
			rect, offset = UDim2.fromScale(1, 1), UDim2.new()
		else
			local right = position == "Right"
			align = if right then 1 else 0
			local available = math.max(0, pixels(identity.Size.X, bannerWidth))
			local gap = 5
			local room = math.floor(available - textWidth(available) - gap)
			local inline = math.min(size, room, bannerHeight - 4)
			if inline >= math.min(size, 14) then
				size = inline
				local identityX = pixels(identity.Position.X, bannerWidth) - identity.AnchorPoint.X * available
				originalPosition, originalSize = identity.Position, identity.Size
				local reserve = UDim2.fromOffset(size + gap, 0)
				identity.Size = originalSize - reserve
				if not right then identity.Position = originalPosition + reserve end
				rect = UDim2.new(0, size, identity.Size.Y.Scale, identity.Size.Y.Offset)
				offset = UDim2.new(0, if right then identityX + available - size else identityX,
					identity.Position.Y.Scale, identity.Position.Y.Offset)
			elseif spec.Overflow == "Below" then
				size = math.min(size, math.max(1, headerWidth - 16), 30)
				parent = header
				originalHeader = header.Size
				header.Size = originalHeader + UDim2.fromOffset(0, size + 5)
				rect = UDim2.fromOffset(size, size)
				offset = UDim2.new(align, if right then -size - 8 else 8, 0, originalHeader.Y.Offset - 1)
			else
				clear()
				return
			end
		end
		host.ZIndex = if behind then math.max(0, identity.ZIndex - 1) else identity.ZIndex
		host.Position, host.Size = offset, rect
		mark.AnchorPoint, mark.Position = Vector2.new(align, 0.5), UDim2.fromScale(align, 0.5)
		mark.Size = UDim2.fromOffset(size, size)
		host.Parent = parent
	end
	return {restore = restore, apply = apply, clear = clear}
end

-- Inset-relative input positions, GUI hit tests and AbsolutePosition use the same origin.
local function createRosterBadgeHints(screen, canShow, hitArea, card)
	local input = game:GetService("UserInputService")
	local gui = game:GetService("GuiService")
	local textService = game:GetService("TextService")
	local bindings = setmetatable({}, {__mode = "k"})
	local consumed = setmetatable({}, {__mode = "k"})
	local contacts, connections = {}, {}
	local hint, active, hold, destroyed
	local font, fontSize = Enum.Font.BuilderSansMedium, 14

	local function hide()
		if hold and hold.timer then task.cancel(hold.timer) end
		hold, active = nil, nil
		if hint then hint.Visible = false end
	end
	local function badgeAt(point)
		if destroyed or not screen.Enabled or not screen.Parent or not next(bindings) then return nil end
		local function inside(area)
			if not area or not area.Visible then return false end
			local p, size = area.AbsolutePosition, area.AbsoluteSize
			return point.X >= p.X and point.Y >= p.Y and point.X < p.X+size.X and point.Y < p.Y+size.Y
		end
		if hitArea and not inside(hitArea) and not inside(card) then return nil end
		local blocker
		for _, object in screen.Parent:GetGuiObjectsAtPosition(point.X, point.Y) do
			if bindings[object] and object.Visible and (not blocker or object:IsDescendantOf(blocker))
				and (not canShow or canShow(object)) then return object end
			-- A covering button blocks unrelated badges.
			if not blocker and object.Active then blocker = object end
		end
		return nil
	end
	local function show(badge, point)
		if active == badge then return end
		if not badge then hide(); return end
		if not hint then
			hint = Instance.new("TextLabel")
			hint.Name = "RosterBadgeTooltip"
			hint.Active, hint.Selectable, hint.Interactable, hint.AutoLocalize = false, false, false, false
			hint.BackgroundColor3, hint.BorderSizePixel = Color3.fromRGB(28, 30, 36), 0
			hint.Font, hint.TextSize, hint.TextColor3 = font, fontSize, Color3.fromRGB(247, 248, 250)
			hint.TextWrapped, hint.TextTruncate = true, Enum.TextTruncate.AtEnd
			hint.ZIndex, hint.Visible, hint.Parent = 100, false, screen
			local corner = Instance.new("UICorner")
			corner.CornerRadius, corner.Parent = UDim.new(0, 6), hint
			local pad = Instance.new("UIPadding")
			pad.PaddingLeft, pad.PaddingRight = UDim.new(0, 8), UDim.new(0, 8)
			pad.PaddingTop, pad.PaddingBottom = UDim.new(0, 4), UDim.new(0, 4)
			pad.Parent = hint
		end
		local safe = gui:GetInsetArea(Enum.ScreenInsets.CoreUISafeInsets)
		local origin, size = screen.AbsolutePosition, screen.AbsoluteSize
		local left, top = math.max(origin.X, safe.Min.X) + 4, math.max(origin.Y, safe.Min.Y) + 4
		local right = math.min(origin.X + size.X, safe.Max.X) - 4
		local bottom = math.min(origin.Y + size.Y, safe.Max.Y) - 4
		if right <= left + 16 or bottom <= top + 12 then hide(); return end
		local maxWidth = math.min(248, right - left)
		local content = bindings[badge]
		local bounds = textService:GetTextSize(content, fontSize, font, Vector2.new(maxWidth - 16, 10000))
		local width = math.min(maxWidth, math.ceil(bounds.X) + 17)
		local height = math.min(bottom - top, 96, math.ceil(bounds.Y) + 10)
		local x = math.clamp(point.X - width / 2, left, right - width)
		local y = math.max(badge.AbsolutePosition.Y, point.Y - 18) - 5 - height
		if y < top then y = math.min(badge.AbsolutePosition.Y + badge.AbsoluteSize.Y, point.Y + 18) + 5 end
		hint.Text, hint.Size = content, UDim2.fromOffset(width, height)
		hint.Position = UDim2.fromOffset(math.round(x - origin.X), math.round(math.clamp(y, top, bottom - height) - origin.Y))
		active, hint.Visible = badge, true
	end
	local function on(signal, callback)
		table.insert(connections, signal:Connect(callback))
	end
	on(input.InputChanged, function(pointer)
		local kind, point = pointer.UserInputType, pointer.Position
		if kind == Enum.UserInputType.MouseMovement then
			if not next(contacts) then show(badgeAt(point), point) end
		elseif kind == Enum.UserInputType.MouseWheel then hide()
		elseif hold and pointer == hold.pointer and (point - hold.start).Magnitude > 8 then hide() end
	end)
	on(input.InputBegan, function(pointer)
		hide()
		if pointer.UserInputType ~= Enum.UserInputType.Touch then return end
		local multiple = next(contacts) ~= nil
		contacts[pointer] = true
		if multiple then return end
		local badge = badgeAt(pointer.Position)
		if not badge then return end
		local gesture = {pointer = pointer, badge = badge, start = pointer.Position}
		hold = gesture
		gesture.timer = task.delay(0.55, function()
			gesture.timer = nil
			if hold ~= gesture or badgeAt(pointer.Position) ~= badge then return end
			show(badge, pointer.Position)
			if active == badge then consumed[pointer] = true end
		end)
	end)
	on(input.InputEnded, function(pointer)
		contacts[pointer] = nil
		if hold and hold.pointer == pointer then hide() end
	end)
	on(input.WindowFocusReleased, function()
		table.clear(contacts)
		hide()
	end)
	on(screen:GetPropertyChangedSignal("Enabled"), hide)
	on(screen:GetPropertyChangedSignal("AbsoluteSize"), hide)
	local api = {}
	function api:Bind(badge, value)
		if destroyed then return end
		local label = if type(value) == "string" and value:find("%S") then value else nil
		if bindings[badge] == label then return end
		if active == badge or (hold and hold.badge == badge) then hide() end
		bindings[badge] = label
	end
	function api:Consumed(pointer)
		return pointer ~= nil and consumed[pointer] == true
	end
	function api:Hide() hide() end
	function api:Destroy()
		if destroyed then return end
		destroyed = true
		hide()
		for _, connection in connections do connection:Disconnect() end
		table.clear(bindings)
		table.clear(contacts)
		table.clear(consumed)
		if hint then hint:Destroy(); hint = nil end
	end
	return api
end

local function rosterMotionSpec(motion, opening, mobile)
	local spec = if type(motion) == "table" then motion[if opening then "Open" else "Close"] else motion
	if spec == nil and type(motion) == "table" and motion.Preset then spec = motion end
	if type(spec) ~= "table" then spec = {Preset = spec} end
	local preset = spec.Preset
	local edges = {SlideLeft="Left", SlideRight="Right", SlideTop="Top", SlideBottom="Bottom"}
	local centered = preset == "CenterPop" or preset == "CenterZoom" or preset == "CartoonBounce"
	if not centered and not edges[preset] and preset ~= "Slide" and preset ~= "Fade" and preset ~= "Pop"
		and preset ~= "FloatUp" and preset ~= "Instant" then preset = "Stock" end
	local function number(value, fallback, low, high)
		if type(value) ~= "number" or value ~= value or math.abs(value) == math.huge then return fallback end
		return math.clamp(value, low, high)
	end
	local style = spec.EasingStyle
	if typeof(style) ~= "EnumItem" or style.EnumType ~= Enum.EasingStyle or style.Name == "Bezier" or style.Name == "Spring" then
		style = if preset == "CartoonBounce" then (if opening then Enum.EasingStyle.Elastic else Enum.EasingStyle.Back)
			elseif edges[preset] then Enum.EasingStyle.Quart else Enum.EasingStyle.Quad
	end
	local direction = spec.EasingDirection
	if typeof(direction) ~= "EnumItem" or direction.EnumType ~= Enum.EasingDirection then
		direction = if opening then Enum.EasingDirection.Out else Enum.EasingDirection.In
	end
	local distance = number(spec.Distance, 32, 0, 4096)
	local dx = if spec.Direction == "Left" then -distance else distance
	local dy = 0
	if spec.Direction == "Up" or spec.Direction == "Down" then
		dx, dy = 0, if spec.Direction == "Up" then -distance else distance
	end
	local duration = if preset == "CartoonBounce" then (if opening then 0.55 else 0.28)
		elseif edges[preset] then (if opening then 0.32 else 0.23) else (if opening then 0.22 else 0.16)
	local scale = if preset == "CenterZoom" then number(spec.Scale, 1.16, 0.35, 2)
		elseif preset == "CenterPop" then number(spec.Scale, 0.78, 0.35, 2)
		elseif preset == "CartoonBounce" then number(spec.Scale, 0.68, 0.35, 2)
		elseif preset == "Pop" then number(spec.Scale, 0.92, 0.5, 1)
		elseif preset == "Stock" and mobile then 1.25 else 1
	return {
		preset = preset, duration = number(spec.Duration, duration, 0, 5),
		style = style, direction = direction, edge = edges[preset], centered = centered,
		padding = number(spec.EdgePadding, 8, 0, 256),
		move = if preset == "Stock" and not mobile then UDim2.fromScale(if opening then 0.2 else 1.1, 0)
			elseif preset == "Slide" then UDim2.fromOffset(dx, dy)
			elseif preset == "FloatUp" then UDim2.fromOffset(0, if opening then distance else -distance) else UDim2.new(),
		fade = if centered or preset == "Fade" or preset == "Pop" or preset == "Slide" or preset == "FloatUp" then 1 else 0,
		scale = scale, bodyFade = if preset == "Stock" and mobile then 1 else 0,
	}
end

-- Capture the rest pose once. An interruption can then reverse or change pivot without
-- measuring a frame already moved by the previous transition.
local function rosterMotionBounds(screen, frame, mobile, fullDisplay)
	local position, size = frame.AbsolutePosition, frame.AbsoluteSize
	local left, top = position.X, position.Y
	local right, bottom = left + size.X, top + size.Y
	if not mobile then
		local topCap = frame:FindFirstChild("TopRoundedRect", true)
		local bottomCap = frame:FindFirstChild("BottomRoundedRect", true)
		if topCap and bottomCap and topCap.AbsoluteSize.X > 0 and bottomCap.AbsolutePosition.Y >= topCap.AbsolutePosition.Y then
			left, top = topCap.AbsolutePosition.X, topCap.AbsolutePosition.Y
			right = math.max(left + topCap.AbsoluteSize.X, bottomCap.AbsolutePosition.X + bottomCap.AbsoluteSize.X)
			bottom = bottomCap.AbsolutePosition.Y + bottomCap.AbsoluteSize.Y
		end
	end
	local centerX, centerY = (left + right) * 0.5, (top + bottom) * 0.5
	-- An open desktop player card also travels with the list.
	local popup = if not mobile then frame:FindFirstChild("PlayerDropDown", true) else nil
	if popup and popup.Visible and popup.AbsoluteSize.X > 0 then
		local p, s = popup.AbsolutePosition, popup.AbsoluteSize
		left, top = math.min(left, p.X), math.min(top, p.Y)
		right, bottom = math.max(right, p.X + s.X), math.max(bottom, p.Y + s.Y)
	end
	local screenOrigin, screenSize = screen.AbsolutePosition, screen.AbsoluteSize
	if fullDisplay and fullDisplay.Width > 0 and fullDisplay.Height > 0 then
		screenOrigin, screenSize = fullDisplay.Min, fullDisplay.Max - fullDisplay.Min
	end
	return {
		left=left, right=right, top=top, bottom=bottom, centerX=centerX, centerY=centerY,
		anchorX=position.X + size.X * frame.AnchorPoint.X, anchorY=position.Y + size.Y * frame.AnchorPoint.Y,
		frameWidth=size.X, parentSize=frame.Parent.AbsoluteSize,
		screenOrigin=screenOrigin, screenSize=screenSize, safeSize=screen.AbsoluteSize,
	}
end

local function rosterAwayPosition(profile, bounds, mobile)
	if not profile.edge and not profile.centered and (profile.preset ~= "Pop" or mobile) then return profile.move end
	local edge, deltaX, deltaY = profile.edge, 0, 0
	if edge == "Left" then deltaX = math.min(0, bounds.screenOrigin.X - bounds.right - profile.padding)
	elseif edge == "Right" then deltaX = math.max(0, bounds.screenOrigin.X + bounds.screenSize.X - bounds.left + profile.padding)
	elseif edge == "Top" then deltaY = math.min(0, bounds.screenOrigin.Y - bounds.bottom - profile.padding)
	elseif edge == "Bottom" then deltaY = math.max(0, bounds.screenOrigin.Y + bounds.screenSize.Y - bounds.top + profile.padding)
	elseif profile.centered then
		deltaX = (bounds.centerX - bounds.anchorX) * (1 - profile.scale)
		deltaY = (bounds.centerY - bounds.anchorY) * (1 - profile.scale)
	elseif profile.preset == "Pop" and not mobile then
		-- Retain the top-right pivot of the original compact desktop pop.
		deltaX = bounds.frameWidth * (1 - profile.scale)
	end
	-- Relative offsets also work when a developer places the template under a UIScale.
	return profile.move + UDim2.fromScale(deltaX / math.max(1, bounds.parentSize.X), deltaY / math.max(1, bounds.parentSize.Y))
end

local function rosterSpring(value, velocity, goal, frequency, dt)
	local omega = 2 * math.pi * frequency
	local delta = value - goal
	local step = (velocity + omega * delta) * dt
	local decay = math.exp(-omega * dt)
	return goal + (delta + step) * decay, (velocity - omega * step) * decay
end

local function rosterMotionLerp(from, to, alpha)
	-- Elastic and Back easing intentionally pass through their target.
	return UDim2.new(
		from.X.Scale + (to.X.Scale - from.X.Scale) * alpha, from.X.Offset + (to.X.Offset - from.X.Offset) * alpha,
		from.Y.Scale + (to.Y.Scale - from.Y.Scale) * alpha, from.Y.Offset + (to.Y.Offset - from.Y.Offset) * alpha
	)
end

-- Animate native transparency directly so text and unclipped player cards retain their normal rendering.
local function beginRosterFade(screen, separateBody)
	local properties, seen = {}, {}
	local function collect(node)
		if seen[node] then return end
		seen[node] = true
		local function capture(key)
			local base = node[key]
			if base < 1 then table.insert(properties, {node = node, key = key, base = base, last = base}) end
		end
		if node:IsA("GuiObject") then
			if node ~= separateBody then capture("BackgroundTransparency") end
			if node:IsA("TextLabel") or node:IsA("TextButton") or node:IsA("TextBox") then
				capture("TextTransparency")
				capture("TextStrokeTransparency")
			elseif node:IsA("ImageLabel") or node:IsA("ImageButton") then
				capture("ImageTransparency")
			elseif node:IsA("ScrollingFrame") then
				capture("ScrollBarImageTransparency")
			end
		elseif node:IsA("UIStroke") then
			capture("Transparency")
		end
	end
	for _, node in ipairs(screen:GetDescendants()) do collect(node) end
	local added = screen.DescendantAdded:Connect(collect)
	local function paint(amount)
		for _, item in ipairs(properties) do
			local node, key = item.node, item.key
			if node.Parent ~= nil then
				local current = node[key]
				-- A hover, stat refresh or theme may set a new native value mid-motion.
				if math.abs(current - item.last) > 0.00001 then item.base = current end
				local goal = item.base + (1 - item.base) * amount
				if current ~= goal then node[key] = goal end
				item.last = goal
			end
		end
	end
	return {paint = paint, finish = function() added:Disconnect(); paint(0) end}
end

-- Own public input bindings while the captured player list is mounted.
local function attachVisibility(controller, hooks)
	local run = game:GetService("RunService")
	local input = game:GetService("UserInputService")
	local gui = game:GetService("GuiService")
	local starter = game:GetService("StarterGui")
	local tween = game:GetService("TweenService")
	local screen = hooks.Screen
	local mobile = hooks.IsMobile == true
	local movingFrame = hooks.MotionFrame or screen.Children:FindFirstChild("OffsetFrame") or screen.Children
	local nativePosition = movingFrame.Position
	local replaceStock = hooks.ReplaceCoreGui ~= false
	local function usesNativeTouchEntry()
		return input.TouchEnabled and (mobile or not input.KeyboardEnabled or input.PreferredInput == Enum.PreferredInput.Touch)
	end
	local nativeTouchEntry = usesNativeTouchEntry()
	local ownsStock = false
	local function releaseStock()
		if ownsStock then
			starter:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
			ownsStock = false
		end
	end
	local function updateStock()
		if nativeTouchEntry then
			releaseStock()
		elseif replaceStock and starter:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) then
			starter:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
			ownsStock = true
		end
	end
	local previousFocus, renderStep, returningFocus, closingFocus
	local events = {}
	local drawn = false
	local closed = false
	local desired = hooks.StartOpen
	if desired == nil then
		desired = replaceStock and not nativeTouchEntry and not mobile and input.PreferredInput == Enum.PreferredInput.KeyboardAndMouse
	end
	local opening = rosterMotionSpec(hooks.Motion, true, mobile)
	local closing = rosterMotionSpec(hooks.Motion, false, mobile)
	local rest = UDim2.new()
	local motionPosition, motionFade, motionScale, motionBodyFade = rest, 0, 1, 0
	local fadeSession, scaleNode, baseScale, ownsScale
	local bodyBase, bodyLast
	local lockedButtons, lockAdded
	local intent, velocity, scaleVelocity, bodyVelocity = nil, 0, 0, 0
	local bounds
	local needsBounds = opening.edge or closing.edge or opening.centered or closing.centered
		or (not mobile and (opening.preset == "Pop" or closing.preset == "Pop"))
	local function measureRest()
		-- AbsolutePosition uses core-safe coordinates; this rectangle additionally includes
		-- the physical display area beyond a notch or top bar in those same coordinates.
		local full = if opening.edge or closing.edge then gui:GetInsetArea(Enum.ScreenInsets.None) else nil
		return rosterMotionBounds(screen, movingFrame, mobile, full)
	end
	local function on(signal, callback)
		table.insert(events, signal:Connect(callback))
	end
	local function paint(position, opacity, scale, bodyOpacity)
		opacity, scale = math.clamp(opacity, 0, 1), math.max(0.01, scale)
		bodyOpacity = math.clamp(bodyOpacity or 0, 0, 1)
		motionPosition, motionFade, motionScale, motionBodyFade = position, opacity, scale, bodyOpacity
		movingFrame.Position = nativePosition + position
		if scale ~= 1 and not scaleNode then
			scaleNode = movingFrame:FindFirstChildWhichIsA("UIScale")
			ownsScale = scaleNode == nil
			if ownsScale then
				scaleNode = Instance.new("UIScale")
				scaleNode.Name, scaleNode.Parent = "RosterMotionScale", movingFrame
			end
			baseScale = scaleNode.Scale
		end
		if scaleNode then
			scaleNode.Scale = baseScale * scale
			if scale == 1 then
				if ownsScale then scaleNode:Destroy() end
				scaleNode = nil
			end
		end
		if mobile then
			-- Stock mobile fades the panel surface alone. Compose it with an optional
			-- creator fade so interruption never fades the backdrop or applies alpha twice.
			local amount = 1 - (1 - opacity) * (1 - bodyOpacity)
			if amount > 0 or bodyBase ~= nil then
				local current = movingFrame.BackgroundTransparency
				if bodyBase == nil or math.abs(current - bodyLast) > 0.00001 then bodyBase = current end
				bodyLast = bodyBase + (1 - bodyBase) * amount
				movingFrame.BackgroundTransparency = bodyLast
				if amount == 0 then bodyBase, bodyLast = nil, nil end
			end
		end
		if opacity > 0 and not fadeSession then fadeSession = beginRosterFade(screen, if mobile then movingFrame else nil) end
		if fadeSession then
			if opacity == 0 then fadeSession.finish(); fadeSession = nil
			else fadeSession.paint(opacity) end
		end
	end
	local function lockClosingButtons(lock)
		if lock and not lockedButtons then
			lockedButtons = {}
			local function disable(node)
				if lockedButtons and node:IsA("GuiButton") and node.Interactable then
					lockedButtons[node] = true
					node.Interactable = false
				end
			end
			for _, node in ipairs(screen:GetDescendants()) do disable(node) end
			lockAdded = screen.DescendantAdded:Connect(disable)
		elseif not lock and lockedButtons then
			lockAdded:Disconnect()
			for node in pairs(lockedButtons) do
				if node.Parent ~= nil then node.Interactable = true end
			end
			lockedButtons, lockAdded = nil, nil
		end
	end
	local function stopMoving()
		if renderStep then renderStep:Disconnect(); renderStep = nil end
	end
	local function apply(value)
		if drawn == value then return end
		drawn = value
		hooks.ApplyOpen(value)
	end
	local function restoreFocus()
		local selected = gui.SelectedObject
		if (selected and selected:IsDescendantOf(screen)) or (returningFocus and not selected) then
			gui.SelectedObject = if previousFocus and previousFocus.Parent then previousFocus else nil
		end
		previousFocus, returningFocus, closingFocus = nil, false, nil
	end
	local function update(instant)
		local show = desired and not gui.MenuIsOpen
		if not instant and intent == show then return end
		intent = show
		stopMoving()
		local profile = if show then opening else closing
		local animate = not instant and not gui.ReducedMotionEnabled and profile.preset ~= "Instant"
			and (profile.preset == "Stock" or profile.duration > 0)
		local newlyDrawn = show and not drawn
		if show then
			lockClosingButtons(false)
			if drawn and closingFocus and not gui.SelectedObject and input.PreferredInput == Enum.PreferredInput.Gamepad then
				gui.SelectedObject = if closingFocus:IsDescendantOf(screen) then closingFocus else hooks.CloseButton
			end
			closingFocus = nil
		end
		if newlyDrawn then
			apply(true)
			velocity, scaleVelocity, bodyVelocity = 0, 0, 0
			if animate then
				if needsBounds then bounds = measureRest() end
				paint(rosterAwayPosition(profile, bounds, mobile), profile.fade, profile.scale, profile.bodyFade)
			end
			if input.PreferredInput == Enum.PreferredInput.Gamepad then
				previousFocus = gui.SelectedObject
				returningFocus = true
				gui.SelectedObject = hooks.CloseButton
			end
		end
		if not show and not drawn then return end
		local function complete()
			stopMoving()
			if not show then
				restoreFocus()
				apply(false)
			end
			velocity, scaleVelocity, bodyVelocity = 0, 0, 0
			paint(rest, 0, 1)
			bounds = nil
			lockClosingButtons(false)
		end
		if not animate then complete(); return end
		if not show then
			local selected = gui.SelectedObject
			closingFocus = if selected and selected:IsDescendantOf(screen) then selected else nil
			lockClosingButtons(true)
		end
		local from, fromFade, fromScale, fromBody = motionPosition, motionFade, motionScale, motionBodyFade
		if needsBounds and not bounds then bounds = measureRest() end
		local to = if show then rest else rosterAwayPosition(profile, bounds, mobile)
		local toFade, toScale, toBody = if show then 0 else profile.fade, if show then 1 else profile.scale, if show then 0 else profile.bodyFade
		local elapsed = 0
		if profile.preset ~= "Stock" then velocity, scaleVelocity, bodyVelocity = 0, 0, 0 end
		renderStep = run.RenderStepped:Connect(function(dt)
			elapsed += dt
			local alpha, position
			if profile.preset == "Stock" then
				local frequency = if mobile then 4 else 7
				local omega = 2 * math.pi * frequency
				alpha = 1 - (1 + omega * elapsed) * math.exp(-omega * elapsed)
				if mobile then
					local scale, body
					scale, scaleVelocity = rosterSpring(motionScale, scaleVelocity, toScale, frequency, dt)
					body, bodyVelocity = rosterSpring(motionBodyFade, bodyVelocity, toBody, frequency, dt)
					if math.abs(scale - toScale) < 0.001 and math.abs(body - toBody) < 0.001
						and math.abs(scaleVelocity) < 0.02 and math.abs(bodyVelocity) < 0.02 and alpha > 0.995 then complete(); return end
					paint(rosterMotionLerp(from, to, alpha), fromFade + (toFade - fromFade) * alpha, scale, body)
					-- Native touch hides the layer collector at 99% body transparency on exit.
					if not show and movingFrame.BackgroundTransparency >= 0.99 then complete() end
					return
				end
				local x
				x, velocity = rosterSpring(motionPosition.X.Scale, velocity, to.X.Scale, frequency, dt)
				if math.abs(x - to.X.Scale) < 0.001 and math.abs(velocity) < 0.02 and alpha > 0.995 then complete(); return end
				local other = from:Lerp(to, alpha)
				position = UDim2.new(x, other.X.Offset, other.Y.Scale, other.Y.Offset)
			else
				if elapsed >= profile.duration then complete(); return end
				alpha = tween:GetValue(elapsed / profile.duration, profile.style, profile.direction)
				position = rosterMotionLerp(from, to, alpha)
			end
			paint(position, fromFade + (toFade - fromFade) * alpha, fromScale + (toScale - fromScale) * alpha,
				fromBody + (toBody - fromBody) * alpha)
		end)
	end
	local bridge = {}
	function bridge:SetOpen(value)
		if closed then return end
		desired = value == true
		update(false)
	end
	on(input.InputBegan, function(key, processed)
		if gui.MenuIsOpen or input:GetFocusedTextBox() then return end
		local ownsDefaultKeys = replaceStock and not nativeTouchEntry
		local toggleKey = hooks.ToggleKey or (if ownsDefaultKeys then Enum.KeyCode.Tab else nil)
		if not processed and (key.KeyCode == toggleKey or (ownsDefaultKeys and key.KeyCode == Enum.KeyCode.ButtonSelect)) then
			bridge:SetOpen(not desired)
		elseif key.KeyCode == Enum.KeyCode.ButtonB and desired then
			if not hooks.DismissCard or not hooks.DismissCard() then bridge:SetOpen(false) end
		end
	end)
	on(gui.MenuOpened, function() update(true) end)
	on(gui.MenuClosed, function() task.defer(function() if not closed then update(false) end end) end)
	on(input:GetPropertyChangedSignal("PreferredInput"), function()
		local useNative = usesNativeTouchEntry()
		if useNative == nativeTouchEntry then return end
		nativeTouchEntry = useNative
		if useNative and ownsStock then bridge:SetOpen(false) end
		updateStock()
	end)
	on(gui:GetPropertyChangedSignal("ReducedMotionEnabled"), function() if renderStep then update(true) end end)
	on(screen:GetPropertyChangedSignal("AbsoluteSize"), function()
		-- Rotation and window resizes can change the card's dock as well as its edge.
		-- Settle into the newly measured native layout instead of using an old endpoint.
		if renderStep and bounds and screen.AbsoluteSize ~= bounds.safeSize then update(true) end
	end)
	-- Roblox owns the mobile overflow entry and removes it when its player list is disabled.
	updateStock()
	hooks.ApplyOpen(false)
	update(true)
	function bridge:Destroy()
		if closed then return end
		closed = true
		stopMoving()
		paint(rest, 0, 1)
		lockClosingButtons(false)
		restoreFocus()
		for _, connection in events do connection:Disconnect() end
		releaseStock()
	end
	return bridge
end

local function useMobileLayout(config)
	if config.Layout == "mobile" then return true end
	if config.Layout == "desktop" then return false end
	local input = game:GetService("UserInputService")
	if not input.TouchEnabled then return false end
	local gui = game:GetService("GuiService")
	local camera = workspace.CurrentCamera
	local size = if camera then camera.ViewportSize else Vector2.new(1024, 768)
	return gui.ViewportDisplaySize == Enum.DisplaySize.Small or size.X < 700 or size.Y < 500
end

local function trackRosterTouches(input)
	local contacts, rejected = {}, setmetatable({}, {__mode = "k"})
	local count, multiple = 0, false
	local began = input.TouchStarted:Connect(function(touch)
		if contacts[touch] then return end
		contacts[touch] = true
		count += 1
		if count == 1 then
			multiple = false
		elseif count == 2 then
			multiple = true
			for contact in pairs(contacts) do rejected[contact] = true end
		else
			rejected[touch] = true
		end
	end)
	local ended = input.TouchEnded:Connect(function(touch)
		if contacts[touch] then
			contacts[touch] = nil
			count -= 1
		end
	end)
	local lostFocus = input.WindowFocusReleased:Connect(function()
		for contact in pairs(contacts) do rejected[contact] = true end
		table.clear(contacts)
		count, multiple = 0, true
	end)
	local function accepts(pointer)
		-- Activated can arrive after TouchEnded. Preserve the verdict through release,
		-- while a new, independent single-finger tap can act immediately.
		return not pointer or pointer.UserInputType ~= Enum.UserInputType.Touch
			or (not multiple and not rejected[pointer])
	end
	local function disconnect()
		began:Disconnect()
		ended:Disconnect()
		lostFocus:Disconnect()
		table.clear(contacts)
		table.clear(rejected)
	end
	return accepts, disconnect
end

local function createMobileLayout(config, desktopTemplate)
	local packaged = script:FindFirstChild("StockMobilePlayerList")
	local screen = if packaged then packaged:Clone() else restoreStockTemplate("StockMobilePlayerList")
	local backdrop = screen.Children
	local panel = backdrop.BodyBackground
	local content = panel.ContentFrame
	local column = content.PlayerScrollList.Column
	local body = column.LegacyTwoTabsServerBody
	local scroll = body.ServerBody
	local rowHost = scroll.TeamList_Neutral
	local templateRow = assert(rowHost:FindFirstChildWhichIsA("ImageButton"), "Missing native mobile entry")
	local pin = scroll.TitlePlayer
	local header = scroll.TitleBar
	local title = panel.TitleText
	local close = panel.CloseButton
	local appearance = config.Appearance or {}
	backdrop.BackgroundTransparency, backdrop.ImageTransparency, backdrop.Active = 1, 1, true
	panel.BackgroundTransparency = 0.04
	for _, node in ipairs(screen:GetDescendants()) do
		if node:IsA("TextLabel") then
			if node.Name == "playersHeader" or node.Name:sub(1, 5) == "stat_" then
				node.TextSize, node.TextTransparency, node.TextColor3 = 14, 0, Color3.fromRGB(217, 220, 229)
			elseif node.Name == "PlayerStatDisplay" or (node.Name == "PlayerName" and node.Parent.Name == "PlayerName") then
				node.TextSize, node.TextTransparency, node.TextColor3 = 17, 0, Color3.fromRGB(246, 247, 250)
			end
		end
	end
	applyAppearance(screen, config.Appearance)
	screen.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
	screen.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
	screen.ClipToDeviceSafeArea = true
	screen:SetAttribute("RosterLayout", "mobile")
	panel.UIScale.Scale = 1
	panel.Active = true
	title.Text = if config.MobileTitle == nil then "Leaderboard" else tostring(config.MobileTitle)
	title.Visible = title.Text ~= ""
	title.TextSize, title.TextXAlignment = 20, Enum.TextXAlignment.Left
	if not (appearance.Font or appearance.FontFace) then
		title.FontFace = Font.new(title.FontFace.Family, Enum.FontWeight.SemiBold, title.FontFace.Style)
	end
	close.AnchorPoint = Vector2.new(1, 0)
	close.Position = UDim2.new(1, -4, 0, 2)
	close.Size = UDim2.fromOffset(40, 40)
	close.ZIndex = 4
	local closeIcon = Instance.new("ImageLabel")
	closeIcon.Name, closeIcon.ImageContent = "Icon", close.ImageContent
	closeIcon.ImageColor3, closeIcon.ImageTransparency = close.ImageColor3, close.ImageTransparency
	closeIcon.BackgroundTransparency, closeIcon.Active = 1, false
	closeIcon.Size, closeIcon.Position, closeIcon.AnchorPoint = UDim2.fromOffset(20, 20), UDim2.fromScale(0.5, 0.5), Vector2.new(0.5, 0.5)
	closeIcon.ZIndex, closeIcon.Parent, close.ImageTransparency = close.ZIndex, close, 1
	title.Size, title.Position = UDim2.new(1, -64, 0, 44), UDim2.fromOffset(16, 0)
	content.PlayerScrollList.Size = UDim2.fromScale(1, 1)
	column.LegacyTwoTabsTabsRow.LayoutOrder = 0
	column.LegacyTwoTabsTabsRow.ClipsDescendants = true
	header.Parent, header.LayoutOrder = column, 1
	pin.Parent, pin.LayoutOrder = column, 2
	body.LayoutOrder = 3
	local pinDivider = scroll:FindFirstChild("BottomDiv")
	if pinDivider then
		pinDivider.Parent, pinDivider.AnchorPoint, pinDivider.Position = pin, Vector2.new(0, 1), UDim2.fromScale(0, 1)
	end
	templateRow.Parent = nil
	for _, parent in ipairs({rowHost, scroll}) do
		for _, child in ipairs(parent:GetChildren()) do
			if child.Name == "BottomDiv" or child.Name:match("^TopDiv") then child:Destroy() end
		end
	end
	local scrollLayout = scroll:FindFirstChildWhichIsA("UIListLayout")
	if scrollLayout then scrollLayout:Destroy() end
	rowHost.Position = UDim2.fromOffset(0, 0)
	rowHost.Size = UDim2.new(1, 0, 0, 0)
	scroll.Position, scroll.Size = UDim2.new(), UDim2.fromScale(1, 1)
	scroll.AutomaticCanvasSize = Enum.AutomaticSize.None

	local sheet = Instance.new("ScrollingFrame")
	sheet.Name = "ProfilePane"
	sheet.BackgroundTransparency, sheet.BorderSizePixel = 1, 0
	sheet.ScrollBarThickness, sheet.ScrollingDirection = 4, Enum.ScrollingDirection.Y
	sheet.Position, sheet.Size = UDim2.fromOffset(0, 44), UDim2.new(1, 0, 1, -48)
	sheet.CanvasSize, sheet.Visible, sheet.Parent = UDim2.new(), false, panel
	local card = desktopTemplate:FindFirstChild("PlayerDropDown", true):Clone()
	card.Parent = sheet
	local back = Instance.new("TextButton")
	back.Name, back.Text = "BackToList", "‹  Back"
	back.FontFace, back.TextSize, back.TextColor3 = title.FontFace, 16, title.TextColor3
	back.TextXAlignment, back.BackgroundTransparency = Enum.TextXAlignment.Left, 1
	back.Size, back.Position = UDim2.fromOffset(76, 44), UDim2.fromOffset(12, 0)
	back.ZIndex, back.Visible, back.Parent = 4, false, panel
	local mobile = {
		screen = screen, panel = panel, column = column, body = body, scroll = scroll, rowHost = rowHost,
		header = header.ChildrenFrame, titleBar = header, card = card, close = close, backdrop = backdrop,
		templateRow = templateRow,
		pin = pin, back = back, sheet = sheet,
	}
	function mobile:newTabLabel(source)
		local button = Instance.new("TextButton")
		button.BackgroundTransparency, button.BorderSizePixel, button.AutoButtonColor = 1, 0, false
		button.FontFace, button.TextSize, button.TextColor3 = source.FontFace, source.TextSize, source.TextColor3
		button.TextXAlignment, button.TextYAlignment = source.TextXAlignment, source.TextYAlignment
		button.TextTransparency, button.AutoLocalize = source.TextTransparency, source.AutoLocalize
		button.ClipsDescendants = true
		return button
	end
	function mobile:resize(viewport)
		local short, long = math.min(viewport.X, viewport.Y), math.max(viewport.X, viewport.Y)
		-- Match the captured mobile panel's portrait/landscape proportions inside the safe area.
		local minor = math.clamp(270 + (short - 320) * 60 / 55, math.min(270, math.max(1, short - 12)), 500)
		local major = math.clamp(434 + (long - 480) * 46 / 190, math.min(434, math.max(1, long - 12)), 600)
		local width = if viewport.X > viewport.Y then major else minor
		local height = if viewport.X > viewport.Y then minor else major
		if sheet.Visible then height = math.max(height, card.Size.Y.Offset + 48) end
		width, height = math.min(width, math.max(1, viewport.X - 12)), math.min(height, math.max(1, viewport.Y - 12))
		panel.Size = UDim2.fromOffset(math.floor(width), math.floor(height))
		return math.floor(width), math.floor(height)
	end
	function mobile:showProfile(visible)
		content.Visible, sheet.Visible, back.Visible = not visible, visible, visible
		title.Visible = not visible and title.Text ~= ""
		if not visible then
			sheet.CanvasPosition = Vector2.zero
			self:resize(screen.AbsoluteSize)
		end
	end
	function mobile:listTopInset(nav)
		-- Without a title the scope tabs and close button can share the top touch row.
		local sharedHeader = title.Text == "" and nav.Visible
		local inset = if sharedHeader then 0 else 44
		content.Size = UDim2.new(1, 0, 1, -inset)
		local scopes = nav.Scopes
		scopes.Size = UDim2.new(1, if sharedHeader then -48 else 0, 0, scopes.Size.Y.Offset)
		return inset
	end
	function mobile:positionProfile()
		local height = card.Size.Y.Offset
		local _, panelHeight = self:resize(screen.AbsoluteSize)
		local paneHeight = math.max(1, panelHeight - 48)
		card.AnchorPoint = Vector2.new(0.5, 0)
		card.Position = UDim2.new(0.5, 0, 0, math.max(0, math.floor((paneHeight - height) / 2)))
		sheet.CanvasSize = UDim2.fromOffset(0, height)
	end
	return mobile
end

-- The source of the UI is the PlayerList captured in Studio. Only runtime data is rebound.
local function startClient(config, fetchGlobal, tabSource, attachVisibility)
	local Players = game:GetService("Players")
	local StarterGui = game:GetService("StarterGui")
	local GuiService = game:GetService("GuiService")
	local Input = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	local packagedTemplate = script:FindFirstChild("StockPlayerList")
	local template = packagedTemplate or restoreStockTemplate("StockPlayerList")
	if type(config.Appearance) == "table" and next(config.Appearance) ~= nil then
		if packagedTemplate then template = packagedTemplate:Clone() end
		applyAppearance(template, config.Appearance)
	end
	local mobile = if useMobileLayout(config) then createMobileLayout(config, template) else nil
	local screen = if mobile then mobile.screen else template:Clone()
	if not mobile then screen:SetAttribute("RosterLayout", "desktop") end
	screen.Name = "Roster"
	screen.ResetOnSpawn = false
	if config.DisplayOrder then screen.DisplayOrder = config.DisplayOrder end
	local connections, records, rowPool = {}, {}, {}
	local columns = config.Columns or {}
	local autoColumns = config.Columns == nil
	local tabs = {Here = {}}
	local activeTab, activeScope, selected = "Here", "Here", nil
	local entries, globalRows = {}, {}
	local status = ""
	local destroyed, opened = false, false
	local pending, orderDirty, schemaDirty, layoutDirty = false, true, autoColumns, true
	local cardDirty = true
	local sortId, descending = config.SortBy, true
	local revision, request, lastEntryCount = 0, 0, -1
	local pendingFetch, retryTask = nil, nil
	local nameEffects, badgeHints
	local paintedNames = {}
	local render, schedule, refreshGlobal, setOpen, selectTab, choose
	local acceptsTouch, releaseTouches
	if mobile then acceptsTouch,releaseTouches=trackRosterTouches(Input) end
	local function activate(button,callback)
		if not acceptsTouch then return button.Activated:Connect(callback) end
		return button.Activated:Connect(function(pointer,...)
			if acceptsTouch(pointer) then callback(pointer,...) end
		end)
	end

	local function listen(bucket, signal, fn)
		table.insert(bucket, signal:Connect(fn))
	end
	local function clear(bucket)
		for _, connection in ipairs(bucket) do connection:Disconnect() end
		table.clear(bucket)
	end
	local function call(fn, ...)
		if type(fn) == "function" then
			local ok, result = pcall(fn, ...)
			if ok then return result end
		end
		return nil
	end
	local function getStyle(player)
		local style = call(config.StylePlayer, player)
		return if type(style) == "table" then style else {}
	end
	local function getValue(record, column)
		if column.Attribute then return record.player:GetAttribute(column.Attribute) end
		local stat = record.stats[column.Stat or column.Id]
		return if stat then stat.Value else nil
	end
	local function formatCell(column, value, player)
		if value == nil then return "—" end
		local result = call(column.Format, value, player)
		return tostring(if result ~= nil then result else value)
	end
	local function asset(value)
		if type(value) == "number" then return "rbxassetid://" .. tostring(value) end
		return if type(value) == "string" then value else ""
	end

	-- Preserve the captured CoreGui's insets, display order, colors, fonts, anchors and corners.
	local root = if mobile then mobile.panel else screen:FindFirstChild("Children")
	local surface = if mobile then mobile.panel else root.OffsetFrame.PlayerScrollList.SizeOffsetFrame
	local column = if mobile then mobile.column else surface.Column
	local body = if mobile then mobile.body else column.Body
	local scroller = if mobile then mobile.scroll else body.ScrollingFrameClippingFrame.ScrollingFrame
	local rowHost = if mobile then mobile.rowHost else scroller.OffsetUndoFrame.TeamList_Neutral
	local header = column.TitleBar.ChildrenFrame
	local people = header.playersHeader
	local card = if mobile then mobile.card else body.PlayerDropDown
	local cardInner = card.InnerFrame
	local cardHeader = cardInner.PlayerHeader
	local banner = cardHeader.Background
	local avatar = cardHeader.AvatarImage
	local cardText = banner.TextContainerFrame
	local cardName, handle = cardText.DisplayName, cardText.PlayerName
	local inspect = cardInner.InspectButton
	local close = if mobile then mobile.close else surface.TopRoundedRect.DismissIconFrame.DismissButton
	local nav = column.LegacyTwoTabsTabsRow
	local sourceRow = if mobile then mobile.templateRow else template:FindFirstChild("TeamList_Neutral",true):FindFirstChildWhichIsA("Frame")
	assert(sourceRow, "Stock player row is missing")
	local sourceButton = if mobile then sourceRow else sourceRow.PlayerEntryContentFrame
	local sourceOverlay = if mobile then sourceRow.ChildrenFrame else sourceButton.OverlayFrame
	local function firstWithPrefix(node,prefix)
		for _,child in ipairs(node:GetChildren()) do
			if child.Name:sub(1,#prefix)==prefix then return child end
		end
	end
	local sourceCell = assert(firstWithPrefix(sourceOverlay,"GameStat_"), "Stock stat cell is missing")
	local sourceHeader = assert(firstWithPrefix(if mobile then header else template:FindFirstChild("TitleBar",true).ChildrenFrame,"stat_"), "Stock stat header is missing")
	if mobile then sourceHeader = sourceHeader:Clone() end
	local sourceName = sourceOverlay.NameFrame.PlayerName.PlayerName
	local sourceIcon = sourceOverlay.NameFrame.PlayerIcon
	local baseWidth, cellWidth, rowHeight = sourceOverlay.NameFrame.Size.X.Offset,sourceCell.Size.X.Offset,sourceRow.Size.Y.Offset
	local widthRemainder = if mobile then 4 else root.Size.X.Offset - baseWidth - cellWidth*2
	local normalText, nativeFace = sourceName.TextColor3,sourceName.FontFace
	local cardColor,cardFace = cardName.TextColor3,cardName.FontFace
	local originalBanner,originalBannerTint = banner.Image,banner.ImageColor3
	local originalTextPos,originalTextSize = cardText.Position,cardText.Size
	local originalCardWidth=card.Size.X.Offset
	local originalCardX,originalCardYOffset=card.Position.X,card.Position.Y.Offset
	local originalBodyWidth=scroller.Size.X
	local originalTabsSize=nav.Size
	local baseRootSize = root.Size
	local visibleColumns = {}
	local nameWidth = baseWidth
	local viewHeight = rowHeight
	local currentIndex = {}
	local lastMetric, metricOrder, scopeControls, metricControls = {},{},{},{}
	local selectedControlsColor = sourceName.TextColor3
	local popupStats = {}
	local bridge
	local function wipeChildren(parent,prefix)
		for _,child in ipairs(parent:GetChildren()) do
			if child.Name:sub(1,#prefix)==prefix then child:Destroy() end
		end
	end
	wipeChildren(rowHost,"PlayerEntry_")
	wipeChildren(header,"stat_")
	wipeChildren(nav,"Roster")
	card.Visible=false
	cardName.Text,handle.Text,avatar.Image="","",""
	screen.Enabled=false
	-- UIListLayout is retained for native row placement; one invisible spacer represents rows above the viewport.
	local spacer=Instance.new("Frame")
	spacer.Name,spacer.BackgroundTransparency,spacer.BorderSizePixel="LeadingSpace",1,0
	spacer.LayoutOrder,spacer.Size=0,UDim2.fromOffset(0,0)
	spacer.Parent=rowHost
	scroller.AutomaticCanvasSize=Enum.AutomaticSize.None
	local function hitTarget(label, callback)
		local button=Instance.new("TextButton")
		button.Name,button.Text,button.BackgroundTransparency,button.BorderSizePixel="Activate","",1,0
		button.Size,button.ZIndex=UDim2.fromScale(1,1),label.ZIndex+1
		button.Parent=label
		activate(button,callback)
		return button
	end
	local function setFace(text,face,default)
		if typeof(face)=="Font" then text.FontFace=face
		elseif typeof(face)=="EnumItem" and face.EnumType==Enum.Font then text.Font=face
		else text.FontFace=default end
	end
	local function manager()
		if not nameEffects then
			nameEffects=createRosterNameEffects(config.Effects or {},GuiService,RunService)
			nameEffects:SetOpen(opened)
		end
		return nameEffects
	end
	local tagFields={"Color","Gradient","Animate","StrokeColor","StrokeTransparency","StrokeThickness"}
	local function mergeNameTag(result,overrides)
		if type(overrides)~="table" then return end
		if overrides.FontFace~=nil or overrides.Font~=nil then result.Font=overrides.FontFace or overrides.Font end
		for _,key in ipairs(tagFields) do
			if overrides[key]~=nil then result[key]=overrides[key] end
		end
		if overrides.Effect~=nil then result.Effect=overrides.Effect
		elseif overrides.Effects~=nil then result.Effect=overrides.Effects end
	end
	local function resolveName(style,isCard)
		local result={}
		local cardStyle=if isCard and type(style.Card)=="table" then style.Card else nil
		if cardStyle and cardStyle.NameTag==false then return result end
		local tag=style.NameTag
		-- Legacy decorated cards had their own NameFont/NameColor; explicit NameTag styles inherit.
		if tag~=false and (not cardStyle or tag~=nil or cardStyle.NameTag~=nil) then
			result.Font=style.FontFace or style.Font
			result.Color,result.Gradient,result.Animate=style.Color,style.Gradient,style.Animate
			mergeNameTag(result,tag)
		end
		if cardStyle then
			if cardStyle.NameFont~=nil then result.Font=cardStyle.NameFont end
			if cardStyle.NameColor~=nil then result.Color=cardStyle.NameColor end
			mergeNameTag(result,cardStyle.NameTag)
		end
		return result
	end
	local function releaseName(label)
		local state=paintedNames[label]
		if not state then return end
		if nameEffects then
			if state.effect then nameEffects:Release(label) end
			if state.gradient then nameEffects:SetLegacyGradient(state.gradient,false) end
		end
		if state.gradient then state.gradient:Destroy() end
		if state.stroke then state.stroke:Destroy() end
		label.TextStrokeColor3,label.TextStrokeTransparency=state.strokeColor,state.strokeTransparency
		paintedNames[label]=nil
	end
	-- A game can rebuild its style table when only a stat tile changed. Keep the lettering
	-- bound when its own settings are equal, including a newly constructed color palette.
	local function sameNameSpec(a,b,depth)
		if a==b then return true end
		if depth==0 or type(a)~="table" or type(b)~="table" then return false end
		for key,value in pairs(a) do if not sameNameSpec(value,b[key],depth-1) then return false end end
		for key in pairs(b) do if a[key]==nil then return false end end
		return true
	end
	local function paintName(label,content,style,identity,styleVersion,isCard)
		local state=paintedNames[label]
		if state and state.identity==identity and state.styleVersion==styleVersion and state.content==content then return end
		local tag=resolveName(style,isCard)
		if state and state.identity==identity and state.content==content and sameNameSpec(state.tag,tag,3) then
			state.styleVersion=styleVersion
			return
		end
		if state then
			-- Release restores the previous native text visibility before the new base is painted.
			if state.effect and nameEffects then nameEffects:Release(label) end
			if state.gradient and nameEffects then nameEffects:SetLegacyGradient(state.gradient,false) end
		else
			state={strokeColor=label.TextStrokeColor3,strokeTransparency=label.TextStrokeTransparency}
			paintedNames[label]=state
		end
		if type(tag.Effect)=="table" then
			tag.Effect=table.clone(tag.Effect)
			if type(tag.Effect.Colors)=="table" then tag.Effect.Colors=table.clone(tag.Effect.Colors) end
		end
		state.tag=tag
		local enabled=config.Features.NameEffects
		label.Text=content
		setFace(label,tag.Font,if isCard then cardFace else nativeFace)
		local hasGradient=enabled and typeof(tag.Gradient)=="ColorSequence"
		label.TextColor3=if hasGradient then Color3.new(1,1,1) elseif typeof(tag.Color)=="Color3" then tag.Color else (if isCard then cardColor else normalText)
		if hasGradient then
			if not state.gradient then
				state.gradient=Instance.new("UIGradient")
				state.gradient.Name,state.gradient.Parent="NameEffect",label
			end
			state.gradient.Color,state.gradient.Offset=tag.Gradient,Vector2.zero
		elseif state.gradient then
			state.gradient:Destroy()
			state.gradient=nil
		end
		local hasOutline=typeof(tag.StrokeColor)=="Color3" or type(tag.StrokeTransparency)=="number" or type(tag.StrokeThickness)=="number"
		local strokeColor=if typeof(tag.StrokeColor)=="Color3" then tag.StrokeColor else state.strokeColor
		local rawTransparency=tonumber(tag.StrokeTransparency)
		local transparency=if rawTransparency and rawTransparency==rawTransparency then math.clamp(rawTransparency,0,1) elseif hasOutline then 0 else state.strokeTransparency
		local thickness=tag.StrokeThickness
		if type(thickness)~="number" or thickness~=thickness or math.abs(thickness)==math.huge then thickness=1 end
		if thickness<=0 then transparency=1 end
		label.TextStrokeColor3=strokeColor
		if thickness~=1 and transparency<1 then
			if not state.stroke then
				state.stroke=Instance.new("UIStroke")
				state.stroke.Name,state.stroke.ApplyStrokeMode,state.stroke.Parent="RosterNameStroke",Enum.ApplyStrokeMode.Contextual,label
			end
			state.stroke.Color,state.stroke.Thickness,state.stroke.Transparency=strokeColor,thickness,transparency
			label.TextStrokeTransparency=1
		else
			if state.stroke then state.stroke:Destroy();state.stroke=nil end
			label.TextStrokeTransparency=transparency
		end
		local effect=tag.Effect
		state.effect=if enabled and (type(effect)=="string" or type(effect)=="table") then effect else nil
		state.animateGradient=hasGradient and tag.Animate==true and not state.effect
		state.identity,state.styleVersion,state.content=identity,styleVersion,content
		if state.effect then manager():Bind(label,state.effect) end
	end
	local function showName(label,visible,priority)
		local state=paintedNames[label]
		if not state then return end
		if state.effect then manager():SetVisible(label,visible,priority) end
		if state.animateGradient and (visible or nameEffects) then
			manager():SetLegacyGradient(state.gradient,visible,priority)
		end
	end
	local role=handle:Clone()
	role.Name,role.Text,role.Visible,role.LayoutOrder="Role","",false,3
	role.TextSize=math.max(12,handle.TextSize-3)
	role.Parent=cardText
	local function makeRow(pinnedHost)
		local host=pinnedHost or sourceRow:Clone()
		local button=if mobile then host else host.PlayerEntryContentFrame
		local overlay=if mobile then button.ChildrenFrame else button.OverlayFrame
		local nameFrame=overlay.NameFrame
		local name=nameFrame.PlayerName.PlayerName
		local icon=nameFrame.PlayerIcon
		wipeChildren(overlay,"GameStat_")
		if not pinnedHost then host.Name="PlayerEntry" end
		name.Text=""
		icon.Visible=false
		local row={host=host,button=button,overlay=overlay,nameFrame=nameFrame,name=name,icon=icon,
			cells={},badges={},hovered=false,pinned=pinnedHost~=nil}
		if config.Features.Cards then
			activate(button,function(pointer)
				if badgeHints and badgeHints:Consumed(pointer) then return end
				if row.entry and row.host.Visible and (not row.pinned or activeTab=="Here") then
					choose(if selected==row.entry then nil else row.entry)
				end
			end)
		end
		button.MouseEnter:Connect(function()
			row.hovered=true
			if row.entry then row.overlay.BackgroundTransparency=sourceOverlay.BackgroundTransparency end
		end)
		button.MouseLeave:Connect(function()
			row.hovered=false
			if row.entry~=selected then row.overlay.BackgroundTransparency=1 end
		end)
		if not pinnedHost then host.Parent=rowHost end
		return row
	end
	local pinnedRow = if mobile then makeRow(mobile.pin) else nil
	local function badgeContent(definition)
		if type(definition) ~= "table" then
			return asset(definition), "", "", "Left"
		end
		local side = definition.Position
		return asset(definition.Image), if type(definition.Emoji) == "string" then definition.Emoji else "",
			tostring(definition.Text or ""), if side == "Right" or side == "Behind" then side else "Left"
	end
	local function clearBadge(badge)
		if badge then
			badge.Visible=false
			if badgeHints then badgeHints:Bind(badge,nil) end
		end
	end
	local function bindHint(badge,tip)
		if config.Tooltips~=false and type(tip)=="string" and tip~="" and not badgeHints then
			badgeHints=createRosterBadgeHints(screen,function(node)
				return opened and not destroyed and (not mobile or not selected or node:IsDescendantOf(card))
			end,if mobile then mobile.panel else scroller,card)
		end
		if badgeHints then badgeHints:Bind(badge,tip) end
	end
	local function setBadge(row,slot,definition,maxWidth)
		local badge=row.badges[slot]
		local pic,emoji,caption,side=badgeContent(definition)
		local behind=side=="Behind"
		if (pic=="" and emoji=="" and caption=="") or (not behind and maxWidth<=0) then
			clearBadge(badge)
			return 0
		end
		local style=if type(definition)=="table" then definition else {}
		local defaultSize=if behind then math.round(rowHeight*1.35) else config.IconSizes.Badge or sourceIcon.Size.Y.Offset
		local height=rosterIconSize(style.Size,defaultSize,if behind then rowHeight*3 else rowHeight)
		local width=if pic~="" or emoji~="" or behind then height else math.clamp(5+(utf8.len(caption) or 1)*6,16,48)
		if not behind then
			if maxWidth<math.min(12,width) then clearBadge(badge);return 0 end
			width=math.min(width,maxWidth)
			if pic~="" or emoji~="" then height=width end
		end
		if not badge then
			badge=Instance.new("Frame")
			badge.Name,badge.BackgroundTransparency,badge.BorderSizePixel="Badge"..slot,1,0
			badge.Active,badge.Selectable,badge.Interactable=false,false,false
			local picture=Instance.new("ImageLabel")
			picture.Name,picture.BackgroundTransparency,picture.Size,picture.ScaleType="Image",1,UDim2.fromScale(1,1),Enum.ScaleType.Fit
			picture.Active,picture.Selectable,picture.Interactable=false,false,false
			picture.Parent=badge
			local tag=sourceCell.PlayerStatDisplay:Clone()
			tag.Name,tag.BackgroundTransparency,tag.AutomaticSize="Text",1,Enum.AutomaticSize.None
			tag.Active,tag.Selectable,tag.Interactable=false,false,false
			tag.AnchorPoint,tag.Position,tag.Size=Vector2.zero,UDim2.new(),UDim2.fromScale(1,1)
			tag.TextXAlignment,tag.TextYAlignment,tag.Parent=Enum.TextXAlignment.Center,Enum.TextYAlignment.Center,badge
			row.badges[slot]=badge
		end
		local opacity=style.Transparency
		if type(opacity)~="number" or opacity~=opacity then opacity=if behind then 0.8 else 0 end
		opacity=math.clamp(opacity,0,1)
		local tint=if typeof(style.Color)=="Color3" then style.Color else nil
		local nameHost=row.nameFrame.PlayerName
		local anchor=if behind and style.Align=="Right" then 1 elseif behind and style.Align~="Left" then 0.5 else 0
		badge.Parent=if side=="Left" then row.nameFrame else nameHost
		badge.LayoutOrder=if side=="Left" then nameHost.LayoutOrder-9+slot else slot
		badge.AnchorPoint=if side=="Left" then Vector2.zero else Vector2.new(anchor,0.5)
		badge.Position=if behind then UDim2.fromScale(anchor,0.5) else UDim2.new()
		badge.ZIndex=if behind then 1 else row.nameFrame.ZIndex
		badge.Image.ZIndex,badge.Text.ZIndex=badge.ZIndex,badge.ZIndex
		if behind then row.name.ZIndex=math.max(2,row.name.ZIndex) end
		badge.Visible,badge.Size=true,UDim2.fromOffset(width,height)
		badge.Image.Image,badge.Image.Visible,badge.Image.ImageTransparency=pic,pic~="",opacity
		badge.Image.ImageColor3=tint or Color3.new(1,1,1)
		badge.Image.ImageRectSize=if typeof(style.ImageRectSize)=="Vector2" then style.ImageRectSize else Vector2.zero
		badge.Image.ImageRectOffset=if typeof(style.ImageRectOffset)=="Vector2" then style.ImageRectOffset else Vector2.zero
		badge.Text.Text,badge.Text.Visible,badge.Text.TextTransparency=if emoji~="" then emoji else caption,pic=="",opacity
		badge.Text.TextColor3=tint or sourceCell.PlayerStatDisplay.TextColor3
		badge.Text.TextSize=if emoji~="" then height else math.max(1,math.min(12,sourceCell.PlayerStatDisplay.TextSize,height))
		bindHint(badge,style.Tooltip)
		return if behind then 0 else width+row.nameFrame.Layout.Padding.Offset
	end
	local function alignRight(row)
		if not row.right or #row.right==0 then return end
		local pixels=row.name.AbsoluteSize.X
		if pixels<=0 then return end
		local x=math.ceil(math.min(row.name.TextBounds.X/pixels,1)*row.name.Size.X.Offset)
		local gap=row.nameFrame.Layout.Padding.Offset
		for _,badge in ipairs(row.right) do
			badge.Position=UDim2.new(0,x+gap,0.5,0)
			x+=gap+badge.Size.X.Offset
		end
	end
	local function badgeSetting(value,default,maximum)
		return if type(value)=="number" and value==value then math.clamp(math.round(value),0,maximum) else default
	end
	local function syncIcon(row,entry,style)
		local badges=if config.Features.Badges and type(style.Badges)=="table" then style.Badges else {}
		local count=math.min(#badges,badgeSetting(config.MaxBadges,4,8))
		local record=entry.record
		local nativeOwner=record and game.CreatorType==Enum.CreatorType.User and game.CreatorId==entry.userId
		row.icon.Visible=config.Features.Badges and nativeOwner==true and count==0
		row.icon.Text=if row.icon.Visible then "hammer-code" else ""
		if row.icon.Visible then row.icon.TextTransparency=0 end
		local gap=if count>0 then badgeSetting(config.NameBadgeGap,3,32) else sourceOverlay.NameFrame.Layout.Padding.Offset
		row.nameFrame.Layout.Padding=UDim.new(0,gap)
		local padding=row.nameFrame:FindFirstChildWhichIsA("UIPadding")
		local slots=0
		for i=1,count do
			local pic,emoji,caption,side=badgeContent(badges[i])
			if side~="Behind" and (pic~="" or emoji~="" or caption~="") then slots+=1 end
		end
		local inset=if padding then padding.PaddingLeft.Offset+padding.PaddingRight.Offset else 0
		local available=math.max(0,nameWidth-inset-6-row.name.TextSize*3)
		local occupied=0
		if row.icon.Visible then
			local size=rosterIconSize(config.IconSizes.Badge,sourceIcon.Size.X.Offset,math.min(rowHeight,math.max(0,available-gap)))
			row.icon.Size=UDim2.fromOffset(size,size)
			row.icon.TextSize=math.max(1,math.round(sourceIcon.TextSize*size/math.max(1,sourceIcon.Size.Y.Offset)))
			row.icon.Visible=size>0
			if size>0 then occupied=size+gap end
		end
		row.name.ZIndex=sourceName.ZIndex
		if row.right then table.clear(row.right) end
		local trailing=0
		for i=1,count do
			local pic,emoji,caption,side=badgeContent(badges[i])
			local width=math.min(available-gap,math.max(12,math.floor(available/math.max(1,slots))-gap))
			local used=setBadge(row,i,badges[i],width)
			if side~="Behind" and (pic~="" or emoji~="" or caption~="") then slots-=1 end
			available-=used
			if side=="Right" and used>0 then
				if not row.right then
					row.right={}
					for _,key in {"TextBounds","AbsoluteSize"} do
						row.name:GetPropertyChangedSignal(key):Connect(function() alignRight(row) end)
					end
				end
				table.insert(row.right,row.badges[i])
				trailing+=used
			else occupied+=used end
		end
		for i,badge in pairs(row.badges) do if i>count then clearBadge(badge) end end
		row.nameFrame.PlayerName.Size=UDim2.new(1,-math.max(6,occupied+6),1,0)
		row.nameFrame.PlayerName.ClipsDescendants=true
		row.name.AutomaticSize=Enum.AutomaticSize.None
		row.name.Size=if trailing>0 then UDim2.new(0,math.max(0,nameWidth-inset-occupied-trailing-6),1,0) else UDim2.fromScale(1,1)
		row.name.TextTruncate=Enum.TextTruncate.AtEnd
		alignRight(row)
	end
	local function cellAt(row,i)
		local cell=row.cells[i]
		if not cell then
			local host=sourceCell:Clone()
			host.Name,host.LayoutOrder,host.Parent="GameStat",i,row.overlay
			cell={host=host,text=host.PlayerStatDisplay}
			row.cells[i]=cell
		end
		return cell
	end
	local function showCell(cell,column,value,player,width)
		local pic=if column and config.Features.ItemImages then asset(call(column.Image,value,player)) else ""
		local maxArt=math.min(rowHeight,math.floor(width/2)-3)
		local size=if pic~="" then rosterIconSize(column.IconSize,config.IconSizes.Stat or 16,maxArt) else 0
		if size==0 then pic="" end
		cell.host.Visible,cell.host.Size=true,UDim2.new(0,width,sourceCell.Size.Y.Scale,sourceCell.Size.Y.Offset)
		cell.text.Text=if column then formatCell(column,value,player) else tostring(call(tabs[activeTab].Format,value) or value or "—")
		local color=if column then call(column.Color,value,player) else nil
		cell.text.TextColor3=if typeof(color)=="Color3" then color else sourceCell.PlayerStatDisplay.TextColor3
		if pic~="" and not cell.picture then
			local art=Instance.new("ImageLabel")
			art.Name,art.BackgroundTransparency,art.BorderSizePixel,art.ScaleType="ItemImage",1,0,Enum.ScaleType.Fit
			art.Position,art.AnchorPoint=UDim2.new(0,2,0.5,0),Vector2.new(0,0.5)
			art.Parent=cell.host
			cell.picture=art
		end
		if cell.picture then
			cell.picture.Visible,cell.picture.Image,cell.picture.Size=pic~="",pic,UDim2.fromOffset(size,size)
		end
		cell.text.TextTruncate=Enum.TextTruncate.AtEnd
		local inset=if pic~="" then size+3 else 0
		cell.text.Size,cell.text.Position=UDim2.new(1,-inset,1,0),UDim2.fromOffset(inset,0)
	end
	local function bind(row,entry,index)
		local record=entry.record
		local version=if record then record.version else 0
		local isSelected=selected==entry
		row.host.Visible,row.host.LayoutOrder=true,if row.pinned then 2 else index
		if row.entry==entry and row.version==version and row.revision==revision and row.selected==isSelected then return end
		row.entry,row.version,row.revision,row.selected=entry,version,revision,isSelected
		if not row.pinned then row.host.Name="PlayerEntry_"..tostring(entry.userId) end
		row.nameFrame.Size=UDim2.new(0,nameWidth,sourceOverlay.NameFrame.Size.Y.Scale,sourceOverlay.NameFrame.Size.Y.Offset)
		row.button.BackgroundTransparency=if record and record.player==Players.LocalPlayer then sourceButton.BackgroundTransparency else 1
		if not mobile then
			row.button.DoubleOverLay.BackgroundTransparency=if isSelected then sourceButton.DoubleOverLay.BackgroundTransparency else 1
		end
		row.overlay.BackgroundTransparency=if row.hovered or isSelected then sourceOverlay.BackgroundTransparency else 1
		local style=if record then record.style else {}
		local content=if record then record.player.DisplayName else "#"..tostring(entry.rank or index).."   "..tostring(entry.name or (if tabs[activeTab].ShowProfiles==false then "Player" else "User "..entry.userId))
		paintName(row.name,content,style,entry,if record then record.styleVersion else 0,false)
		syncIcon(row,entry,style)
		for i,info in ipairs(visibleColumns) do
			local col=info.column
			local value=if record then getValue(record,col) else entry.score
			showCell(cellAt(row,i),col,value,if record then record.player else nil,info.width)
		end
		for i=#visibleColumns+1,#row.cells do row.cells[i].host.Visible=false end
	end

	local function bar(parent,name)
		local host=Instance.new("ScrollingFrame")
		host.Name,host.BackgroundTransparency,host.BorderSizePixel,host.ScrollBarThickness=name,1,0,0
		host.ScrollingDirection,host.AutomaticCanvasSize,host.CanvasSize=Enum.ScrollingDirection.X,Enum.AutomaticSize.X,UDim2.new()
		host.Size=UDim2.new(1,0,0,column.TitleBar.Size.Y.Offset)
		local layout=Instance.new("UIListLayout")
		layout.FillDirection,layout.SortOrder,layout.VerticalAlignment=Enum.FillDirection.Horizontal,Enum.SortOrder.LayoutOrder,Enum.VerticalAlignment.Center
		layout.Parent,host.Parent=host,parent
		return host
	end
	local scopes=bar(nav,"Scopes")
	local metrics=bar(nav,"Metrics")
	local scopeHeight=if mobile then 42 else 28
	local metricHeight=if mobile then 36 else column.TitleBar.Size.Y.Offset
	scopes.Size,scopes.AutomaticCanvasSize=UDim2.new(1,0,0,scopeHeight),Enum.AutomaticSize.None
	scopes.CanvasSize,scopes.ScrollingEnabled=UDim2.fromScale(1,0),false
	metrics.Position=UDim2.fromOffset(0,scopeHeight)
	metrics.Size=UDim2.new(1,0,0,metricHeight)
	local scopeRule=Instance.new("Frame")
	scopeRule.Name,scopeRule.BorderSizePixel="ScopeDivider",0
	scopeRule.BackgroundColor3,scopeRule.BackgroundTransparency=selectedControlsColor,0.8
	scopeRule.Size,scopeRule.Position,scopeRule.Parent=UDim2.new(1,0,0,1),UDim2.fromOffset(0,scopeHeight-1),nav
	local function tabLabel(host,id,text,i,fn)
		local node=if mobile then mobile:newTabLabel(sourceHeader) else sourceHeader:Clone()
		node.Name,node.Text,node.LayoutOrder=id,text,i
		if mobile then node.TextSize=15 end
		node.Size=UDim2.new(0,if mobile then math.clamp(20+utf8.len(text)*8,68,160) else math.clamp(18+utf8.len(text)*7,42,130),1,0)
		node.TextTruncate=Enum.TextTruncate.AtEnd
		node.Parent=host
		if mobile then activate(node,fn) else hitTarget(node,fn) end
		return node
	end
	local function visitScope(scope)
		if scope=="Here" then return selectTab("Here") end
		if not config.Features[scope] then return false end
		local last=lastMetric[scope] or activeTab
		if last~="Here" and tabs[last] and (scope=="Global" or tabs[last].Friends==true) then return selectTab(last,scope) end
		for _,id in ipairs(metricOrder) do
			if scope=="Global" or tabs[id].Friends==true then return selectTab(id,scope) end
		end
		return false
	end
	for i,id in ipairs({"Here","Friends","Global"}) do
		local label=tabLabel(scopes,id,if id=="Here" then config.HereLabel or "Here" else id,i,function() visitScope(id) end)
		label.TextSize,label.TextXAlignment=if mobile then 16 else 14,Enum.TextXAlignment.Center
		local underline=Instance.new("Frame")
		underline.Name,underline.BorderSizePixel,underline.BackgroundColor3="ActiveUnderline",0,selectedControlsColor
		underline.Size,underline.Position,underline.ZIndex=UDim2.new(1,0,0,2),UDim2.new(0,0,1,-2),3
		underline.Parent=label
		scopeControls[id]=label
	end
	local refresh=tabLabel(metrics,"Refresh","Refresh",999,function() refreshGlobal() end)
	local function paintNavigation()
		local hasBoards=#metricOrder>0
		nav.Visible=hasBoards
		metrics.Visible=hasBoards and activeScope~="Here"
		nav.AutomaticSize=Enum.AutomaticSize.None
		nav.Size=UDim2.new(originalTabsSize.X.Scale,originalTabsSize.X.Offset,0,
			if hasBoards then scopeHeight+(if metrics.Visible then metricHeight else 0) else 0)
		local hasFriends=false
		for _,id in ipairs(metricOrder) do if tabs[id].Friends==true then hasFriends=true break end end
		scopeControls.Global.Visible=config.Features.Global
		scopeControls.Friends.Visible=hasFriends and config.Features.Friends
		local scopeCount=1+(if scopeControls.Global.Visible then 1 else 0)+(if scopeControls.Friends.Visible then 1 else 0)
		for key,node in pairs(scopeControls) do
			node.Size=UDim2.fromScale(1/scopeCount,1)
			node.ActiveUnderline.Visible=key==activeScope
			node.TextColor3=if key==activeScope then selectedControlsColor else sourceHeader.TextColor3
			node.TextTransparency=if key==activeScope then 0 elseif mobile then 0.04 else 0.22
		end
		for key,node in pairs(metricControls) do
			node.Visible=activeScope~="Friends" or tabs[key].Friends==true
			node.TextColor3=if key==activeTab then selectedControlsColor else sourceHeader.TextColor3
			node.TextTransparency=if key==activeTab then 0 elseif mobile then 0.04 else 0.22
		end
		refresh.Visible=metrics.Visible
	end
	local function replaceTabs(definitions)
		for key,node in pairs(metricControls) do node:Destroy();metricControls[key],tabs[key]=nil,nil end
		table.clear(metricOrder)
		for _,tab in ipairs(definitions or {}) do
			if type(tab)=="table" and type(tab.Id)=="string" and not tabs[tab.Id] then
				local id=tab.Id
				tabs[id]=tab
				table.insert(metricOrder,id)
				metricControls[id]=tabLabel(metrics,id,tostring(tab.Label or id),#metricOrder,function() selectTab(id,activeScope) end)
			end
		end
		layoutDirty=true
		if selectTab then
			if not tabs[activeTab] or (activeScope=="Friends" and not tabs[activeTab].Friends) then selectTab("Here")
			else selectTab(activeTab,activeScope) end
		else paintNavigation() end
	end
	local function sortBy(id)
		if activeScope~="Here" then return end
		descending=if sortId==id then not descending else true
		sortId,orderDirty=id,true
		schedule()
	end
	hitTarget(people,function() sortBy(nil) end)
	local headers={}
	local function measure()
		local screenSize=screen.AbsoluteSize
		local scale=math.max(0.1,surface.UIScale.Scale)
		local maxWidth=math.max(1,math.floor(screenSize.X/scale)-8)
		local panelHeight
		if mobile then maxWidth,panelHeight=mobile:resize(screenSize) end
		local count=if activeTab=="Here" then math.min(#columns,4) else 1
		local function calcName(n) return math.max(76,baseWidth+(math.min(4,n)-2)*11) end
		table.clear(visibleColumns)
		local total=0
		for i=1,count do
			local col=if activeTab=="Here" then columns[i] else nil
			local artWidth=if col and col.Image and config.Features.ItemImages then
				rosterIconSize(col.IconSize,config.IconSizes.Stat or 16,rowHeight)+4 else 0
			local width=if col then math.clamp(tonumber(col.Width) or (cellWidth+artWidth),32,200) else cellWidth
			if mobile and activeTab~="Here" then
				local label=tostring(tabs[activeTab].ColumnLabel or "Score")
				width=math.min(math.max(108,20+(utf8.len(label) or #label)*9),math.max(1,math.floor(maxWidth*0.5)))
			end
			if i>1 and (if mobile then 92 else calcName(i))+total+width+widthRemainder>maxWidth then break end
			if mobile then width=math.min(width,math.max(1,maxWidth-total-widthRemainder-76)) end
			total+=width
			table.insert(visibleColumns,{column=col,width=width})
		end
		nameWidth=if mobile then math.max(1,maxWidth-total-widthRemainder) else math.clamp(maxWidth-total-widthRemainder,1,calcName(#visibleColumns))
		local width=math.max(1,math.min(maxWidth,nameWidth+total+widthRemainder))
		if not mobile then root.Size=UDim2.new(0,width,baseRootSize.Y.Scale,baseRootSize.Y.Offset) end
		people.Size=UDim2.new(0,nameWidth,people.Size.Y.Scale,people.Size.Y.Offset)
		for i,info in ipairs(visibleColumns) do
			local node=headers[i]
			if not node then
				node=sourceHeader:Clone()
				node.Name,node.LayoutOrder,node.Parent="StatHeader"..i,i+1,header
				hitTarget(node,function() local info=visibleColumns[i];if info and info.column then sortBy(info.column.Id) end end)
				headers[i]=node
			end
			node.Visible=true
			node.Size=UDim2.new(0,info.width,sourceHeader.Size.Y.Scale,sourceHeader.Size.Y.Offset)
			node.TextTruncate=Enum.TextTruncate.AtEnd
			node.Text=if info.column then tostring(info.column.Label or info.column.Id) else tostring(tabs[activeTab].ColumnLabel or "Score")
		end
		for i=#visibleColumns+1,#headers do headers[i].Visible=false end
		if mobile then
			mobile.pin.Visible=activeTab=="Here" and records[Players.LocalPlayer.UserId]~=nil
			local pinHeight=if mobile.pin.Visible then rowHeight else 0
			viewHeight=math.max(1,panelHeight-mobile:listTopInset(nav)-nav.Size.Y.Offset-column.TitleBar.Size.Y.Offset-pinHeight)
			body.Size=UDim2.new(1,0,0,viewHeight)
			return
		end
		local ceiling=math.max(rowHeight,screenSize.Y*baseRootSize.Y.Scale/scale + baseRootSize.Y.Offset
			-surface.TopRoundedRect.Size.Y.Offset-column.TitleBar.Size.Y.Offset-surface.BottomRoundedRect.Size.Y.Offset-nav.Size.Y.Offset)
		viewHeight=math.min(math.max(1,#entries)*rowHeight,ceiling)
		body.Size=UDim2.new(body.Size.X.Scale,body.Size.X.Offset,0,viewHeight)
		scroller.Size=UDim2.new(originalBodyWidth.Scale,originalBodyWidth.Offset,0,viewHeight)
	end
	local state=sourceCell.PlayerStatDisplay:Clone()
	state.Name,state.Text,state.Size,state.Visible="Status","",UDim2.new(1,0,0,rowHeight),false
	state.LayoutOrder=0
	state.Parent=rowHost

	local cardStats=column.TitleBar:Clone()
	cardStats.Name,cardStats.LayoutOrder,cardStats.Visible="Stats",2,false
	cardStats.ChildrenFrame:Destroy()
	cardStats.Size=UDim2.new(1,0,0,42)
	cardStats.Parent=cardInner
	local function cardIconSize(key,override,fallback,limit)
		local configured=rosterIconSize((config.IconSizes or {})[key],fallback,limit)
		return rosterIconSize(override,configured,limit)
	end
	local function fillCardStat(i,count,title,value,art,tint,spec,pictureColor,iconOverride,width)
		local tile=popupStats[i]
		if not tile then
			local cell=sourceCell:Clone()
			cell.Name,cell.Parent="Stat"..i,cardStats
			local caption=sourceHeader:Clone()
			caption.Name,caption.Size,caption.Parent="Caption",UDim2.new(1,0,0,16),cell
			local val=cell.PlayerStatDisplay
			val.TextTruncate=Enum.TextTruncate.AtEnd
			local pic=Instance.new("ImageLabel")
			pic.Name,pic.BackgroundTransparency,pic.ScaleType="ItemImage",1,Enum.ScaleType.Fit
			pic.Size,pic.Position,pic.Parent=UDim2.fromOffset(16,16),UDim2.fromOffset(3,20),cell
			local radius=Instance.new("UICorner")
			radius.CornerRadius,radius.Parent=UDim.new(),cell
			local outline=Instance.new("UIStroke")
			outline.ApplyStrokeMode,outline.Thickness,outline.Enabled,outline.Parent=Enum.ApplyStrokeMode.Border,1,false,cell
			tile={cell=cell,caption=caption,value=val,pic=pic,radius=radius,outline=outline}
			popupStats[i]=tile
		end
		tile.caption.Text,tile.value.Text,tile.tint=title,value,tint
		tile.pic.Image,tile.pic.Visible=art or "",art~=nil and art~=""
		tile.pic.ImageColor3=pictureColor or Color3.new(1,1,1)
		local gap=if spec then 4 else 0
		local y=if spec then 4 else 0
		tile.cell.Size=UDim2.new(1/count,-2*gap,1,-2*y)
		tile.cell.Position,tile.cell.Visible=UDim2.new((i-1)/count,gap,0,y),true
		tile.cell.BackgroundTransparency=if spec then 0 else 1
		tile.cell.BackgroundColor3=if spec then (spec.BackgroundColor or cardInner.BackgroundColor3):Lerp(Color3.new(1,1,1),0.065) else sourceCell.BackgroundColor3
		tile.radius.CornerRadius=UDim.new(0,if spec then 5 else 0)
		local colored=typeof(tint)=="Color3"
		tile.outline.Enabled=spec~=nil and colored
		if colored then tile.outline.Color,tile.outline.Transparency=tint,0.38 end
		local tileWidth=(width or originalCardWidth)/count-2*gap
		local maxIcon=math.max(1,math.min(cardStats.Size.Y.Offset-2*y-5,tileWidth-34))
		local icon=cardIconSize("Tile",iconOverride or (spec and spec.TileIconSize),if spec then 18 else 16,maxIcon)
		local x=if tile.pic.Visible then icon+(if spec then 5 else 3) else 0
		local contentY=if spec then 3 else 0
		tile.pic.Size=UDim2.fromOffset(icon,icon)
		tile.pic.Position=if spec then UDim2.new(0,4,0.5,-icon/2) else UDim2.new(0,3,0.5,7-icon/2)
		tile.caption.Position,tile.caption.Size=UDim2.fromOffset(x,contentY),UDim2.new(1,-x,0,16)
		tile.caption.TextSize=if spec then 11 else sourceHeader.TextSize
		tile.caption.TextTruncate=Enum.TextTruncate.AtEnd
		tile.caption.TextColor3=if spec and colored then tint else sourceHeader.TextColor3
		tile.value.Size,tile.value.Position=UDim2.new(1,-x,1,-15-contentY),UDim2.fromOffset(x,15+contentY)
		tile.value.TextColor3=if colored then tint else sourceCell.PlayerStatDisplay.TextColor3
	end
	local socialTarget,friendState,blockedState,friendJob=nil,nil,nil,nil
	local function stopSocial()
		if friendJob and coroutine.status(friendJob)=="suspended" then pcall(task.cancel,friendJob) end
		friendJob,socialTarget,friendState,blockedState=nil,nil,nil,nil
	end
	local function loadSocial(player)
		if socialTarget==player then return end
		stopSocial()
		socialTarget=player
		if not player or player.UserId<=0 or config.ShowSocialActions==false then return end
		friendJob=task.defer(function()
			local ok,friends=pcall(Players.LocalPlayer.IsFriendsWithAsync,Players.LocalPlayer,player.UserId)
			local got,blocked=pcall(StarterGui.GetCore,StarterGui,"GetBlockedUserIds")
			if destroyed or socialTarget~=player then return end
			friendState=if ok then friends else nil
			blockedState=if got and type(blocked)=="table" then table.find(blocked,player.UserId)~=nil else nil
			friendJob=nil
			cardDirty=true
			schedule()
		end)
	end
	local actionLayout
	local actionSuspended=false
	local function clearCardInteraction()
		if actionLayout and not actionSuspended then
			actionLayout.clearInteraction()
			actionSuspended=true
		end
	end
	local function action(name,order,clicked)
		local node=inspect:Clone()
		node.Name,node.LayoutOrder,node.Visible=name,order,false
		local content=node.HoverBackground
		content.Text.Text=name
		local icon=asset((config.ActionIcons or {})[name])
		content.Icon.Visible,content.Icon.Image=icon~="",icon
		activate(node,function(pointer)
			local target=socialTarget
			if target and selected and selected.userId==target.UserId and target.Parent==Players and target~=Players.LocalPlayer
				and (not actionLayout or actionLayout.allowsBuiltin(name,pointer)) then clicked(target) end
		end)
		node.Parent=cardInner
		return node
	end
	local function prompt(key,target)
		choose(nil)
		local ok,err=pcall(StarterGui.SetCore,StarterGui,key,target)
		if not ok then warn("Roster: "..key.." was unavailable: "..tostring(err)) end
	end
	local trade=action("Trade",3,function(target) choose(nil);call(config.OnTrade,target) end)
	local friend=action("Friend",4,function(target)
		if friendState~=nil then prompt(if friendState then "PromptUnfriend" else "PromptSendFriendRequest",target) end
	end)
	inspect.LayoutOrder=5
	local block=action("Block",6,function(target)
		if blockedState~=nil then prompt(if blockedState then "PromptUnblockPlayer" else "PromptBlockPlayer",target) end
	end)
	local function inspectUser(pointer)
		if inspect.Visible and config.Features.AvatarAction and selected and (selected.record or tabs[activeTab].ShowProfiles~=false)
			and (not actionLayout or actionLayout.allowsBuiltin("Avatar",pointer)) then
			local userId=selected.userId
			local player=selected.record and selected.record.player
			choose(nil)
			if userId>0 then
				pcall(GuiService.InspectPlayerFromUserId,GuiService,userId)
			elseif player and player.Character then
				local humanoid=player.Character:FindFirstChildOfClass("Humanoid")
				if humanoid then pcall(function()
					GuiService:InspectPlayerFromHumanoidDescription(humanoid:GetAppliedDescription(),player.DisplayName)
				end) end
			end
		end
	end
	activate(inspect,inspectUser)
	activate(cardHeader,inspectUser)
	-- A short desktop viewport cannot always fit both the list and its popup.
	-- Parent the popup above the list only in that case; restore the captured hierarchy afterwards.
	local popupLayer,modalScale
	local nativeCardAnchor,nativeCardZ=card.AnchorPoint,card.ZIndex
	local function restoreCardDock()
		if not popupLayer or card.Parent~=popupLayer then return end
		card.Parent,card.AnchorPoint,card.ZIndex=body,nativeCardAnchor,nativeCardZ
		modalScale:Destroy()
		modalScale=nil
		popupLayer.Visible=false
		surface.Visible=true
	end
	local function showCardModal(scale)
		if not popupLayer then
			popupLayer=Instance.new("Frame")
			popupLayer.Name,popupLayer.Size,popupLayer.BackgroundTransparency="CardModal",UDim2.fromScale(1,1),1
			popupLayer.ZIndex,popupLayer.Parent=root.ZIndex+5,screen
			local dismiss=Instance.new("TextButton")
			dismiss.Name,dismiss.Text,dismiss.BorderSizePixel,dismiss.AutoButtonColor="Dismiss","",0,false
			dismiss.Size,dismiss.BackgroundColor3,dismiss.BackgroundTransparency=UDim2.fromScale(1,1),Color3.fromRGB(16,16,20),0.35
			dismiss.ZIndex,dismiss.Selectable,dismiss.Parent=1,false,popupLayer
			activate(dismiss,function() choose(nil) end)
		end
		if card.Parent~=popupLayer then
			card.Parent,card.AnchorPoint,card.ZIndex=popupLayer,Vector2.new(0.5,0.5),2
			modalScale=Instance.new("UIScale")
			modalScale.Parent=card
		end
		modalScale.Scale=math.max(0.01,math.min(scale,(screen.AbsoluteSize.X-8)/math.max(1,card.Size.X.Offset),
			(screen.AbsoluteSize.Y-8)/math.max(1,card.Size.Y.Offset)))
		surface.Visible,popupLayer.Visible=false,true
		card.Position=UDim2.fromScale(0.5,0.5)
	end
	local function positionCard()
		if not selected then return end
		if mobile then mobile:positionProfile(); return end
		local index=currentIndex[selected]
		if not index then
			clearCardInteraction()
			restoreCardDock()
			card.Visible=false
			return
		end
		local scale=math.max(0.1,surface.UIScale.Scale)
		local localY=(index-1)*rowHeight-scroller.CanvasPosition.Y
		-- Native dropdown aligns its header with the chosen row. Close it when that row scrolls away.
		if localY+rowHeight<=0 or localY>=viewHeight then
			clearCardInteraction()
			restoreCardDock()
			card.Visible=false
			showName(cardName,false,100)
			return
		end
		local origin=screen.AbsolutePosition
		local room=screen.AbsoluteSize.Y/scale
		local bodyY=(body.AbsolutePosition.Y-origin.Y)/scale
		local height=card.Size.Y.Offset
		local hasLeftRoom=(body.AbsolutePosition.X-origin.X)/scale>=card.Size.X.Offset
		if hasLeftRoom and height<=room then
			restoreCardDock()
			local y=math.clamp(localY+originalCardYOffset,-bodyY,room-bodyY-height)
			card.Position=UDim2.new(originalCardX.Scale,originalCardX.Offset,0,y)
		else
			local cap=surface.BottomRoundedRect
			local bottom=math.max((cap.AbsolutePosition.Y+cap.AbsoluteSize.Y-origin.Y)/scale,
				bodyY+viewHeight+cap.Size.Y.Offset)
			local below=bottom+6
			local above=(surface.TopRoundedRect.AbsolutePosition.Y-origin.Y)/scale-6-height
			if below+height<=room-4 or above>=4 then
				restoreCardDock()
				card.Position=UDim2.new(1,0,0,(if below+height<=room-4 then below else above)-bodyY)
			else
				showCardModal(scale)
			end
		end
		card.Visible=true
		-- Scrolling can bring the same selected row back without selecting it again.
		if actionSuspended then cardDirty=true;schedule() end
	end
	-- Extend the captured header and buttons only for players who supply a Card style.
	-- Switching back to an unstyled player restores the original Roblox properties.
	local function createCardDesigner()
		local saved, extras, active = {}, nil, false
		local function remember(node, fields)
			local values={}
			for _,field in ipairs(fields) do values[field]=node[field] end
			saved[node]=values
		end
		remember(cardInner,{"BackgroundColor3","BackgroundTransparency"})
		remember(cardHeader,{"Size"})
		remember(banner,{"Size","Position","AnchorPoint","BackgroundColor3","BackgroundTransparency","ImageTransparency","ScaleType"})
		remember(avatar,{"Size","Position","AnchorPoint","BackgroundColor3","BackgroundTransparency","ScaleType"})
		remember(cardStats,{"Size","BackgroundTransparency"})
		for _,text in ipairs({cardName,handle,role}) do
			remember(text,{"Size","TextSize","TextScaled","TextTruncate","TextColor3"})
		end
		local function corner(node,radius)
			local ui=Instance.new("UICorner")
			ui.Name,ui.CornerRadius,ui.Parent="CardCorner",radius,node
			return ui
		end
		local function mount()
			local nodes={}
			nodes.base=corner(cardInner,UDim.new(0,8))
			nodes.banner=corner(banner,UDim.new(0,6))
			nodes.avatar=corner(avatar,UDim.new(0.5,0))
			local ring=Instance.new("UIStroke")
			ring.Name,ring.ApplyStrokeMode,ring.Thickness,ring.Parent="AvatarRing",Enum.ApplyStrokeMode.Border,2,avatar
			nodes.ring=ring
			local art=Instance.new("ImageLabel")
			art.Name,art.BackgroundTransparency,art.ScaleType="FeaturedImage",1,Enum.ScaleType.Fit
			art.AnchorPoint,art.Parent=Vector2.new(1,0),banner
			nodes.art=art
			local odds=sourceCell.PlayerStatDisplay:Clone()
			odds.Name,odds.AnchorPoint,odds.TextTruncate,odds.Parent="FeaturedText",Vector2.new(1,1),Enum.TextTruncate.AtEnd,banner
			odds.Font,odds.TextSize=Enum.Font.BuilderSansBold,14
			nodes.odds=odds
			return nodes
		end
		local function restore()
			for node,values in pairs(saved) do
				for key,value in pairs(values) do node[key]=value end
			end
			if extras then
				for _,node in pairs(extras) do node:Destroy() end
			end
			extras,active=nil,false
		end
		local function header(spec,width,hasAvatar,images)
			if not spec then
				if active then restore() end
				return
			end
			if not extras then extras=mount() end
			active=true
			local bg=spec.BackgroundColor or Color3.fromRGB(28,28,33)
			cardInner.BackgroundColor3,cardInner.BackgroundTransparency=bg,0
			cardStats.Size,cardStats.BackgroundTransparency=UDim2.new(1,0,0,49),1
			local compact=width<260
			local large=GuiService.PreferredTextSize~=Enum.PreferredTextSize.Medium
			local bannerInsetY=5
			local bannerHeight=if large then 88 else 76
			local divider=cardHeader:FindFirstChild("Divider")
			local dividerHeight=if divider and divider.Visible then divider.Size.Y.Offset else 0
			-- The native divider sits inside the header's bottom edge.
			cardHeader.Size=UDim2.new(1,0,0,bannerInsetY*2+bannerHeight+dividerHeight)
			banner.AnchorPoint,banner.Position,banner.Size=Vector2.zero,UDim2.fromOffset(6,bannerInsetY),UDim2.new(1,-12,0,bannerHeight)
			banner.ScaleType,banner.BackgroundColor3,banner.BackgroundTransparency=Enum.ScaleType.Crop,spec.BannerColor or bg,0
			banner.Image=if images then asset(spec.BannerImage) else ""
			banner.ImageColor3=spec.BannerImageColor or Color3.new(1,1,1)
			banner.ImageTransparency=math.clamp(tonumber(spec.BannerImageTransparency) or 0,0,1)
			local art=if images then asset(spec.FeaturedImage) else ""
			local odds=if spec.FeaturedText~=nil then tostring(spec.FeaturedText) else ""
			local hasFeatured=art~="" or odds~=""
			local minName=math.max(40,math.min(104,width*0.33))
			local maxAvatar=math.max(1,math.min(bannerHeight-6,width-minName-(if hasFeatured then 48 else 0)-38))
			local diameter=cardIconSize("Avatar",spec.AvatarSize,if compact then 40 else 49,maxAvatar)
			avatar.AnchorPoint,avatar.Position,avatar.Size=Vector2.new(0,0.5),UDim2.fromOffset(13,bannerInsetY+bannerHeight/2),UDim2.fromOffset(diameter,diameter)
			avatar.BackgroundColor3,avatar.BackgroundTransparency=spec.AvatarBackgroundColor or bg,if spec.AvatarBackgroundColor then 0 else 1
			avatar.ScaleType=Enum.ScaleType.Crop
			extras.avatar.CornerRadius=if spec.AvatarRingColor or spec.AvatarBackgroundColor then UDim.new(0.5,0) else UDim.new()
			extras.ring.Enabled=hasAvatar and spec.AvatarRingColor~=nil
			if extras.ring.Enabled then extras.ring.Color=spec.AvatarRingColor end
			local left=if hasAvatar then diameter+16 else 9
			local maxRight=math.max(1,width-19-left-minName)
			local maxArt=math.max(1,math.min(maxRight-4,bannerHeight-(if odds~="" then 23 else 4)))
			local artSize=cardIconSize("Featured",spec.FeaturedSize,if compact then 42 else 53,maxArt)
			local right=if hasFeatured then math.min(maxRight,math.max(if art~="" then artSize+6 else 0,if odds~="" then (if compact then 52 else 66) else 0)) else 0
			extras.art.Image,extras.art.Visible=art,art~=""
			local availableArtHeight=bannerHeight-(if odds~="" then 19 else 0)
			extras.art.Position=UDim2.new(1,-3-(right-artSize)/2,0,math.max(0,(availableArtHeight-artSize)/2))
			extras.art.Size=UDim2.fromOffset(artSize,artSize)
			extras.odds.Text,extras.odds.Visible,extras.odds.TextColor3=odds,odds~="",spec.FeaturedColor or Color3.fromRGB(255,191,136)
			extras.odds.Size,extras.odds.Position=UDim2.fromOffset(right,19),UDim2.new(1,-3,1,-2)
			cardText.Position,cardText.Size=UDim2.fromOffset(left,0),UDim2.new(1,-left-right-7,1,0)
			local sizes=if large then {19,15,16} else {16,12,13}
			for i,text in ipairs({cardName,handle,role}) do
				text.TextScaled,text.TextSize,text.TextTruncate=false,sizes[i],Enum.TextTruncate.AtEnd
				text.Size=UDim2.new(1,0,0,sizes[i]+3)
			end
			handle.TextColor3,role.TextColor3=Color3.fromRGB(233,222,223),spec.TitleColor or Color3.fromRGB(255,213,141)
		end
		return {header=header}
	end
	local cardDesigner, genreLayout, cardEmblem
	local presentation = script:FindFirstChild("CardPresentation")
	if presentation then presentation = require(presentation) end
	local decor = {}
	decor.badges = presentation and config.Preset=="Competitive" and config.Features.Badges and
		presentation.badges(cardName,bindHint,asset,badgeSetting(config.MaxBadges,3,3),config.IconSizes.Badge)
	decor.frame = if presentation then presentation.new(card,cardInner) else nil
	decor.presetEmblem = if presentation then presentation.emblem(config,templateIconAssets) else nil
	decor.bio = if config.Preset == "Profile" then require(script.SocialProfile).section(cardInner) else nil
	local function currentActionTarget()
		if destroyed or not opened or not selected or not card.Visible then return nil end
		if not selected.record and (not tabs[activeTab] or tabs[activeTab].ShowProfiles==false) then return nil end
		return Players:GetPlayerByUserId(selected.userId), selected.userId
	end
	local function renderCard()
		card.Visible=opened and selected~=nil
		if mobile then mobile:showProfile(card.Visible) end
		if not card.Visible then
			clearCardInteraction()
			if cardEmblem then cardEmblem.clear() end
			restoreCardDock()
			releaseName(cardName)
			stopSocial()
			return
		end
		cardDesigner=cardDesigner or createCardDesigner()
		if cardEmblem then cardEmblem.restore() end
		if genreLayout then genreLayout.reset() end
		local record=selected.record
		local style=if record then record.style else {}
		local spec=if type(style.Card)=="table" then style.Card else nil
		local features=config.Features or {}
		local images=features.ItemImages~=false
		local frameStyle = config.ProfileFrame
		if frameStyle == nil then frameStyle = config.Preset == "Profile" end
		if spec and spec.Frame ~= nil then frameStyle = spec.Frame end
		if decor.frame then decor.frame(if record and images and style.Card ~= false then frameStyle else false, asset) end
		local width=math.min(originalCardWidth,math.max(1,(if mobile then mobile.panel.Size.X.Offset else screen.AbsoluteSize.X)-8))
		local profiles=record~=nil or tabs[activeTab].ShowProfiles~=false
		local target=if profiles then Players:GetPlayerByUserId(selected.userId) else nil
		local hasAvatar=profiles and (selected.userId>0 or (target~=nil and target.Character~=nil))
		cardDesigner.header(spec,width,hasAvatar,images)
		avatar.Visible=hasAvatar
		avatar.Image=if hasAvatar and selected.userId>0 then ("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150"):format(selected.userId) else ""
		local displayName=if record then record.player.DisplayName else tostring(selected.name or (if profiles then "User "..selected.userId else "Rank #"..tostring(selected.rank or "")))
		handle.Text=if target then "@"..target.Name elseif profiles then "User "..selected.userId else tostring(tabs[activeTab].Label or activeTab)
		if spec and spec.Identity=="UserId" then handle.Text="Player ID:  "..tostring(selected.userId) end
		role.Text,role.Visible=tostring(style.Title or ""),style.Title~=nil and style.Title~=""
		if not spec then
			cardText.Position=if hasAvatar then originalTextPos else UDim2.fromOffset(12,0)
			cardText.Size=if hasAvatar then originalTextSize else UDim2.new(1,-24,1,0)
			if hasAvatar and config.IconSizes.Avatar then
				local diameter=cardIconSize("Avatar",nil,80,math.max(1,math.min(cardHeader.Size.Y.Offset,width-94)))
				avatar.AnchorPoint,avatar.Position=Vector2.new(0,0.5),UDim2.new(0,12,0.5,0)
				avatar.Size=UDim2.fromOffset(diameter,diameter)
				cardText.Position,cardText.Size=UDim2.fromOffset(diameter+22,0),UDim2.new(1,-diameter-30,1,0)
			end
			local art=if images then asset(style.Banner) else ""
			banner.Image,banner.ImageColor3=if art~="" then art else originalBanner,style.BannerColor or originalBannerTint
		end
		paintName(cardName,displayName,style,selected,if record then record.styleVersion else 0,true)
		local statCount=0
		if features.CardStats~=false and spec and type(spec.Tiles)=="table" then
			statCount=math.min(#spec.Tiles,4)
			for i=1,statCount do
				local tile=spec.Tiles[i]
				fillCardStat(i,statCount,tostring(tile.Label or ""),tostring(tile.Text or "—"),
					if images then asset(tile.Image) else "",tile.Color,spec,tile.ImageColor,tile.IconSize,width)
			end
		elseif features.CardStats~=false and config.ShowCardStats==true and record then
			local cardColumns = if config.Preset=="Competitive" and presentation then presentation.matchColumns(columns,record,getValue) else columns
			statCount=math.min(#cardColumns,4)
			for i=1,statCount do
				local col=cardColumns[i]
				local value=getValue(record,col)
				fillCardStat(i,statCount,tostring(col.Label or col.Id),formatCell(col,value,record.player),
					if images then asset(call(col.Image,value,record.player)) else "",call(col.Color,value,record.player),spec,nil,nil,width)
			end
		elseif features.CardStats~=false and not record then
			statCount=2
			fillCardStat(1,2,"Rank","#"..tostring(selected.rank or "—"))
			fillCardStat(2,2,tostring(tabs[activeTab].ColumnLabel or "Score"),tostring(call(tabs[activeTab].Format,selected.score) or selected.score or "—"))
		end
		cardStats.Visible=statCount>0
		for i=statCount+1,#popupStats do popupStats[i].cell.Visible=false end
		local other=if target~=Players.LocalPlayer then target else nil
		loadSocial(if config.ShowSocialActions~=false or config.OnTrade then other else nil)
		trade.Visible=other~=nil and type(config.OnTrade)=="function"
		friend.Visible=other~=nil and config.ShowSocialActions~=false and friendState~=nil
		friend.HoverBackground.Text.Text=if friendState then "Unfriend" else "Add friend"
		inspect.Visible=config.Features.AvatarAction and hasAvatar
		block.Visible=other~=nil and config.ShowSocialActions~=false and blockedState~=nil
		block.HoverBackground.Text.Text=if blockedState then "Unblock" else "Block"
		if spec and (config.Preset=="Competitive" or config.Preset=="Roleplay" or config.Preset=="Profile") then
			genreLayout=genreLayout or createGenreLayout(cardHeader,cardStats,role,presentation)
			genreLayout.apply(config.Preset,spec,width,popupStats,statCount,GuiService.PreferredTextSize~=Enum.PreferredTextSize.Medium)
		end
		local emblem = spec and spec.Emblem
		local customBanner = spec and spec.BannerImage and spec.BannerImage ~= ""
			and not (config.Preset == "Competitive" and spec.BannerImage == competitiveCover)
		if emblem == nil and record and style.Card ~= false and not style.Banner
			and not customBanner and not (spec and (spec.FeaturedImage or spec.FeaturedText)) then
			emblem = decor.presetEmblem
		end
		if type(emblem)=="table" then
			cardEmblem=cardEmblem or createRosterCardEmblem(banner,cardText)
			cardEmblem.apply(emblem,width,images)
		elseif cardEmblem then cardEmblem.clear() end
		if decor.badges then decor.badges(if spec and spec.HeaderLayout=="Match" and spec.ShowBadges~=false then style.Badges else nil) end
		local h=cardHeader.Size.Y.Offset+(if cardStats.Visible then cardStats.Size.Y.Offset else 0)
		if decor.bio then
			h += decor.bio(if record and spec then record.player:GetAttribute("PennantFilteredBio") else nil, width,
				GuiService.PreferredTextSize ~= Enum.PreferredTextSize.Medium)
		end
		actionLayout=actionLayout or createRosterActionLayout(config,cardInner,
			{Avatar=inspect,Trade=trade,Friend=friend,Block=block},activate,currentActionTarget,Players.LocalPlayer,presentation)
		actionSuspended=false
		h+=actionLayout.update(spec,width,target,mobile~=nil or Input.PreferredInput==Enum.PreferredInput.Touch,
			GuiService.PreferredTextSize~=Enum.PreferredTextSize.Medium)
		card.Size=UDim2.fromOffset(width,h)
		positionCard()
	end

	local function buildColumns()
		local names={}
		for _,record in pairs(records) do for id in pairs(record.stats) do names[id]=true end end
		local keys={}
		for id in pairs(names) do table.insert(keys,id) end
		table.sort(keys)
		columns={}
		for _,id in ipairs(keys) do table.insert(columns,{Id=id,Label=id,Stat=id}) end
	end
	local function rebuildOrder()
		if activeTab~="Here" then entries=globalRows return end
		entries={}
		local sortColumn=nil
		for _,col in ipairs(columns) do if col.Id==sortId then sortColumn=col break end end
		for _,record in pairs(records) do
			-- The native mobile Here view owns a separate pinned button for this player.
			if pinnedRow and record.player==Players.LocalPlayer then continue end
			local entry=record.entry
			local value=if sortColumn then getValue(record,sortColumn) else nil
			entry.sortValue=if typeof(value)=="number" and value~=value then nil else value
			table.insert(entries,entry)
		end
		table.sort(entries,function(a,b)
			local av,bv=a.sortValue,b.sortValue
			if av~=bv and sortColumn then
				if av==nil then return false elseif bv==nil then return true end
				local aNumeric,bNumeric=typeof(av)=="number",typeof(bv)=="number"
				if aNumeric~=bNumeric then return aNumeric end
				if not aNumeric then av,bv=tostring(av),tostring(bv) end
				if av~=bv then return if descending then av>bv else av<bv end
			end
			local an,bn=a.record.player.DisplayName:lower(),b.record.player.DisplayName:lower()
			if an~=bn then return if sortColumn or descending then an<bn else an>bn end
			return a.userId<b.userId
		end)
	end

	render=function()
		if destroyed or not opened then return end
		if schemaDirty then buildColumns();schemaDirty,layoutDirty,cardDirty=false,true,true end
		if orderDirty then
			rebuildOrder()
			table.clear(currentIndex)
			for index,entry in ipairs(entries) do currentIndex[entry]=index end
			orderDirty,cardDirty=false,true
		end
		local pinnedRecord=if pinnedRow and activeTab=="Here" then records[Players.LocalPlayer.UserId] else nil
		if pinnedRow and mobile.pin.Visible~=(pinnedRecord~=nil) then layoutDirty=true end
		if #entries~=lastEntryCount then lastEntryCount=#entries;layoutDirty=true end
		if layoutDirty then
			if badgeHints then badgeHints:Hide() end
			measure();revision+=1;layoutDirty,cardDirty=false,true
		end
		if pinnedRecord then
			bind(pinnedRow,pinnedRecord.entry,0)
		elseif pinnedRow and pinnedRow.entry then
			for _,badge in pairs(pinnedRow.badges) do clearBadge(badge) end
			pinnedRow.entry=nil
			releaseName(pinnedRow.name)
		end
		local showingStatus=#entries==0 and pinnedRecord==nil
		state.Visible=showingStatus
		state.Text=if status~="" then status else "No players"
		if activeTab~="Here" and status~="" and #entries>0 then
			people.Text=status
		else
			people.Text="People"
		end
		refresh.Text=if status=="Loading…" then "Loading…" else "Refresh"
		scroller.CanvasSize=UDim2.fromOffset(0,#entries*rowHeight)
		local top=scroller.CanvasPosition.Y
		local first=math.clamp(math.floor(top/rowHeight),1,math.max(1,#entries))
		local last=math.min(#entries,first+math.ceil(viewHeight/rowHeight)+2)
		spacer.Size=UDim2.fromOffset(0,(first-1)*rowHeight)
		local used=0
		for index=first,last do
			used+=1
			local row=rowPool[used]
			if not row then row=makeRow();rowPool[used]=row end
			local entry=entries[index]
			bind(row,entry,index)
			row.inViewport=(index-1)*rowHeight<top+viewHeight and index*rowHeight>top
		end
		for i=used+1,#rowPool do
			if rowPool[i].entry then for _,badge in pairs(rowPool[i].badges) do clearBadge(badge) end end
			rowPool[i].host.Visible,rowPool[i].entry=false,nil
			releaseName(rowPool[i].name)
		end
		if cardDirty then renderCard();cardDirty=false elseif selected then positionCard() end
		local listVisible=surface.Visible and not (mobile and selected~=nil)
		showName(cardName,card.Visible,100)
		if pinnedRecord then showName(pinnedRow.name,listVisible,50) end
		for i=1,used do
			local row=rowPool[i]
			showName(row.name,listVisible and row.inViewport,0)
		end
	end
	schedule=function()
		if pending or destroyed or not opened then return end
		pending=true
		task.defer(function() pending=false;if not destroyed then render() end end)
	end
	choose=function(entry)
		if destroyed or not opened or (entry and not config.Features.Cards) then return end
		if badgeHints then badgeHints:Hide() end
		if selected~=entry then clearCardInteraction();stopSocial() end
		selected,cardDirty=entry,true
		schedule()
	end

	local function cancelFetch()
		request+=1
		if pendingFetch and coroutine.status(pendingFetch)=="suspended" then pcall(task.cancel,pendingFetch) end
		if retryTask and coroutine.status(retryTask)=="suspended" then pcall(task.cancel,retryTask) end
		retryTask=nil
		pendingFetch=nil
	end
	refreshGlobal=function()
		if destroyed or activeTab=="Here" or not opened or pendingFetch then return end
		if retryTask then pcall(task.cancel,retryTask);retryTask=nil end
		request+=1
		local token,id,scope=request,activeTab,activeScope
		status="Loading…"
		schedule()
		pendingFetch=task.defer(function()
			local ok,result=pcall(fetchGlobal,id,scope)
			if destroyed or token~=request or id~=activeTab or scope~=activeScope then return end
			pendingFetch=nil
			if ok and type(result)=="table" and result.ok and type(result.rows)=="table" then
				globalRows=result.rows
				if result.partial then
					local checked,total=tonumber(result.checked) or 0,tonumber(result.total) or 0
					status=if total>0 then string.format("Checking %d/%d",checked,total) else "Checking scores…"
					retryTask=task.delay(math.clamp(tonumber(result.retryAfter) or 8,1,300),function()
						retryTask=nil
						if not destroyed and opened and token==request then refreshGlobal() end
					end)
				elseif #globalRows==0 then
					status=if scope=="Friends" then "No friends have a score on this board." else "No rankings yet"
				else
					status=if result.stale then "Cached" else ""
				end
				if selected then
					local previous=selected.userId
					selected=nil
					for _,entry in ipairs(globalRows) do if entry.userId==previous then selected=entry break end end
					cardDirty=true
				end
			else
				status=if #globalRows>0 then "Cached" else "Rankings unavailable"
			end
			orderDirty=true
			schedule()
		end)
	end

	selectTab=function(id,scope)
		if destroyed then return false end
		if not tabs[id] and (id=="Global" or id=="Friends") then return visitScope(id) end
		if not tabs[id] then return false end
		scope=if id=="Here" then "Here" else scope or (if config.Features.Global then "Global" else "Friends")
		if id~="Here" and not config.Features[scope] then return false end
		if id~="Here" and scope~="Global" and not (scope=="Friends" and tabs[id].Friends==true) then return false end
		if activeTab~=id or activeScope~=scope then
			if badgeHints then badgeHints:Hide() end
			clearCardInteraction()
			cancelFetch();stopSocial()
			activeTab,activeScope,selected,status,globalRows=id,scope,nil,"",{}
			scroller.CanvasPosition=Vector2.zero
			orderDirty,layoutDirty=true,true
		end
		if id~="Here" then lastMetric[scope]=id end
		paintNavigation()
		if id~="Here" and opened then refreshGlobal() end
		schedule()
		return true
	end
	setOpen=function(value)
		if destroyed then return end
		value=value==true
		if opened==value then return end
		opened=value
		screen.Enabled=value
		if value then
			layoutDirty,cardDirty=true,true
			if activeTab~="Here" then refreshGlobal() end
			render()
			if nameEffects then nameEffects:SetOpen(true) end
		else
			clearCardInteraction()
			if badgeHints then badgeHints:Hide() end
			cancelFetch();stopSocial()
			if nameEffects then nameEffects:SetOpen(false) end
			if cardEmblem then cardEmblem.clear() end
			releaseName(cardName)
			selected,card.Visible=nil,false
			restoreCardDock()
			if mobile then mobile:showProfile(false) end
		end
	end

	local function changed(record, id)
		record.version+=1
		if id==nil or id==sortId then orderDirty=true end
		if selected==record.entry then cardDirty=true end
		schedule()
	end
	local function setStats(record)
		clear(record.statConnections)
		table.clear(record.stats)
		local folder=record.player:FindFirstChild(config.StatsFolder or "leaderstats")
		if folder then
			local function attach(stat)
				if stat:IsA("IntValue") or stat:IsA("NumberValue") or stat:IsA("StringValue") or stat:IsA("BoolValue") then
					record.stats[stat.Name]=stat
					listen(record.statConnections,stat:GetPropertyChangedSignal("Value"),function()
						local id=stat.Name
						for _,col in ipairs(columns) do
							if (col.Stat or col.Id)==stat.Name and col.Id==sortId then id=sortId break end
						end
						changed(record,id)
					end)
					listen(record.statConnections,stat:GetPropertyChangedSignal("Name"),function() setStats(record) end)
				end
			end
			for _,stat in ipairs(folder:GetChildren()) do attach(stat) end
			listen(record.statConnections,folder.ChildAdded,function() setStats(record) end)
			listen(record.statConnections,folder.ChildRemoved,function() setStats(record) end)
		end
		if autoColumns then schemaDirty=true end
		changed(record,nil)
	end
	local function watch(player)
		local uid=player.UserId
		if records[uid] then return end
		local record={player=player,version=0,styleVersion=0,style=getStyle(player),stats={},connections={},statConnections={}}
		record.entry={userId=uid,record=record}
		records[uid]=record
		local function styleChanged()
			record.style=getStyle(player)
			record.styleVersion+=1
			changed(record,nil)
		end
		for _,prop in ipairs({"DisplayName","Team"}) do listen(record.connections,player:GetPropertyChangedSignal(prop),styleChanged) end
		if uid<=0 then
			-- Studio's simulated accounts use their spawned character for the avatar inspector.
			listen(record.connections,player:GetPropertyChangedSignal("Character"),function() changed(record,nil) end)
		end
		for _,name in ipairs(config.StyleAttributes or {}) do listen(record.connections,player:GetAttributeChangedSignal(name),styleChanged) end
		for _,col in ipairs(config.Columns or {}) do
			if col.Attribute then listen(record.connections,player:GetAttributeChangedSignal(col.Attribute),function() changed(record,col.Id) end) end
		end
		local function onChild(child)
			if child.Name==(config.StatsFolder or "leaderstats") then setStats(record) end
		end
		listen(record.connections,player.ChildAdded,onChild)
		listen(record.connections,player.ChildRemoved,onChild)
		setStats(record)
	end
	local function unwatch(player)
		local record=records[player.UserId]
		if not record then return end
		clear(record.connections)
		clear(record.statConnections)
		records[player.UserId]=nil
		if selected==record.entry then choose(nil) end
		if autoColumns then schemaDirty=true end
		orderDirty=true
		schedule()
	end

	local controller={}
	function controller:SetOpen(value)
		if destroyed then return end
		if bridge then bridge:SetOpen(value==true) else setOpen(value) end
	end
	function controller:SelectTab(id,scope) return selectTab(id,scope) end
	function controller:SelectPlayer(player)
		if destroyed or not config.Features.Cards or typeof(player)~="Instance" or not player:IsA("Player") then return false end
		local record=records[player.UserId]
		if not record or record.player~=player or player.Parent~=Players then return false end
		self:SetOpen(true)
		selectTab("Here")
		render()
		local index=currentIndex[record.entry]
		if index then
			local y=(index-1)*rowHeight
			local top=scroller.CanvasPosition.Y
			if y<top or y+rowHeight>top+viewHeight then scroller.CanvasPosition=Vector2.new(0,y) end
		end
		choose(record.entry)
		return true
	end
	function controller:Destroy()
		if destroyed then return end
		if releaseTouches then releaseTouches() end
		if template~=packagedTemplate then template:Destroy() end
		if mobile then sourceHeader:Destroy(); sourceRow:Destroy() end
		destroyed=true
		cancelFetch();stopSocial()
		if nameEffects then nameEffects:Destroy();nameEffects=nil end
		if badgeHints then badgeHints:Destroy();badgeHints=nil end
		if actionLayout then actionLayout.destroy() end
		if bridge then bridge:Destroy();bridge=nil end
		clear(connections)
		for _,record in pairs(records) do clear(record.connections);clear(record.statConnections) end
		table.clear(records);table.clear(paintedNames);table.clear(rowPool);table.clear(currentIndex)
		entries,globalRows={},{}
		screen:Destroy()
	end
	replaceTabs(config.Tabs or (tabSource and call(tabSource.Read)) or {})
	if config.Tabs==nil and tabSource then
		listen(connections,tabSource.Changed,function() if not destroyed then replaceTabs(call(tabSource.Read) or {}) end end)
		replaceTabs(call(tabSource.Read) or {})
	end
	listen(connections,Players.PlayerAdded,watch)
	listen(connections,Players.PlayerRemoving,unwatch)
	for _,player in ipairs(Players:GetPlayers()) do watch(player) end
	listen(connections,screen:GetPropertyChangedSignal("AbsoluteSize"),function() layoutDirty=true;schedule() end)
	listen(connections,GuiService:GetPropertyChangedSignal("PreferredTextSize"),function() layoutDirty=true;schedule() end)
	listen(connections,GuiService:GetPropertyChangedSignal("ReducedMotionEnabled"),function() layoutDirty=true;schedule() end)
	listen(connections,scroller:GetPropertyChangedSignal("CanvasPosition"),function()
		if badgeHints then badgeHints:Hide() end
		schedule()
	end)
	listen(connections,body:GetPropertyChangedSignal("AbsolutePosition"),function() if selected and opened then schedule() end end)
	if not mobile then
		local cap=surface.BottomRoundedRect
		local function positionChanged() if opened and selected then schedule() end end
		listen(connections,cap:GetPropertyChangedSignal("AbsolutePosition"),positionChanged)
		listen(connections,cap:GetPropertyChangedSignal("AbsoluteSize"),positionChanged)
	end
	listen(connections,Input.InputBegan,function(input,processed)
		if destroyed or not opened or not selected then return end
		if input.KeyCode==Enum.KeyCode.ButtonB and not processed then choose(nil);return end
		if mobile then return end
		if input.UserInputType~=Enum.UserInputType.MouseButton1 and input.UserInputType~=Enum.UserInputType.Touch then return end
		local function contains(node)
			local p=node.AbsolutePosition
			local s=node.AbsoluteSize
			return input.Position.X>=p.X and input.Position.X<=p.X+s.X and input.Position.Y>=p.Y and input.Position.Y<=p.Y+s.Y
		end
		if not contains(card) and not contains(body) then choose(nil) end
	end)
	activate(close,function() controller:SetOpen(false) end)
	if mobile then
		activate(mobile.back,function() choose(nil) end)
		activate(mobile.backdrop,function() controller:SetOpen(false) end)
	end
	screen.Parent=playerGui
	selectTab("Here")
	bridge=attachVisibility(controller,{
		ApplyOpen=setOpen,GetOpen=function() return opened end,
		DismissCard=function() if selected then choose(nil) return true end return false end,
		Screen=screen,CloseButton=close,StartOpen=config.StartOpen,ToggleKey=config.ToggleKey,
		IsMobile=mobile~=nil,MotionFrame=if mobile then mobile.panel else root.OffsetFrame,ReplaceCoreGui=config.ReplaceCoreGui,
	})
	return controller
end

local function getServerStarter()
	-- Only the server reads ranking sources. Clients can select a configured board ID.
	local DataStoreService = game:GetService("DataStoreService")
	local Players = game:GetService("Players")
	local UserService = game:GetService("UserService")

	local CACHE_SECONDS = 60
	local RETRY_SECONDS = 15
	local MAX_PAGES = 3
	local MAX_ROWS = 100
	local MAX_LOADS = 4
	local REQUEST_BURST = 8
	local REQUESTS_PER_SECOND = 2
	local NAME_BUDGET_PER_MINUTE = 200
	local FRIEND_BATCH_SIZE = 50
	local FRIEND_RETRY_SECONDS = 5
	local SOCIAL_CACHE_SECONDS = 300

	local function isFinite(value)
		return type(value) == "number" and value == value and math.abs(value) < math.huge
	end

	local function isUserId(value)
		return isFinite(value) and value > 0 and value <= 9007199254740991 and value % 1 == 0
	end

	local function accountKey(key)
		if type(key) == "string" and string.match(key, "^%d+$") then
			return tonumber(key)
		end
		return nil
	end

	local function checkListBudget()
		assert(DataStoreService:GetRequestBudgetForRequestType(Enum.DataStoreRequestType.OrderedList) >= 1,
			"Ordered data store list budget is exhausted")
	end

	local function sortRows(rows, board)
		table.sort(rows, function(a, b)
			if a.score == b.score then
				return a.userId < b.userId
			end
			if board.Ascending then
				return a.score < b.score
			end
			return a.score > b.score
		end)
		while #rows > (board.Limit or 25) do
			table.remove(rows)
		end
		for rank, row in ipairs(rows) do
			row.rank = rank
		end
		return rows
	end

	local function scoreInRange(score, board)
		return isFinite(score) and (not board.Min or score >= board.Min) and (not board.Max or score <= board.Max)
	end

	local function readRows(board, requester)
		local limit = board.Limit or 25
		local rows = {}
		local seen = {}
		local function add(userId, score, name)
			if not isUserId(userId) or seen[userId] or not scoreInRange(score, board) then return end
			if type(name) ~= "string" or #name == 0 or #name > 128 or not utf8.len(name) then
				local player = Players:GetPlayerByUserId(userId)
				name = if player then player.DisplayName else nil
			end
			seen[userId] = true
			table.insert(rows, {userId = userId, score = score, name = name})
		end

		if requester or board.Read then
			-- ReadFriends(requester, limit) returns the best rows for that requester and their connections.
			local candidates = if requester then board.ReadFriends(requester, limit) else board.Read(limit)
			assert(type(candidates) == "table", "Ranking provider must return an array of rows")
			for index = 1, math.min(#candidates, MAX_PAGES * MAX_ROWS) do
				local row = candidates[index]
				if type(row) == "table" then
					add(row.userId, row.score, row.name)
				end
			end
		else
			local ordered = DataStoreService:GetOrderedDataStore(board.Store, board.Scope or "global")
			local decode = board.KeyToUserId or accountKey
			checkListBudget()
			local pages = ordered:GetSortedAsync(board.Ascending == true, math.max(25, limit), board.Min, board.Max)
			for page = 1, MAX_PAGES do
				for _, record in ipairs(pages:GetCurrentPage()) do
					-- A legacy or non-player key must not take the board offline.
					local decoded, userId = pcall(decode, record.key)
					if decoded then
						add(userId, record.value)
					end
					if #rows >= limit then
						break
					end
				end
				if #rows >= limit or pages.IsFinished or page == MAX_PAGES then
					break
				end
				checkListBudget()
				pages:AdvanceToNextPageAsync()
			end
		end

		return sortRows(rows, board)
	end

	local function fail(message)
		return {ok = false, stale = false, rows = {}, error = message}
	end

	local function startServer(settings, moduleScript)
		assert(not moduleScript:FindFirstChild("GetRankings"), "GetRankings already exists")
		local boards = {}
		for _, board in ipairs(settings.Boards or {}) do
			assert(type(board.Id) == "string" and #board.Id > 0 and #board.Id <= 64 and not boards[board.Id],
				"Each board needs a unique Id of 1 to 64 bytes")
			assert(board.Read == nil or type(board.Read) == "function", "Board Read must be a function")
			assert(board.ReadFriends == nil or type(board.ReadFriends) == "function", "ReadFriends must be a function")
			assert(type(board.Read) == "function" or (type(board.Store) == "string" and #board.Store > 0),
				"Board " .. board.Id .. " needs a Read function or OrderedDataStore name")
			assert(board.Limit == nil or (isFinite(board.Limit) and board.Limit % 1 == 0
				and board.Limit >= 1 and board.Limit <= MAX_ROWS), "Board Limit must be an integer from 1 to 100")
			assert(board.KeyToUserId == nil or type(board.KeyToUserId) == "function", "Invalid KeyToUserId")
			assert(board.UserIdToKey == nil or type(board.UserIdToKey) == "function", "Invalid UserIdToKey")
			assert((board.Min == nil or isFinite(board.Min)) and (board.Max == nil or isFinite(board.Max))
				and (board.Min == nil or board.Max == nil or board.Min <= board.Max), "Invalid board score bounds")
			if not board.Read then
				assert((board.Min == nil or board.Min % 1 == 0) and (board.Max == nil or board.Max % 1 == 0),
					"OrderedDataStore score bounds must be integers")
			end
			local friends = board.Friends ~= false and (board.ReadFriends ~= nil or (not board.Read
				and (not board.KeyToUserId or board.UserIdToKey ~= nil)))
			boards[board.Id] = {config = board, nextRead = 0, friends = friends, scores = {}, readingIds = {}}
		end

		local active = true
		local loads = 0
		local callers = {}
		local names = {}
		local nameBatches = {}
		local namePauseUntil = 0
		local reservedReads = 0

		local function resolveNames(rows)
			local now = os.clock()
			local remaining = NAME_BUDGET_PER_MINUTE
			for index = #nameBatches, 1, -1 do
				local batch = nameBatches[index]
				if now - batch.time >= 60 then
					table.remove(nameBatches, index)
				else
					remaining -= batch.count
				end
			end
			for userId, cached in pairs(names) do
				if now >= cached.nextLookup + 600 then
					names[userId] = nil
				end
			end
			local wanted = {}
			for _, row in ipairs(rows) do
				if not row.name then
					local cached = names[row.userId]
					row.name = if cached then cached.name else nil
					if now >= namePauseUntil and #wanted < remaining and (not cached or now >= cached.nextLookup) then
						-- Reserve before yielding so simultaneous boards cannot spend the same allowance.
						names[row.userId] = {name = row.name, nextLookup = now + 60}
						table.insert(wanted, row.userId)
					end
				end
			end
			if #wanted == 0 then
				return
			end
			table.insert(nameBatches, {time = now, count = #wanted})
			local ok, infos = pcall(UserService.GetUserInfosByUserIdsAsync, UserService, wanted)
			if not ok then
				namePauseUntil = os.clock() + 60
				return
			end
			for _, info in ipairs(infos) do
				local name = info.DisplayName or info.Username
				if names[info.Id] and type(name) == "string" and name ~= "" then
					names[info.Id] = {name = name, nextLookup = os.clock() + 600}
				end
			end
			for _, row in ipairs(rows) do
				local cached = names[row.userId]
				row.name = if cached and cached.name then cached.name else row.name
			end
		end

		local function wake(slot, response)
			local waiters = slot.waiters
			slot.waiters = nil
			for _, thread in ipairs(waiters or {}) do
				if coroutine.status(thread) == "suspended" then
					task.defer(thread, response)
				end
			end
		end

		local function getMembers(slot)
			local requester = slot.player
			local social = slot.caller.social
			if social.waiters then
				table.insert(social.waiters, coroutine.running())
				local response = coroutine.yield()
				assert(response.ok, "Connection list is unavailable")
				return response.members
			end
			if os.clock() < social.nextRead then
				assert(social.members, "Connection list is unavailable")
				return social.members
			end
			social.waiters = {}
			local ok, members = pcall(function()
				local result = {{id = requester.UserId, name = requester.DisplayName}}
				local seen = {[requester.UserId] = true}
				local ids = requester:GetFriendsWhoPlayedAsync()
				assert(type(ids) == "table", "Missing eligible friends list")
				assert(active and not slot.caller.closed, "Requester has left")
				for _, id in ipairs(ids) do
					if isUserId(id) and not seen[id] then
						seen[id] = true
						table.insert(result, {id = id})
					end
				end
				return result
			end)
			social.members = if ok then members else nil
			social.nextRead = os.clock() + (if ok then SOCIAL_CACHE_SECONDS else RETRY_SECONDS)
			wake(social, {ok = ok, members = social.members})
			if not ok then error(members) end
			return members
		end

		local function readFriendScores(slot)
			local board = slot.config
			local source = boards[board.Id]
			local scan = slot.scan
			if not scan then
				scan = {members = getMembers(slot), nextIndex = 1, rows = {}}
				slot.scan = scan
			end
			assert(active and not slot.caller.closed, "Requester has left")
			local now = os.clock()
			if now >= (source.nextPrune or 0) then
				for id, cached in pairs(source.scores) do
					if now >= cached.expires then source.scores[id] = nil end
				end
				source.nextPrune = now + CACHE_SECONDS
			end
			local budget = DataStoreService:GetRequestBudgetForRequestType(Enum.DataStoreRequestType.OrderedRead)
			-- Reserve at most half of the currently available read budget; even a one-key allowance can progress.
			local available = math.max(0, math.floor(budget) - reservedReads)
			local allowance = math.min(FRIEND_BATCH_SIZE, math.ceil(available / 2))
			local keys, keyMembers, known = {}, {}, {}
			local index = scan.nextIndex
			local first = index
			while index <= #scan.members do
				local member = scan.members[index]
				local cached = source.scores[member.id]
				if cached and now < cached.expires then
					known[member.id] = cached
				else
					if #keys >= allowance or source.readingIds[member.id] then break end
					local key = if board.UserIdToKey then board.UserIdToKey(member.id) else string.format("%.0f", member.id)
					assert(type(key) == "string" and #key > 0 and #key <= 50, "Invalid encoded player key")
					if board.KeyToUserId then
						assert(board.KeyToUserId(key) == member.id, "UserIdToKey must invert KeyToUserId")
					end
					assert(not keyMembers[key], "UserIdToKey must produce unique keys")
					table.insert(keys, key)
					keyMembers[key] = member
				end
				index += 1
			end
			if #keys > 0 then
				local ordered = DataStoreService:GetOrderedDataStore(board.Store, board.Scope or "global")
				for _, member in pairs(keyMembers) do source.readingIds[member.id] = true end
				reservedReads += #keys
				local ok, records = pcall(function() return ordered:BatchGetAsync(keys) end)
				reservedReads -= #keys
				for _, member in pairs(keyMembers) do source.readingIds[member.id] = nil end
				if not ok then error(records) end
				assert(type(records) == "table", "BatchGetAsync returned invalid data")
				for key, member in pairs(keyMembers) do
					local record = records[key]
					local value = if type(record) == "table" then record.value else nil
					local cached = {score = value, expires = os.clock() + CACHE_SECONDS}
					source.scores[member.id] = cached
					known[member.id] = cached
				end
			end
			-- Commit the cursor only after a successful batch. Missing keys count as checked, never as zero.
			for position = first, index - 1 do
				local member = scan.members[position]
				local cached = known[member.id]
				if cached and scoreInRange(cached.score, board) then
					table.insert(scan.rows, {userId = member.id, name = member.name, score = cached.score})
				end
			end
			scan.nextIndex = index
			local partial = index <= #scan.members
			sortRows(scan.rows, board)
			local rows = table.clone(scan.rows)
			if not partial then slot.scan = nil end
			return {ok = true, rows = rows, partial = partial, checked = index - 1, total = #scan.members,
				stale = false, retryAfter = if partial then FRIEND_RETRY_SECONDS else nil}
		end

		local function staleOrFail(slot, message)
			if slot.response and slot.response.ok then
				local response = table.clone(slot.response)
				response.stale = true
				response.retryAfter = RETRY_SECONDS
				return response
			end
			local response = fail(message)
			response.retryAfter = RETRY_SECONDS
			return response
		end

		local function refresh(slot)
			if not active or (slot.caller and slot.caller.closed) then
				loads -= 1
				return
			end
			local board = slot.config
			local ok, result = pcall(function()
				if slot.player and not board.ReadFriends then
					local response = readFriendScores(slot)
					for _, row in ipairs(response.rows) do
						if not row.name then
							local online = Players:GetPlayerByUserId(row.userId)
							row.name = if online then online.DisplayName else nil
						end
					end
					if active and not slot.caller.closed and board.ResolveNames ~= false then
						pcall(resolveNames, response.rows)
					end
					return response
				end
				local rows = readRows(board, slot.player)
				if active and not slot.player and not board.Read and board.ResolveNames ~= false then
					-- A name-service outage must never discard good scores.
					pcall(resolveNames, rows)
				end
				return {ok = true, rows = rows, stale = false, partial = false}
			end)
			loads -= 1
			if not active or (slot.caller and slot.caller.closed) then
				return
			end
			if ok then
				slot.response = result
				slot.nextRead = os.clock() + (if result.partial then FRIEND_RETRY_SECONDS else CACHE_SECONDS)
			else
				warn(("Roster board %q could not refresh: %s"):format(board.Id, tostring(result)))
				slot.response = staleOrFail(slot, "Rankings are temporarily unavailable.")
				slot.nextRead = os.clock() + RETRY_SECONDS
			end
			wake(slot, slot.response)
		end

		local remote = Instance.new("RemoteFunction")
		remote.Name = "GetRankings"
		remote.OnServerInvoke = function(player, boardId, scope)
			if not active or player.Parent ~= Players then
				return fail("Rankings are unavailable.")
			end
			local now = os.clock()
			local caller = callers[player]
			if not caller then
				caller = {time = now, tokens = REQUEST_BURST, pending = 0, boards = {}, social = {nextRead = 0}}
				callers[player] = caller
			end
			caller.tokens = math.min(REQUEST_BURST, caller.tokens + (now - caller.time) * REQUESTS_PER_SECOND)
			caller.time = now
			if caller.tokens < 1 then
				return fail("Please wait a moment before refreshing.")
			end
			caller.tokens -= 1
			if type(boardId) ~= "string" or #boardId > 64 or not boards[boardId] then
				return fail("Unknown leaderboard.")
			end
			local slot = boards[boardId]
			if scope == "Friends" then
				if not slot.friends then return fail("Friends rankings are unavailable for this leaderboard.") end
				if not caller.boards[boardId] then
					caller.boards[boardId] = {config = slot.config, player = player, caller = caller, nextRead = 0}
				end
				slot = caller.boards[boardId]
			elseif scope ~= nil and scope ~= "Global" then
				return fail("Unknown leaderboard scope.")
			end
			if slot.response and now < slot.nextRead then
				return slot.response
			end
			if caller.pending >= MAX_LOADS or (not slot.waiters and loads >= MAX_LOADS) then
				return staleOrFail(slot, "Rankings are busy. Try again shortly.")
			end
			if not slot.waiters then
				slot.waiters = {}
				loads += 1
				task.defer(refresh, slot)
			end
			caller.pending += 1
			table.insert(slot.waiters, coroutine.running())
			local response = coroutine.yield()
			caller.pending -= 1
			return response
		end
		local function closeCaller(player)
			local caller = callers[player]
			if not caller then return end
			caller.closed = true
			local stopped = fail("Rankings are unavailable.")
			wake(caller.social, stopped)
			for _, slot in pairs(caller.boards) do
				wake(slot, stopped)
			end
			callers[player] = nil
		end
		local leaving = Players.PlayerRemoving:Connect(closeCaller)
		remote.Parent = moduleScript
		return {
			Destroy = function()
				if not active then
					return
				end
				active = false
				leaving:Disconnect()
				local stopped = fail("Rankings are unavailable.")
				for _, slot in pairs(boards) do
					wake(slot, stopped)
				end
				for player in pairs(callers) do
					closeCaller(player)
				end
				remote:Destroy()
			end,
		}
	end

	return startServer

end

local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Roster = {Icons = templateIconAssets, ActionIcons = actionArt, Badges = makeBadgeAtlas("rbxassetid://106291295332397"), MakeBadgeAtlas = makeBadgeAtlas}
local clientSession = {}
local serverSession = {}
local profileSession = {}
local catalogAttribute = "RosterBoards"

local function runOnce(session, start)
	if session.handle then return session.handle end
	if session.starting then
		local ok, handle = session.starting.Event:Wait()
		if not ok then error(handle, 2) end
		return handle
	end
	local ready = Instance.new("BindableEvent")
	session.starting = ready
	local ok, handle = pcall(start)
	session.starting = nil
	if ok then
		session.handle = handle
		local teardown = handle.Destroy
		handle.Destroy = function()
			if session.handle ~= handle then return end
			session.handle = nil
			teardown(handle)
		end
	end
	ready:Fire(ok, handle)
	task.defer(function() ready:Destroy() end)
	if not ok then error(handle, 2) end
	return handle
end

-- Named settings inherit individually. Ordered lists such as Columns and Actions are replaced as a whole.
local function mergeSettings(base, overrides)
	local result = table.clone(base)
	for key, value in pairs(overrides) do
		local prior = result[key]
		if type(prior) == "table" and type(value) == "table" and prior[1] == nil and value[1] == nil then
			result[key] = mergeSettings(prior, value)
		else
			result[key] = value
		end
	end
	return result
end

local function readSettings()
	local settings = script:FindFirstChild("Settings")
	if not settings then return {} end
	assert(settings:IsA("ModuleScript"), "Roster.Settings must be a ModuleScript")
	local values = require(settings)
	assert(type(values) == "table", "Roster.Settings must return a table")
	return values
end

-- Client startup. A preview can supply game fixtures as the lowest-priority defaults.
function Roster.Start(config, fallback)
	assert(RunService:IsClient(), "Call Roster.Start from a LocalScript")
	return runOnce(clientSession, function()
		local function fetch(boardId, scope)
			local remote = script:FindFirstChild("GetRankings") or script:WaitForChild("GetRankings", 4)
			if not remote or not remote:IsA("RemoteFunction") then
				return {ok = false, rows = {}, error = "The rankings server is unavailable."}
			end
			return remote:InvokeServer(boardId, scope or "Global")
		end
		local function readCatalog()
			local encoded = script:GetAttribute(catalogAttribute)
			if type(encoded) ~= "string" then return {} end
			local ok, boards = pcall(HttpService.JSONDecode, HttpService, encoded)
			return if ok and type(boards) == "table" then boards else {}
		end
		local defaults = mergeSettings(fallback or {}, readSettings())
		local options, source = configureRoster(withRosterPreset(mergeSettings(defaults, config or {})), {
			Read = readCatalog,
			Changed = script:GetAttributeChangedSignal(catalogAttribute),
		})
		local motion = if type(options.Motion) == "table" then table.clone(options.Motion) else {}
		for _, side in {"Open", "Close"} do
			local value = motion[side]
			if type(value) ~= "table" and (type(value) ~= "string" or value == "") then
				local default = script:GetAttribute(side .. "Animation")
				motion[side] = if type(default) == "string" and default ~= "" then default else "Stock"
			end
		end
		options.Motion = motion
		local function bindVisibility(controller, hooks)
			hooks.ReplaceCoreGui = options.ReplaceCoreGui
			hooks.Motion = options.Motion
			return attachVisibility(controller, hooks)
		end
		return startClient(options, fetch, source, bindVisibility)
	end)
end

-- Server. Configured board definitions and backend callbacks stay in the server caller.
function Roster.ServeProfiles(settings)
	assert(RunService:IsServer(), "Start the bio service from a server Script")
	return runOnce(profileSession, function() return require(script.SocialProfile).serve(settings) end)
end

function Roster.Serve(settings)
	assert(RunService:IsServer(), "Call Roster.Serve from a server Script")
	return runOnce(serverSession, function()
		settings = settings or readSettings()
		local catalog = {}
		for _, board in ipairs(settings.Boards or {}) do
			assert(board.Id ~= "Here", "Here is reserved for the live roster")
			local canReadFriends = if type(board.Read) == "function"
				then type(board.ReadFriends) == "function"
				else board.KeyToUserId == nil or type(board.UserIdToKey) == "function" or type(board.ReadFriends) == "function"
			table.insert(catalog, {
				Id = board.Id, Label = board.Label or board.Id, ColumnLabel = board.ColumnLabel or board.Label or board.Id,
				Friends = board.Friends ~= false and canReadFriends, ShowProfiles = board.ShowProfiles ~= false,
			})
		end
		local encoded = HttpService:JSONEncode(catalog)
		local serve = getServerStarter()
		local handle = serve(settings, script)
		script:SetAttribute(catalogAttribute, encoded)
		local destroy = handle.Destroy
		handle.Destroy = function()
			script:SetAttribute(catalogAttribute, nil)
			destroy(handle)
		end
		return handle
	end)
end

return Roster
