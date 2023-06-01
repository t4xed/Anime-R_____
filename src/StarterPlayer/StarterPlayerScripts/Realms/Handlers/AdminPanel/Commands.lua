local Commands = {}
local CommandUtils = require(script.Parent.CommandUtils)

function Commands.SetEssence(args)
    if not args[3] or not tonumber(args[3]) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, args[3])
    Commands.Util:Reset()
end

function Commands.AddEssence(args)
    if not args[3] or not tonumber(args[3]) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, args[3])
    Commands.Util:Reset()
end

function Commands.SetPotion(args)
    if not args[3] or not args[4] or not tonumber(args[4]) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, args[3], args[4])
    Commands.Util:Reset()
end

function Commands.GivePotion(args)
    if not args[3] or not args[4] or not tonumber(args[4]) then
        return
    end

    Commands.Admin.SendCommand:Fire(Commands.Settings.CommandName, Commands.Settings.Target, args[3], args[4])
    Commands.Util:Reset()
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
    Commands.Util:Reset()
end

CommandUtils:Init(Commands)
return Commands