local Utils = {}

local Players = game:GetService("Players")

function Utils.FindPlayer(shortName)
    for _, plr in Players:GetPlayers() do
        if plr.Name:lower():match(shortName:lower())
        or plr.DisplayName:lower():match(shortName:lower())
        then
            return plr
        end
    end
end

return Utils