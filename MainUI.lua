-- Axon Hub - UI Script for 99 Nights in the Forest

local plr = game.Players.LocalPlayer

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "AxonHubUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 380)
frame.Position = UDim2.new(0.5, -150, 0.5, -190)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.Text = "Axon Hub - 99 Nights"
title.TextColor3 = Color3.fromRGB(0, 255, 127)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local padding = Instance.new("UIPadding", frame)
padding.PaddingTop = UDim.new(0, 8)
padding.PaddingLeft = UDim.new(0, 10)
padding.PaddingRight = UDim.new(0, 10)

-- Utility function
local function createButton(name, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.MouseButton1Click:Connect(callback)
end

-- Scripts
createButton("ESP", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/RandomAdamYT/Roblox/main/ESP.lua"))()
end)

createButton("Infinite Jump", function()
    local UIS = game:GetService("UserInputService")
    local jumping = true
    UIS.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Space and jumping then
            plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)
end)

createButton("Speed Boost", function()
    local h = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed = 50 end
end)

createButton("Noclip", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MaGiXxScripter0/Noclip/main/Noclip.lua"))()
end)

createButton("Skip Night", function()
    local remote = game:GetService("ReplicatedStorage").Events.RemoteEvent
    remote:FireServer("SkipNight")
end)

createButton("Destroy GUI", function()
    gui:Destroy()
end)
