local Commands = {}
local CommandUtils = require(script.Parent.CommandUtils)

Commands.IgnoreTarget = { "Ban", "Unban", "Shutdown" }

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

function Commands.Shutdown(args)
    local shouldForAll = args[3]

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, shouldForAll)
end

CommandUtils:Init(Commands)
return Commands