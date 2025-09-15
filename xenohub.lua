-- Xeno Hub with Orion-Style UI

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Sound Setup
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "XenoHubUI"
gui.ResetOnSpawn = false

local music = Instance.new("Sound", gui)
music.SoundId = "rbxassetid://422668266" -- The Viper by BabyChiefDoIt
music.Volume = 3
music:Play()
task.delay(30, function() music:Stop() end)

-- Load Orion Library from the provided link
local success, OrionLib = pcall(function()
    return loadstring(game:HttpGet("https://pastefy.app/N7SLEGxc/raw"))()
end)

if not success then
    -- Fallback basic UI if Orion fails to load
    local basicGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    basicGui.Name = "XenoHubBasicUI"
    
    local mainFrame = Instance.new("Frame", basicGui)
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25,25,35)
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,12)
    
    local title = Instance.new("TextLabel", mainFrame)
    title.Size = UDim2.new(1, 0, 0.2, 0)
    title.BackgroundTransparency = 1
    title.Text = "Xeno Hub (Basic UI)"
    title.TextColor3 = Color3.fromRGB(180,120,255)
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    
    local status = Instance.new("TextLabel", mainFrame)
    status.Size = UDim2.new(1, 0, 0.3, 0)
    status.Position = UDim2.new(0, 0, 0.3, 0)
    status.BackgroundTransparency = 1
    status.Text = "Orion failed to load but Xeno Hub is working!"
    status.TextColor3 = Color3.fromRGB(255,255,255)
    status.Font = Enum.Font.Gotham
    status.TextScaled = true
    
    return
end

-- Create the main Xeno Hub window
local Window = OrionLib:MakeWindow({
    Name = "Xeno Hub", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "XenoHubConfig",
    IntroEnabled = true,
    IntroText = "Welcome to Xeno Hub"
})

-- Welcome notification
OrionLib:MakeNotification({
    Name = "Xeno Hub Loaded!",
    Content = "Welcome to Xeno Hub with Orion UI",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- Main Tab
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddLabel("Xeno Hub Loaded Successfully! ✅")
MainTab:AddParagraph("Welcome", "Thank you for using Xeno Hub with Orion UI")

-- Example elements
MainTab:AddButton({
    Name = "Example Button",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "Example",
            Content = "This is an example notification!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end    
})

MainTab:AddToggle({
    Name = "Example Toggle",
    Default = false,
    Callback = function(Value)
        print("Toggle value:", Value)
    end    
})

MainTab:AddSlider({
    Name = "Example Slider",
    Min = 0,
    Max = 100,
    Default = 50,
    Color = Color3.fromRGB(180,120,255),
    Increment = 1,
    ValueName = "Value",
    Callback = function(Value)
        print("Slider value:", Value)
    end    
})

-- Settings Tab
local SettingsTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

SettingsTab:AddLabel("Settings Panel")
SettingsTab:AddTextbox({
    Name = "Example Textbox",
    Default = "",
    TextDisappear = true,
    Callback = function(Value)
        print("Textbox value:", Value)
    end	  
})

SettingsTab:AddColorpicker({
    Name = "Example Colorpicker",
    Default = Color3.fromRGB(180, 120, 255),
    Callback = function(Value)
        print("Colorpicker value:", Value)
    end	  
})

SettingsTab:AddBind({
    Name = "Example Bind",
    Default = Enum.KeyCode.E,
    Hold = false,
    Callback = function()
        print("Key pressed")
    end    
})

SettingsTab:AddDropdown({
    Name = "Example Dropdown",
    Default = "Option 1",
    Options = {"Option 1", "Option 2", "Option 3"},
    Callback = function(Value)
        print("Dropdown value:", Value)
    end    
})

-- Player Tab
local PlayerTab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

PlayerTab:AddLabel("Player Options")
PlayerTab:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 100,
    Default = 16,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "speed",
    Callback = function(Value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end    
})

PlayerTab:AddSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 200,
    Default = 50,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "power",
    Callback = function(Value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    end    
})

-- Teleport Tab
local TeleportTab = Window:MakeTab({
    Name = "Teleport",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

TeleportTab:AddLabel("Teleport Locations")
TeleportTab:AddButton({
    Name = "Spawn",
    Callback = function()
        LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(0, 5, 0))
    end    
})

-- Fun Tab
local FunTab = Window:MakeTab({
    Name = "Fun",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

FunTab:AddLabel("Fun Features")
FunTab:AddButton({
    Name = "Dance",
    Callback = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:LoadAnimation(Instance.new("Animation")):Play()
        end
    end    
})

-- Init Orion
OrionLib:Init()
