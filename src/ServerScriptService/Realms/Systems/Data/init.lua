local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crypt = require(ReplicatedStorage.Cryptware.Crypt)

local Data = Crypt.Register({ Name = "Data" })

function Data:Init()
	self.Leaderstats = Crypt.Import("Leaderstats")
	
	local key = self.Util.KeyHandler:GetKey()
	local ProfileService = self.Util.ProfileService
	local DefaultData = self.Util.DefaultData

	self.ProfileStore = ProfileService.GetProfileStore(key, DefaultData)
	self.Profiles = {}
	self.UseMock = true

	require(script.Funcs):Init(self)
end

return Data