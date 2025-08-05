-- Axon Hub – Blox Fruits Version by qwrt4mk
-- Fully Featured Script Hub using Venyx UI

-- Load Venyx UI
local Venyx = loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/Venyx-UI-Library/main/Library.lua"))()
local venyx = Venyx.new("Axon Hub – Blox Fruits", 5013109572)

local theme = {
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(0, 170, 255),
    Accent = Color3.fromRGB(0, 170, 255),
    LightContrast = Color3.fromRGB(30, 30, 30),
    DarkContrast = Color3.fromRGB(18, 18, 18),
    TextColor = Color3.fromRGB(255, 255, 255)
}

-- Pages
local farming = venyx:addPage("Auto Farm", 5012544693)
local combat = venyx:addPage("Combat", 5012544693)
local player = venyx:addPage("Player", 5012544693)
local visuals = venyx:addPage("Visuals", 5012544693)
local misc = venyx:addPage("Misc", 5012544693)

-- Farming Section
local farmSection = farming:addSection("Auto Farming")
farmSection:addToggle("Auto Farm NPCs", false, function(state)
    _G.autoFarm = state
    spawn(function()
        while _G.autoFarm do
            wait()
            local enemy = workspace.Enemies:FindFirstChildWhichIsA("Model")
            if enemy and enemy:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
            end
        end
    end)
end)

farmSection:addButton("Auto Collect Drops", function()
    for _, drop in pairs(workspace:GetChildren()) do
        if drop:IsA("Tool") then
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, drop.Handle, 0)
        end
    end
end)

-- Combat Section
local combatSection = combat:addSection("Combat Tools")
combatSection:addToggle("Auto Kill Players (Nearby)", false, function(state)
    _G.autoKill = state
    spawn(function()
        while _G.autoKill do
            wait()
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (plr.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 20 then
                        game:GetService("ReplicatedStorage").Remotes.Combat:FireServer(plr.Character.HumanoidRootPart)
                    end
                end
            end
        end
    end)
end)

combatSection:addToggle("Auto Haki", true, function(state)
    if state then
        while true do
            wait(1)
            local char = game.Players.LocalPlayer.Character
            if not char:FindFirstChild("HasBuso") then
                game:GetService("ReplicatedStorage").Remotes.ToggleBuso:FireServer()
            end
        end
    end
end)

-- Player Section
local playerSection = player:addSection("Local Player")
playerSection:addSlider("WalkSpeed", 16, 16, 200, function(v)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

playerSection:addSlider("JumpPower", 50, 50, 200, function(v)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)

playerSection:addToggle("Infinite Jump", false, function(state)
    _G.infJump = state
    local UIS = game:GetService("UserInputService")
    if state then
        UIS.JumpRequest:Connect(function()
            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState("Jumping")
        end)
    end
end)

playerSection:addToggle("No Clip", false, function(state)
    _G.noclip = state
    local RunService = game:GetService("RunService")
    RunService.Stepped:Connect(function()
        if _G.noclip then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)
end)

-- Visuals Section
local visualSection = visuals:addSection("ESP")
visualSection:addButton("Enable Player ESP", function()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= game.Players.LocalPlayer and plr.Character:FindFirstChild("Head") then
            local bb = Instance.new("BillboardGui", plr.Character.Head)
            bb.Size = UDim2.new(0, 100, 0, 40)
            bb.AlwaysOnTop = true
            local nameTag = Instance.new("TextLabel", bb)
            nameTag.Text = plr.Name
            nameTag.BackgroundTransparency = 1
            nameTag.TextColor3 = Color3.new(1, 0, 0)
            nameTag.TextScaled = true
        end
    end
end)

-- Misc Section
local miscSection = misc:addSection("Utility & GUI")
miscSection:addButton("Anti-AFK", function()
    for _, v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
        v:Disable()
    end
end)

miscSection:addButton("Destroy GUI", function()
    venyx:Notify("Axon Hub", "Unloaded!")
    game.CoreGui:FindFirstChild("Axon Hub – Blox Fruits"):Destroy()
end)

-- Set Theme
venyx:setTheme("Glow", theme.Glow)
venyx:setTheme("Accent", theme.Accent)
