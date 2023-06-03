local Commands = {}
local CommandUtils = require(script.Parent.CommandUtils)
local Players = game:GetService("Players")
local Gamepasses = require(game:GetService("ReplicatedStorage").Shared.Gamepasses)

local CurrentPlayers
task.spawn(function()
    CurrentPlayers = Players:GetPlayers()

    Players.PlayerAdded:Connect(function(player)
        table.insert(CurrentPlayers, player)
    end)

    Players.PlayerRemoving:Connect(function(player)
        local index = table.find(CurrentPlayers, player)
        table.remove(CurrentPlayers, index)
    end)
end)

Commands.CommandArgs = {
    SetLevel = {
        CurrentPlayers
    },

    AddLevel = {
        CurrentPlayers
    },

    AddExp = {
        CurrentPlayers
    },

    SetLuck = {
        CurrentPlayers
    },

    AddLuck = {
        CurrentPlayers
    },

    SetPower = {
        CurrentPlayers
    },

    AddPower = {
        CurrentPlayers
    },

    SetEssence = {
        CurrentPlayers
    },

    AddEssence = {
        CurrentPlayers
    },

    SetPotion = {
        CurrentPlayers,
        { "Essence", "Power", "Exp", "Luck" }
    },

    GivePotion = {
        CurrentPlayers,
        { "Essence", "Power", "Exp", "Luck" }
    },

    Unban = {
        CurrentPlayers
    },

    Ban = {
        CurrentPlayers
    },

    Kick = {
        CurrentPlayers
    },

    GiveGamepass = {
        CurrentPlayers,
        Gamepasses:GetPassNames()
    },
}

function Commands.SetLevel(args)
    if not Commands.Settings.Target then
        return
    end

    if not args[3] or not tonumber(args[3]) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, args[3])
end

function Commands.AddLevel(args)
    if not Commands.Settings.Target then
        return
    end

    if not args[3] or not tonumber(args[3]) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, args[3])
end

function Commands.AddExp(args)
    if not Commands.Settings.Target then
        return
    end
    
    if not args[3] or not tonumber(args[3]) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, args[3])
end

function Commands.SetLuck(args)
    if not Commands.Settings.Target then
        return
    end
    
    if not args[3] or not tonumber(args[3]) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, args[3])
end

function Commands.AddLuck(args)
    if not Commands.Settings.Target then
        return
    end
    
    if not args[3] or not tonumber(args[3]) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, args[3])
end

function Commands.SetPower(args)
    if not Commands.Settings.Target then
        return
    end
    
    if not args[3] or not tonumber(args[3]) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, args[3])
end

function Commands.AddPower(args)
    if not Commands.Settings.Target then
        return
    end
    
    if not args[3] or not tonumber(args[3]) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, args[3])
end

function Commands.SetEssence(args)
    if not Commands.Settings.Target then
        return
    end
    
    if not args[3] or not tonumber(args[3]) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, args[3])
end

function Commands.AddEssence(args)
    if not Commands.Settings.Target then
        return
    end
    
    if not args[3] or not tonumber(args[3]) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, args[3])
end

function Commands.SetPotion(args)
    if not Commands.Settings.Target then
        return
    end
    
    if not args[3] or not args[4] or not tonumber(args[4]) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, args[3], args[4])
end

function Commands.GivePotion(args)
    if not Commands.Settings.Target then
        return
    end
    
    if not args[3] or not args[4] or not tonumber(args[4]) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, args[3], args[4])
end

function Commands.Unban(args)
    local id = args[2]

    if not id or not tonumber(id) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, id)
end

function Commands.Ban(args)
    local id = args[2]

    if not id or not tonumber(id) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, id)
end

function Commands.Kick(args)
    local reason
    for i = 3, #args do
        if args[i] then
            if not reason then
                reason = ""
            end
            reason = `{reason} {args[i]}`
        end
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, reason)
end

function Commands.GlobalShutdown()
    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName)
end

function Commands.Shutdown()
    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName)
end

function Commands.GlobalMessage(args)
    local message
    for i = 2, #args do
        if args[i] then
            if not message then
                message = ""
            end
            message = `{message} {args[i]}`
        end
    end

    if not message or #message == 0 then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, message)
end

function Commands.ServerMessage(args)
    local message
    for i = 2, #args do
        if args[i] then
            if not message then
                message = ""
            end
            message = `{message} {args[i]}`
        end
    end

    if not message or #message == 0 then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, message)
end

function Commands.GiveGamepass(args)
    local gamepass = Gamepasses:FixPassName(args[3])

    if not Commands.Settings.Target or not gamepass or #gamepass == 0 then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, Commands.Settings.UseDisplay, gamepass)
end

CommandUtils:Init(Commands)
return Commands