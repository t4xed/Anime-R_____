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

function Funcs:Init(Level)
	function Level:CheckExp(levelData, amt)
		while levelData.CurrentExp + amt >= levelData.MaxExp and task.wait() do
			local newAmt = (levelData.CurrentExp + amt) - levelData.MaxExp
			
			levelData.Level += 1
			levelData.CurrentExp = 0
			levelData.MaxExp += 10
			amt = newAmt
		end
		
		levelData.CurrentExp += amt
	end
	
	function Level:SetLevel(player, lvl)
		local profile = self.Profiles[player]
		local levelData = profile.Data.LevelData
		
		levelData.Level = lvl
		levelData.CurrentExp = 0
		levelData.MaxExp = 110 + (lvl * 10) 
	end
	
	function Level:AddExp(player, amt)
		local profile = self.Profiles[player]
		local levelData = profile.Data.LevelData
		
		levelData.CurrentExp += amt * levelData.ExpMulti
		self:CheckExp(levelData, amt)
	end
	
	function Level:PlayerAdded(player)
		self.GetInfo:Fire(player)
	end
end

return Funcs