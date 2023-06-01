local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crypt = require(ReplicatedStorage.Cryptware.Crypt)

local AdminPanel = Crypt.Register({ Name = "AdminPanel" })
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local function dragify(Frame)
    local dragToggle, dragStart, dragInput, startPos, Delta, Position
    
    local function updateInput(input)
        Delta = input.Position - dragStart
        Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
        game:GetService("TweenService"):Create(Frame, TweenInfo.new(.25), {Position = Position}):Play()
    end
    
    Frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragToggle = true
            dragStart = input.Position
            startPos = Frame.Position
            input.Changed:Connect(function()
                if (input.UserInputState == Enum.UserInputState.End) then
                    dragToggle = false
                end
            end)
        end
    end)
    
    Frame.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if (input == dragInput and dragToggle) then
            updateInput(input)
        end
    end)
end

function AdminPanel:Init()
    self.Administrators = {
        ["168170701"] = { Rank = "Lead Programmer" },
        ["1276064805"] = { Rank = "Developer" },
        ["2733923205"] = { Rank = "Owner" },
        ["428007781"] = { Rank = "Owner" },
        ["109051248"] = { Rank = "Owner" },
        ["3439007392"] = { Rank = "Owner" },
        ["115247828"] = { Rank = "Owner" },
    }
end

function AdminPanel:Start()
    self.Admin = Crypt.Import("Admin")
    local succ = self.Admin:CheckAdmin()

    if self.Administrators[tostring(Player.UserId)] and succ then
        local panel = PlayerGui:WaitForChild("Admin", 10)
        self.Panel = panel

        require(script.Funcs):Init(self)
        self:Begin(self.Administrators[tostring(Player.UserId)])
    else
        script.Funcs:Destroy()
        self.Administrators = nil
        self.Begin = nil
    end
end

function AdminPanel:Begin(adminData)
    local adminRank = adminData.Rank
    local content, isReady = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    
    local AdminContainer = self.Panel.Container
    local TopBar = AdminContainer.TopBar
    local Main = AdminContainer.Main

    dragify(AdminContainer)
    TopBar.Avatar.Image = (isReady and content) or "rbxassetid://0"
    TopBar.Info.Text = `{Player.DisplayName} | {adminRank}`

    self.UI:HandleQuickCommand()
end

return AdminPanel