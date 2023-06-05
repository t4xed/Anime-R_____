local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crypt = require(ReplicatedStorage.Cryptware.Crypt)

local Leaderboards = Crypt.Register({ Name = "Leaderboards" })

function Leaderboards:Init()
    self.Boards = {
        ["Essence"] = workspace.Leaderboards:FindFirstChild("Essence"),
        ["Power"] = workspace.Leaderboards:FindFirstChild("Power")
    }
    self.BoardStores = {}

	require(script.Funcs):Init(self)
end

function Leaderboards:Start()
	self.Data = Crypt.Import("Data")
	self.Profiles = self.Data:GetProfiles()

    for boardName, _ in self.Boards do
        self.BoardStores[boardName] = DataStoreService:GetOrderedDataStore(boardName)

        self:UpdateBoard(boardName)
        task.spawn(function()
            while task.wait(60) do
                self:UpdateBoard(boardName)
            end
        end)
    end
end

return Leaderboards