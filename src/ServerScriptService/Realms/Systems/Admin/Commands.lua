local Funcs = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local InfiniteMath = require(ReplicatedStorage.Cryptware.InfiniteMath)
local Utils = require(script.Parent.Utils)

local Commands = {}
Commands.Chat = {}

function Commands.SetLevel(_, ...)
    local target, amt = ...
    Commands.AddLevel(_, target, amt, "Set")
end

function Commands.AddLevel(_, ...)
    local target, amt, setType = ...

    if setType then
        Commands.Level:SetLevel(target, amt)
    else
        local profile = Commands.Data.Profiles[target]
        local lvl = profile.Data.LevelData.Level

        Commands.Level:SetLevel(target, amt + lvl)
    end
end

function Commands.AddExp(_, ...)
    local target, amt = ...

    Commands.Level:AddExp(target, amt)
end

function Commands.SetLuck(_, ...)
    local target, amt = ...
    Commands.AddLuck(_, target, amt, "Set")
end

function Commands.AddLuck(_, ...)
    local target, amt, setType = ...

    if setType then
        Commands.Data[setType](Commands.Data, target, "Luck", InfiniteMath.new(tonumber(amt)), "PlayerData")
    else
        Commands.Data:Add(target, "Luck", InfiniteMath.new(tonumber(amt)), "PlayerData")
    end
end

function Commands.SetPower(_, ...)
    local target, amt = ...
    Commands.AddPower(_, target, amt, "Set")
end

function Commands.AddPower(_, ...)
    local target, amt, setType = ...

    if setType then
        Commands.Data[setType](Commands.Data, target, "Power", InfiniteMath.new(tonumber(amt)), "PlayerData")
    else
        Commands.Data:Add(target, "Power", InfiniteMath.new(tonumber(amt)), "PlayerData")
    end
end

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

function Commands.Unban(_, id)
    local profile = Commands.Data.ProfileStore:LoadProfileAsync(`Player_{id}`, "ForceLoad")
    
    if profile ~= nil then
        if not profile.Data.Ban.Active then
            return
        else
            profile.Data.Ban.Active = false
        end
    end
end

function Commands.Ban(_, id)
    local profile
    local plr = Players:GetPlayerByUserId(id)

    if plr then
        profile = Commands.Data.Profiles[plr]
    else
        profile = Commands.Data.ProfileStore:LoadProfileAsync(`Player_{id}`, "ForceLoad")
    end
    
    if profile ~= nil then
        if profile.Data.Ban.Active then
            return
        else
            profile.Data.Ban.Active = true
        end

        profile:Release()
    end
end

function Commands.Kick(_, ...)
    local target, reason = ...

    target:Kick(reason or nil)
end

function Commands.Shutdown(_, shouldForAll)
    if not shouldForAll or shouldForAll ~= "all" then
        Commands.Data.KickMessage = "The server has shutdown, please rejoin."
        for _, profile in Commands.Data.Profiles do
            profile:Release()
        end
    end
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
    Commands.Level = Admin.Level

    Admin.Commands = Commands
end

return Funcs