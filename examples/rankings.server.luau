-- Script in ServerScriptService. These fictional rows work in a local Studio playtest.
if not game:GetService("RunService"):IsStudio() then return end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roster = require(ReplicatedStorage:WaitForChild("Roster"))

local sampleScores = {
	{userId = 810000000001, score = 96, name = "Sample Juniper"},
	{userId = 810000000002, score = 82, name = "Sample Ember"},
	{userId = 810000000003, score = 75, name = "Sample Sol"},
	{userId = 810000000004, score = 68, name = "Sample Rowan"},
	{userId = 810000000005, score = 61, name = "Sample Iris"},
}

local service = Roster.Serve({
	Boards = {{
		Id = "Eggs", Label = "Eggs", ColumnLabel = "Eggs hatched",
		Friends = true, ShowProfiles = false, Limit = 3,
		Read = function()
			return sampleScores
		end,
		-- In this fixture every tester has the same two sample friends.
		-- A live provider should use the viewer's own scored connections and score.
		ReadFriends = function(_viewer)
			return {sampleScores[4], sampleScores[5]}
		end,
	}},
})

script.Destroying:Connect(function()
	service:Destroy()
end)
