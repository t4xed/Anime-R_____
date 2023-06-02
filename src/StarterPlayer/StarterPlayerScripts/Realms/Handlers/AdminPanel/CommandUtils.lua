local Players = game:GetService("Players")
local Utils = require(script.Parent.Utils)
local CommandUtils = {}

local blacklisted = {
    "Admin",
}

function CommandUtils:Init(Commands)
    Commands.Util = {}
    Commands.Settings = {}

    Commands.Settings.Command = nil
    Commands.Settings.CommandName = nil
    Commands.Settings.Target = nil

    function Commands.Util:IsPlayer(plr)
        for _, player in Players:GetPlayers() do
            if player.Name:lower() == plr:lower() then
                return true
            elseif player.DisplayName:lower() == plr:lower() then
                return true
            end
        end
        return false
    end

    function Commands.Util:IsCommand(cmd)
        for cmdName, cmdFunc in Commands do
            if type(cmdName) == "string" and cmdName:lower() == cmd:lower() and type(cmdFunc) == "function" and not table.find(blacklisted, cmd) then
                return true
            end
        end
        return false
    end

    function Commands.Util:FindCommand(cmd)
        for cmdName, cmdFunc in Commands do
            if type(cmdName) == "string" and cmdName:lower():sub(1, #cmd) == cmd:lower() and type(cmdFunc) == "function" and not table.find(blacklisted, cmdName) then
                Commands.Settings.Command = cmdFunc
                Commands.Settings.CommandName = cmdName
                return { Name = cmdName }
            end
        end
    
        Commands.Settings.Command = nil
        Commands.Settings.CommandName = nil
    end
    
    function Commands.Util:FindTarget(targetToFind)
        local foundTarget, isDisplay = Utils.FindPlayer(targetToFind)
    
        if foundTarget then
            Commands.Settings.Target = foundTarget
            return foundTarget, isDisplay
        else
            Commands.Settings.Target = nil
        end
    end
    
    function Commands.Util:RunCommand(passedArgs)
        if type(Commands.Settings.Command) == "function" and self:IsCommand(Commands.Settings.CommandName) then
            Commands.Settings.Command(passedArgs)
            self:Reset()
        end
    end
    
    function Commands.Util:Reset()
        Commands.Settings.Command = nil
        Commands.Settings.CommandName = nil
        Commands.Settings.Target = nil
    end
end

return CommandUtils