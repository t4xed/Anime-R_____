local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

local Crypt = require(ReplicatedStorage.Cryptware.Crypt)

local ChatTags = Crypt.Register({ Name = "ChatTags" })
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

function ChatTags:Init()
	self.GroupId = 32441125
	self.GroupRanks = require(script.Ranks)
end

function ChatTags:Start()
	TextChatService.OnIncomingMessage = function(message: TextChatMessage)
		local properties = Instance.new("TextChatMessageProperties")
		
		if message.TextSource then
			local player = Players:GetPlayerByUserId(message.TextSource.UserId)
			local rank = Player:GetRoleInGroup(self.GroupId)
			local rankInfo = self.GroupRanks[rank]
			
			if rankInfo then
				local prefText = `<font color='{rankInfo.Color}'>[{rankInfo.Name}] </font>`
				local ignore = Color3.fromRGB()
				if player.UserId == 168170701 then
					local rankInfo2 = {
						Color = "#5500ff",
						Name = "Lead Programmer"
					}
					
					prefText = `{prefText}<font color='{rankInfo2.Color}'>[{rankInfo2.Name}] </font>`
				end
				
				properties.PrefixText = `{prefText}{message.PrefixText}`
			end
		end
		
		return properties
	end
end

return ChatTags