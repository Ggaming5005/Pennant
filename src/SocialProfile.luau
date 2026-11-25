-- Internal implementation for the optional Profile preset.
local Profile = {}
local BIO = "PennantFilteredBio"
local SHARE = "PennantShareAccountBio"

local function clean(value)
	if type(value) ~= "string" or not utf8.len(value) then return nil end
	local boundary = utf8.offset(value, 301)
	value = (if boundary then value:sub(1, boundary - 1) else value):gsub("[%s%c]+", " "):match("^%s*(.-)%s*$")
	return if value ~= "" then value else nil
end

function Profile.serve(settings)
	assert(type(settings) == "table", "Supply a server-only bio source")
	local key, read = settings.ApiKeySecret, settings.ReadBio
	assert(key == nil or (type(key) == "string" and key ~= ""), "ApiKeySecret must be the name of an experience secret")
	assert(read == nil or type(read) == "function", "ReadBio must be a server callback")
	assert(key or read, "Supply ApiKeySecret or ReadBio")
	local players = game:GetService("Players")
	local textService = game:GetService("TextService")
	local http = game:GetService("HttpService")
	local current, waiting = {}, {}
	local occupied, stopped = 0, false
	local function account(player)
		local answer = http:RequestAsync({
			Url = "https://apis.roblox.com/cloud/v2/users/" .. tostring(player.UserId),
			Method = "GET", Headers = {["x-api-key"] = http:GetSecret(key)},
		})
		if not answer.Success then return nil end
		local data = http:JSONDecode(answer.Body)
		if type(data) == "table" and tostring(data.id) == tostring(player.UserId) then return clean(data.about) end
		return nil
	end
	local function active(player, record, version)
		return not stopped and current[player] == record and record.version == version and player.Parent == players
	end
	local function fetch(player, record, version)
		local raw
		if key and player:GetAttribute(SHARE) == true and player.UserId > 0 then
			local ok, value = pcall(account, player)
			if ok then raw = value end
		end
		if not active(player, record, version) then return end
		if not raw and read then
			local ok, value = pcall(read, player)
			if ok then raw = clean(value) end
		end
		if not raw or not active(player, record, version) then return end
		local ok, result = pcall(function()
			local filtered = textService:FilterStringAsync(raw, player.UserId, Enum.TextFilterContext.PublicChat)
			return clean(filtered:GetNonChatStringForBroadcastAsync())
		end)
		if ok and result and active(player, record, version) then player:SetAttribute(BIO, result) end
	end
	local function pump()
		while not stopped and occupied < 2 do
			local player, record = next(waiting)
			if not player then break end
			waiting[player] = nil
			occupied += 1
			local version = record.version
			task.defer(function()
				if active(player, record, version) then fetch(player, record, version) end
				occupied -= 1
				pump()
			end)
		end
	end
	local function refresh(player)
		local record = current[player]
		if not record or stopped then return false end
		if os.clock() - record.last < 60 then return false end
		record.last, record.version = os.clock(), record.version + 1
		player:SetAttribute(BIO, nil)
		waiting[player] = record
		pump()
		return true
	end
	local function clear(player)
		local record = current[player]
		if not record then return end
		record.version += 1
		if record.timer then task.cancel(record.timer); record.timer = nil end
		waiting[player] = nil
		player:SetAttribute(BIO, nil)
	end
	local function attach(player)
		if stopped or current[player] then return end
		local record = {version = 0, last = -math.huge}
		current[player] = record
		player:SetAttribute(BIO, nil)
		if key then
			record.permission = player:GetAttributeChangedSignal(SHARE):Connect(function()
				clear(player)
				if player:GetAttribute(SHARE) == true then
					-- Eligibility may arrive just after join, while a fallback is loading.
					if not record.requestedAccount then record.last = -math.huge end
					record.requestedAccount = true
				end
				if (read or player:GetAttribute(SHARE) == true) and not refresh(player) then
					record.timer = task.delay(math.max(0, record.last + 60 - os.clock()), function()
						record.timer = nil
						refresh(player)
					end)
				end
			end)
			record.requestedAccount = player:GetAttribute(SHARE) == true
		end
		if read or record.requestedAccount then refresh(player) end
	end
	local function detach(player)
		clear(player)
		local record = current[player]
		if record and record.permission then record.permission:Disconnect() end
		current[player] = nil
	end
	local joined = players.PlayerAdded:Connect(attach)
	local left = players.PlayerRemoving:Connect(detach)
	for _, player in ipairs(players:GetPlayers()) do attach(player) end
	return {
		Refresh = function(_, player) return refresh(player) end,
		Clear = function(_, player) clear(player) end,
		Destroy = function()
			stopped = true
			joined:Disconnect()
			left:Disconnect()
			for player in pairs(current) do detach(player) end
		end,
	}
end

function Profile.section(parent)
	local textService = game:GetService("TextService")
	local container, heading, body
	local function label(name, face, color)
		local node = Instance.new("TextLabel")
		node.Name, node.BackgroundTransparency = name, 1
		node.Font, node.TextColor3 = face, color
		node.RichText, node.AutoLocalize = false, false
		node.TextXAlignment, node.TextYAlignment = Enum.TextXAlignment.Left, Enum.TextYAlignment.Top
		node.Parent = container
		return node
	end
	return function(value, width, large)
		local text = clean(value)
		if not text then
			if container then container.Visible = false end
			return 0
		end
		if not container then
			container = Instance.new("Frame")
			container.Name, container.LayoutOrder, container.BackgroundTransparency = "About", 3, 1
			container.Parent = parent
			heading = label("Heading", Enum.Font.BuilderSansBold, Color3.fromRGB(177, 192, 209))
			heading.Text, heading.TextSize = "About", 13
			body = label("Bio", Enum.Font.BuilderSans, Color3.fromRGB(240, 244, 248))
			body.TextWrapped, body.TextTruncate = true, Enum.TextTruncate.AtEnd
		end
		local size, pad = if large then 17 else 15, 14
		local measured = textService:GetTextSize(text, size, body.Font, Vector2.new(math.max(1, width - 2 * pad - 4), 1000))
		local bodyHeight = math.clamp(measured.Y + 2, size + 3, (size + 4) * 5)
		heading.Size, heading.Position = UDim2.new(1, -2 * pad, 0, 17), UDim2.fromOffset(pad, 6)
		body.Text, body.TextSize = text, size
		body.Size, body.Position = UDim2.new(1, -2 * pad, 0, bodyHeight), UDim2.fromOffset(pad, 25)
		local height = 25 + bodyHeight + 8
		container.Size, container.Visible = UDim2.new(1, 0, 0, height), true
		return height
	end
end

return Profile
