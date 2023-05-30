local Funcs = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Assets = ReplicatedStorage.Assets
local InfiniteMath = require(ReplicatedStorage.Cryptware.InfiniteMath)

local function clone(tbl)
	local newTbl = {}
	for index, value in tbl do
		if type(value) == "table" then
			newTbl[index] = clone(value)
		else
			newTbl[index] = value
		end
	end
	return newTbl
end

function Funcs:Init(Leaderstats)
	function Leaderstats:Update(player, leaderstat, value)
		local ldsObj = player.leaderstats:WaitForChild(leaderstat, 5)
		
		if ldsObj then
			ldsObj.Value = value:GetSuffix()
		end
	end
	
	function Leaderstats:PlayerAdded(player)
		local profile = self.Profiles[player]
		
		local leaderstats = Instance.new("Folder")
		leaderstats.Name = "leaderstats"
		leaderstats.Parent = player
		
		for _, lds in profile.Data.Leaderstats do
			local ldsValue = Instance.new("StringValue")
			local ldsData = InfiniteMath.new(profile.Data.PlayerData[lds])

			ldsValue.Name = lds
			ldsValue.Value = ldsData:GetSuffix()
			ldsValue.Parent = leaderstats
		end
	end
end

return Funcs