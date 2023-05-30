local Funcs = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BigNum = require(ReplicatedStorage.Cryptware.BigNum)

local function deepSearch(tbl, ...)
	local keys = {...}
	local subTbl = tbl

	for _, key in ipairs(keys) do
		if type(subTbl) ~= "table" then
			return nil
		end

		subTbl = subTbl[key]
	end

	return subTbl
end

function Funcs:Init(Data)
	function Data:Set(player, key, value, ...)
		local toSet = deepSearch(self.Profiles[player].Data, ...)
		
		if toSet and toSet[key] then
			toSet[key] = value
			self.Leaderstats:Update(player, key, toSet[key])
		end
	end

	function Data:Add(player, key, value, ...)
		local toSet = deepSearch(self.Profiles[player].Data, ...)
		
		if toSet and toSet[key] then
			toSet[key] += value
			self.Leaderstats:Update(player, key, toSet[key])
		end
	end

	function Data:Sub(player, key, value, ...)
		local toSet = deepSearch(self.Profiles[player].Data, ...)
		
		if toSet and toSet[key] then
			toSet[key] -= value
			self.Leaderstats:Update(player, key, toSet[key])
		end
	end

	function Data:Mul(player, key, value, ...)
		local toSet = deepSearch(self.Profiles[player].Data, ...)
		
		if toSet and toSet[key] then
			toSet[key] *= value
			self.Leaderstats:Update(player, key, toSet[key])
		end
	end

	function Data:Div(player, key, value, ...)
		local toSet = deepSearch(self.Profiles[player].Data, ...)
		
		if toSet and toSet[key] then
			toSet[key] /= value
			self.Leaderstats:Update(player, key, toSet[key])
		end
	end
	
	function Data:GetProfile(player)
		return self.Profiles[player]
	end

	function Data:GetProfiles()
		return self.Profiles
	end
	
	function Data:PlayerAdded(player)
		local profile
		if self.UseMock and RunService:IsStudio() then
			profile = self.ProfileStore.Mock:LoadProfileAsync("Player_" .. player.UserId)
		else
			profile = self.ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
		end
		if profile ~= nil then
			profile:AddUserId(player.UserId)
			profile:Reconcile()
			profile:ListenToRelease(function()
				self.Profiles[player] = nil
				player:Kick()
			end)
			if player:IsDescendantOf(Players) == true then
				self.Profiles[player] = profile
			else
				profile:Release()
			end
		else
			player:Kick() 
		end
	end

	function Data:decyclic(t, p)
		local t1 = {}
		for k in pairs(t) do
			if table.find(p, t[k]) then 
				continue 
			end
			if typeof(t[k]) ~= "table" then
				t1[k] = t[k]
			else
				table.insert(p, t[k])
				t1[k] = t[k]
				local nonCyc = self:decyclic(t[k], p)
				for k1 in pairs(t1[k]) do
					if not nonCyc[k1] then
						t1[k][k1] = nil
					end
				end
			end
		end
		return t1
	end
end

return Funcs