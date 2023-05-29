local Funcs = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Assets = ReplicatedStorage.Assets

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
		local ldsObj = player.leaderstats:FindFirstChild(leaderstat)
		
		if ldsObj then
			ldsObj.Value = self.Util.Abbreviate:Abbreviate(value)
		end
	end
	
	function Leaderstats:PlayerAdded(player)
		local profile = self.Profiles[player]
		
		local leaderstats = Instance.new("Folder")
		leaderstats.Name = "leaderstats"
		leaderstats.Parent = player
		
		for _, ldsData in profile.Data.Leaderstats do
			local ldsValue = Instance.new(ldsData.Type)
			ldsValue.Name = ldsData.Name
			ldsValue.Value =  self.Util.Abbreviate:Abbreviate(profile.Data.PlayerData[ldsData.Name])
			ldsValue.Parent = leaderstats
		end
	end
end

return Funcs