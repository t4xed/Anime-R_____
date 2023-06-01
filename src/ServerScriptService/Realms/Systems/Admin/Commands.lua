local Funcs = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local InfiniteMath = require(ReplicatedStorage.Cryptware.InfiniteMath)
local Utils = require(script.Parent.Utils)

local Commands = {}
Commands.Chat = {}

function Commands.SetEssence(_, ...)
    local target, amt = ...
    Commands.AddEssence(_, target, amt, "Set")
end

function Commands.AddEssence(_, ...)
    local target, amt, setType = ...

    if setType then
        Commands.Data[setType](Commands.Data, target, "Essence", InfiniteMath.new(tonumber(amt)), "PlayerData")
    else
        Commands.Data:Add(target, "Essence", InfiniteMath.new(tonumber(amt)), "PlayerData")
    end
end

function Commands.SetPotion(_, ...)
    local target, item, amt = ...
    Commands.GivePotion(_, target, item, amt, "Set")
end

function Commands.GivePotion(_, ...)
    local target, item, amt, setType = ...
    item = item:sub(1, 1):upper() .. item:sub(2, #item):lower()

    Commands.Potions:HandleUse(target, {
        Item = item,
        Quantity = amt
    }, true, setType)
end

function Commands.Kick(_, ...)
    local target, reason = ...

    target:Kick(reason or nil)
end

function Commands.Chat.Panel(player)
    local panel = player.PlayerGui:WaitForChild("Admin", 10)
    
    if panel then
        panel.Enabled = not panel.Enabled
    end
end

function Funcs:Init(Admin)
    Commands.Potions = Admin.Potions
    Commands.Data = Admin.Data

    Admin.Commands = Commands
end

return Funcs