local Funcs = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local InfiniteMath = require(ReplicatedStorage.Cryptware.InfiniteMath)
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
	function Level:GetLevelData(player)
		return self.Profiles[player].LevelData
	end

	function Level:LevelUp(levelData, level)
		levelData.Level = level or levelData.Level + 1
		levelData.CurrentExp = 0
		levelData.MaxExp = 10 + (levelData.Level * 10)
	end

	function Level:SafeLevel(levelData)
		if levelData.Level >= self.MaxLevel then
			self:LevelUp(levelData, self.MaxLevel)
			return false
		end
		return true
	end

	function Level:ExpCap(levelData, amt)
		if levelData.CurrentExp + amt >= levelData.MaxExp then
			return true
		end
	end

	function Level:CheckExp(levelData, amt)
		local failed = false

		while task.wait() do
			if not self:SafeLevel(levelData) then
				failed = true
				break
			elseif self:ExpCap(levelData, amt) then
				amt = (levelData.CurrentExp + amt) - levelData.MaxExp
				self:LevelUp(levelData)
			else
				break
			end
		end

		if not failed or amt < levelData.MaxExp then
			levelData.CurrentExp += amt
		end
	end
	
	function Level:SetLevel(player, lvl)
		local profile = self.Profiles[player]
		local levelData = profile.Data.LevelData
		
		self:LevelUp(levelData, lvl)
		return levelData
	end
	
	function Level:AddExp(player, amt)
		local profile = self.Profiles[player]
		local levelData = profile.Data.LevelData
		local multis = profile.Data.Multipliers
		
		levelData.CurrentExp += amt * (multis.Exp > 0 and multis.Exp or 1)
		self:CheckExp(levelData, amt)

		return levelData
	end
	
	function Level:PlayerAdded(player)
		self.GetInfo:Fire(player)
	end
end

return Funcs