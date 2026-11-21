-- LocalScript in StarterPlayer > StarterPlayerScripts.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roster = require(ReplicatedStorage:WaitForChild("Roster"))

local controller = Roster.Start()
script.Destroying:Connect(function()
	controller:Destroy()
end)
