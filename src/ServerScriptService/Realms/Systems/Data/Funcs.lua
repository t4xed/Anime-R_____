local Funcs = {}

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

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

local function updateGlobal(player, key, val)
	local succ, err = pcall(function()
		DataStoreService:GetOrderedDataStore(key):UpdateAsync(player.UserId, function()
			return math.log10(val+1)*(2^63)/308.254
		end)
	end)

	if not succ then
		warn(err)
	end
end

function Funcs:Init(Data)
	function Data:Set(player, key, value, ...)
		local toSet = deepSearch(self.Profiles[player].Data, ...)
		
		if toSet and toSet[key] then
			toSet[key] = value
			updateGlobal(player, key, toSet[key])
			self.Leaderstats:Update(player, key, toSet[key])
		end
	end

	function Data:Add(player, key, value, ...)
		local toSet = deepSearch(self.Profiles[player].Data, ...)
		
		if toSet and toSet[key] then
			toSet[key] += value
			updateGlobal(player, key, toSet[key])
			self.Leaderstats:Update(player, key, toSet[key])
		end
	end

	function Data:Sub(player, key, value, ...)
		local toSet = deepSearch(self.Profiles[player].Data, ...)
		
		if toSet and toSet[key] then
			toSet[key] -= value
			updateGlobal(player, key, toSet[key])
			self.Leaderstats:Update(player, key, toSet[key])
		end
	end

	function Data:Mul(player, key, value, ...)
		local toSet = deepSearch(self.Profiles[player].Data, ...)
		
		if toSet and toSet[key] then
			toSet[key] *= value
			updateGlobal(player, key, toSet[key])
			self.Leaderstats:Update(player, key, toSet[key])
		end
	end

	function Data:Div(player, key, value, ...)
		local toSet = deepSearch(self.Profiles[player].Data, ...)
		
		if toSet and toSet[key] then
			toSet[key] /= value
			updateGlobal(player, key, toSet[key])
			self.Leaderstats:Update(player, key, toSet[key])
		end
	end

	function Data:GetMyProfile(player)
		return self:decyclic(self.Profiles[player], {self.Profiles[player]})
	end
	
	function Data:GetProfile(player)
		return self.Profiles[player]
	end

	function Data:GetProfiles()
		return self.Profiles
	end

	function Data:HandleLockedUpdate(profile, update_id, update_data)
		if update_data.Type == "UpdatePlace" then
			profile.Data.Leaderboards[update_data.Item].Place = update_data.Value
		end

		profile.GlobalUpdates:ClearLockedUpdate(update_id)
	end
	
	function Data:PlayerAdded(player)
		local profile
		if self.UseMock and RunService:IsStudio() then
			profile = self.ProfileStore.Mock:LoadProfileAsync("Player_" .. player.UserId)
		else
			profile = self.ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
		end
		if profile ~= nil then
			if profile.Data.Ban.Active then
				profile.Data.Ban.Active = not profile.Data.Ban.Active
				profile:Release()
				player:Kick("You have been permanently banned.")
			else
				profile:Reconcile()
				profile:ListenToRelease(function()
					self.Profiles[player] = nil
					player:Kick(self.KickMessage)
				end)

				if player:IsDescendantOf(Players) == true then
					self.Profiles[player] = profile

					for _, update in profile.GlobalUpdates:GetActiveUpdates() do
						profile.GlobalUpdates:LockActiveUpdate(update[1])
					end

					for _, update in profile.GlobalUpdates:GetLockedUpdates() do
						self:HandleLockedUpdate(profile, update[1], update[2])
					end

					profile.GlobalUpdates:ListenToNewActiveUpdate(function(update_id, _)
						profile.GlobalUpdates:LockActiveUpdate(update_id)
					end)

					profile.GlobalUpdates:ListenToNewLockedUpdate(function(update_id, update_data)
						self:HandleLockedUpdate(profile, update_id, update_data)
					end)
				else
					profile:Release()
				end
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