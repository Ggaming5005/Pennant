-- Invoked by tests/package.luau. A deterministic heartbeat lets the packaged
-- renderer run an exact two-second loop without timing or rendering dependencies.
local luau = require("@lune/luau")
local roblox = require("@lune/roblox")
local V = roblox.Vector2

local function signal()
	local listeners = {}
	return {
		listeners = listeners,
		Connect = function(_, callback)
			listeners[callback] = true
			return {Disconnect = function() listeners[callback] = nil end}
		end,
		fire = function(_, ...)
			for callback in listeners do callback(...) end
		end,
	}
end

return function(moduleSource)
	local nodes, pending = {}, {}
	local function flush()
		while #pending > 0 do table.remove(pending, 1)() end
	end
	local function instance(class)
		local node = {ClassName = class, Name = class, ZIndex = 1}
		local signals = {}
		function node:GetPropertyChangedSignal(property)
			signals[property] = signals[property] or signal()
			return signals[property]
		end
		function node:FindFirstChild(name)
			for _, child in nodes do
				if child.Parent == self and child.Name == name then return child end
			end
		end
		function node:FindFirstChildWhichIsA(kind)
			for _, child in nodes do
				if child.Parent == self and child.ClassName == kind then return child end
			end
		end
		function node:Destroy()
			for _, child in nodes do
				if child.Parent == self then child:Destroy() end
			end
			self.Parent = nil
		end
		table.insert(nodes, node)
		return node
	end
	local function makeLabel()
		local label = instance("TextLabel")
		label.Parent, label.ContentText, label.TextSize = instance("Frame"), "Pennant", 16
		label.AbsoluteSize, label.TextBounds, label.TextFits = V.new(200, 40), V.new(80, 20), true
		label.TextXAlignment, label.TextYAlignment = roblox.Enum.TextXAlignment.Left, roblox.Enum.TextYAlignment.Center
		label.TextColor3, label.TextTransparency, label.TextStrokeTransparency = roblox.Color3.new(1, 1, 1), 0.15, 1
		return label
	end
	local gui, run = instance("GuiService"), {Heartbeat = signal()}
	local enum = setmetatable({GradientTileMode = {Mirror = "Mirror"}}, {
		__index = function(_, key) return roblox.Enum[key] end,
	})
	local env = {
		Instance = {new = instance}, Enum = enum, Color3 = roblox.Color3, Vector2 = V,
		ColorSequence = roblox.ColorSequence, ColorSequenceKeypoint = roblox.ColorSequenceKeypoint,
		UDim2 = roblox.UDim2, game = {GetService = function() return {} end},
		task = {defer = function(callback) table.insert(pending, callback) end},
	}
	-- Return the real internal renderer through a test-only entry point.
	local source, replacements = moduleSource:gsub("return Roster%s*$", "return createRosterNameEffects")
	assert(replacements == 1)
	local create = luau.load(source, {environment = env, injectGlobals = true})()
	local function gradient(label)
		local root = assert(label:FindFirstChild("RosterNameEffect"))
		return assert(assert(root:FindFirstChild("Lettering")):FindFirstChildWhichIsA("UIGradient"))
	end
	local function near(a, b)
		assert(math.abs(a - b) < 0.0001, ("Expected %f, got %f"):format(b, a))
	end

	local manager = create({MaxAnimatedNames = 1}, gui, run)
	local label, card = makeLabel(), makeLabel()
	manager:SetOpen(true)
	manager:Bind(label, "MovingGradient")
	manager:SetVisible(label, true, 1)
	flush()
	local g = gradient(label)
	assert(g.TileMode == "Mirror" and #g.Color.Keypoints == 3)
	near(g.Scale, 0.4)
	local start = g.Offset
	run.Heartbeat:fire(0.5)
	near(g.Offset.X - start.X, 0.2)
	near(g.Offset.Y, start.Y)
	run.Heartbeat:fire(1.5)
	near(g.Offset.X, start.X)

	local colors = {roblox.Color3.new(1, 0, 0), roblox.Color3.new(0, 0, 1)}
	manager:Bind(card, {Preset = "MovingGradient", Colors = colors, Direction = "Up", Speed = 0.5, BandWidth = 0.5})
	manager:SetVisible(card, true, 100)
	flush()
	local active, idle = gradient(card), gradient(label)
	assert(active.Rotation == 90 and active.Color.Keypoints[2].Value == colors[2])
	near(active.Scale, 0.25)
	local before, resting = active.Offset, idle.Offset
	run.Heartbeat:fire(0.5)
	near(active.Offset.Y - before.Y, -0.0625)
	near(active.Offset.X, before.X)
	assert(idle.Offset == resting and gradient(card) == active, "Budget or gradient reuse regressed")
	card.TextBounds = V.new(80, 32)
	card:GetPropertyChangedSignal("TextBounds"):fire()
	flush()
	near(gradient(card).Scale, 0.4)

	gui.ReducedMotionEnabled = true
	gui:GetPropertyChangedSignal("ReducedMotionEnabled"):fire()
	flush()
	assert(not next(run.Heartbeat.listeners) and gradient(card).Color.Keypoints[1].Value == colors[1])
	manager:SetOpen(false)
	flush()
	assert(not card:FindFirstChild("RosterNameEffect") and label.TextTransparency == 0.15)
	manager:Destroy()
	assert(not next(card:GetPropertyChangedSignal("TextBounds").listeners))

	-- An engine without upgraded UIGradient properties still shows both colors.
	enum.GradientTileMode = false
	gui.ReducedMotionEnabled = false
	local older = create({}, gui, run)
	older:Bind(label, {Preset = "MovingGradient", Colors = colors})
	older:SetVisible(label, true)
	older:SetOpen(true)
	flush()
	assert(not next(run.Heartbeat.listeners))
	local stops = gradient(label).Color.Keypoints
	assert(stops[1].Value == colors[1] and stops[#stops].Value == colors[2])
	older:Destroy()
	print("PASS Moving gradient travel, mirrored loop, fitted palette, visibility budget, reduced motion and cleanup")
end
