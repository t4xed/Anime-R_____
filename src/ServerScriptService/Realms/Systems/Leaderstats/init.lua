local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crypt = require(ReplicatedStorage.Cryptware.Crypt)

local Leaderstats = Crypt.Register({ Name = "Leaderstats" }).Expose({
	RE = {},
	RF = { "Update" }
})

function Leaderstats:Init()
	require(script.Funcs):Init(self)
end

function Leaderstats:Start()
	self.Data = Crypt.Import("Data")
	self.Profiles = self.Data:GetProfiles()
end

function Leaderstats:PlayerRemoving(player)
	
end

return Leaderstats