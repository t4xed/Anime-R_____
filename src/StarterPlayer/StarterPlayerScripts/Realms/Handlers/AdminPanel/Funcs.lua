local UserInputService = game:GetService("UserInputService")

local Funcs = {}
local UIFuncs = {}
UIFuncs.Connections = {}

local Commands = require(script.Parent.Commands)

function UIFuncs:HandleQuickCommand()
    local cmdBox: TextBox = self.AdminPanel.Container.Main.QuickCommand.Input
    local foundLabel: TextLabel = self.AdminPanel.Container.Main.QuickCommand.Found

    local foundCmd = nil

    local foundTarget = nil
    local filledTarget = false
    local setting = false

    self.Connections.Tab = UserInputService.InputBegan:Connect(function(input, GPE)
        if not GPE then
            return
        end

        if input.KeyCode == Enum.KeyCode.Tab then
            if foundTarget and not filledTarget then
                filledTarget = true
                setting = true
                cmdBox.Text = foundLabel.Text
                task.wait(.2)
                cmdBox.Text = foundLabel.Text
                setting = false
            end
        end
    end)

    cmdBox:GetPropertyChangedSignal("Text"):Connect(function()
        pcall(function()
            if #cmdBox.Text > 0 then
                cmdBox.TextXAlignment = Enum.TextXAlignment.Left
            else
                foundLabel.Text = ""
    
                foundCmd = nil
                foundTarget = nil
                filledTarget = false
    
                cmdBox.TextXAlignment = Enum.TextXAlignment.Center
                return
            end
    
            if setting then
                return
            end
    
            if cmdBox.Text:match("%u") then
                setting = true
                cmdBox.Text = cmdBox.Text:lower()
                setting = false
            end
    
            local str = cmdBox.Text:gsub("/", "")
            local args = str:split(" ")
            
            if not args[1] then
                return
            end
    
            if args[2] and not args[2]:match("%a") or args[2] and not Commands.Util:IsCommand(args[1]) then
                foundCmd = nil
                Commands.Util:FindCommand(" ")
                foundLabel.Text = ""
                return
            end
    
            local cmd = Commands.Util:FindCommand(args[1])
    
            if cmd then
                foundCmd = cmd
                foundLabel.Text = `{cmd.Name:lower()} `
            else
                foundCmd = nil
                Commands.Util:FindCommand(" ")
                foundLabel.Text = ""
            end
    
            if not args[2] or args[3] and not Commands.Util:IsPlayer(args[2]) then
                foundTarget = nil
                Commands.Util:FindTarget(" ")
                foundLabel.Text = `{foundCmd.Name:lower()} `
                return
            end
    
            local target, isDisplay = Commands.Util:FindTarget(args[2])
        
            if target then
                foundTarget = target
                foundLabel.Text = `{foundCmd.Name:lower()} {isDisplay and target.DisplayName or target.Name}`
            else
                foundTarget = nil
                Commands.Util:FindTarget(" ")
                foundLabel.Text = `{foundCmd.Name:lower()} `
            end
    
            if foundCmd and foundTarget and args[3] then
                foundLabel.Text = ""
            end
        end)
    end)

    cmdBox.FocusLost:Connect(function(enterPressed)
        if not enterPressed then
            return
        end

        local str = cmdBox.Text:gsub("/", "")
        local args = str:split(" ")
        Commands.Util:RunCommand(args)

        foundCmd = nil
        foundTarget = nil
        filledTarget = false

        cmdBox.Text = ""
        foundLabel.Text = ""
    end)
end

function Funcs:Init(AdminPanel)
    AdminPanel.UI = UIFuncs
    AdminPanel.UI.AdminPanel = AdminPanel.Panel
    Commands.Admin = AdminPanel.Admin
end

return Funcs