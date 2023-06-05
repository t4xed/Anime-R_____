local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

local Crypt = require(ReplicatedStorage.Cryptware.Crypt)

local ChatTags = Crypt.Register({ Name = "ChatTags" })
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

function ChatTags:Init()
	self.Data = Crypt.Import("Data")
	self.GroupId = 32441125
	self.GroupRanks = require(script.Ranks)

	self.Administrators = {
        ["168170701"] = "encrxpt3d",
        ["1276064805"] = "PaidosDev",
        ["2733923205"] = "idk91",
        ["428007781"] = "math731",
        ["109051248"] = "Lelep",
        ["3439007392"] = "LeozimGamers",
        ["115247828"] = "PaidosGame",
    }
end

function ChatTags:Start()
	TextChatService.OnIncomingMessage = function(message: TextChatMessage)
		if message.Status == Enum.TextChatMessageStatus.Sending then
			return self:HandleMessage(message)
		elseif message.Status == Enum.TextChatMessageStatus.Success
		and message.Text:sub(1, 1) == "/"
		and self.Administrators[tostring(message.TextSource.UserId)] then
			local properties = Instance.new("TextChatMessageProperties")
			properties.PrefixText = "ㅤ"
			properties.Text = "ㅤ"

			return properties
		else
			return self:HandleMessage(message)
		end
	end
end

function ChatTags:HandleMessage(message: TextChatMessage)
	local properties = Instance.new("TextChatMessageProperties")
		
	if message.TextSource then
		local player = Players:GetPlayerByUserId(message.TextSource.UserId)
		local rank = Player:GetRoleInGroup(self.GroupId)
		local rankInfo = self.GroupRanks[rank]
		local profile = self.Data:GetMyProfile()
		
		if rankInfo then
			local prefText = `<font color='{rankInfo.Color}'>[{rankInfo.Name}] </font>`
			
			if player.UserId == 168170701 then
				local rankInfo2 = {
					Color = "#5500ff",
					Name = "Lead Programmer"
				}
				
				prefText = `{prefText}<font color='{rankInfo2.Color}'>[{rankInfo2.Name}] </font>`
			end
			
			properties.PrefixText = prefText
		end

		for _, lbData in profile.Data.Leaderboards do
			if lbData.Place > 0 then
				properties.PrefixText = `{properties.PrefixText}<font color='{lbData.Color}'>[#{lbData.Place} {lbData.Emoji}] </font>`
			end
		end
	end

	properties.PrefixText = `{properties.PrefixText}{message.PrefixText}`

	return properties
end

return ChatTags