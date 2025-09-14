-- Xeno Hub Key System with Orion-Style UI
-- Key: xenhub123

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local correctKey = "xenohub123"
local maxAttempts, attempts = 5, 0

-- ScreenGui
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "XenoKeyGui"
gui.ResetOnSpawn = false

-- Main Frame
local main = Instance.new("Frame", gui)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.Position = UDim2.new(0.5,0,0.5,0)
main.Size = UDim2.new(0.6,0,0.3,0)
main.BackgroundColor3 = Color3.fromRGB(25,25,35)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0.3,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "Xeno Hub"
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(180,120,255)

-- KeyBox
local keyBox = Instance.new("TextBox", main)
keyBox.AnchorPoint = Vector2.new(0.5,0.5)
keyBox.Position = UDim2.new(0.5,0,0.55,0)
keyBox.Size = UDim2.new(0.85,0,0.25,0)
keyBox.BackgroundColor3 = Color3.fromRGB(40,40,60)
keyBox.PlaceholderText = "Enter key..."
keyBox.Text = ""
keyBox.Font = Enum.Font.Gotham
keyBox.TextScaled = true
keyBox.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0,8)

-- Buttons
local submit = Instance.new("TextButton", main)
submit.AnchorPoint = Vector2.new(0,1)
submit.Position = UDim2.new(0.05,0,0.95,0)
submit.Size = UDim2.new(0.4,0,0.2,0)
submit.BackgroundColor3 = Color3.fromRGB(150,90,255)
submit.Text = "Submit"
submit.Font = Enum.Font.GothamBold
submit.TextScaled = true
submit.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", submit).CornerRadius = UDim.new(0,8)

local close = Instance.new("TextButton", main)
close.AnchorPoint = Vector2.new(1,1)
close.Position = UDim2.new(0.95,0,0.95,0)
close.Size = UDim2.new(0.4,0,0.2,0)
close.BackgroundColor3 = Color3.fromRGB(80,80,80)
close.Text = "Close"
close.Font = Enum.Font.GothamBold
close.TextScaled = true
close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", close).CornerRadius = UDim.new(0,8)

-- Info Label
local info = Instance.new("TextLabel", main)
info.AnchorPoint = Vector2.new(0.5,1)
info.Position = UDim2.new(0.5,0,1,0)
info.Size = UDim2.new(1,0,0.15,0)
info.BackgroundTransparency = 1
info.Font = Enum.Font.Gotham
info.TextScaled = true
info.Text = "Attempts left: "..(maxAttempts - attempts)
info.TextColor3 = Color3.fromRGB(180,180,180)

-- Sound Setup
local ding = Instance.new("Sound", gui)
ding.SoundId = "rbxassetid://9118823101" -- ding sound
ding.Volume = 3

local music = Instance.new("Sound", gui)
music.SoundId = "rbxassetid://422668266" -- The Viper by BabyChiefDoIt
music.Volume = 3

-- Draggable
local dragging, dragInput, dragStart, startPos
main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)
UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
	end
end)

-- Key Checker
local function loadOrion()
	info.Text = "Loading Orion Hub..."
	
	-- Load Orion Library
	local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
	
	-- Create the window
	local Window = OrionLib:MakeWindow({
		Name = "Xeno Hub", 
		HidePremium = false, 
		SaveConfig = true, 
		ConfigFolder = "XenoHubConfig"
	})
	
	-- Create tabs and elements
	local MainTab = Window:MakeTab({
		Name = "Main",
		Icon = "rbxassetid://4483345998",
		PremiumOnly = false
	})
	
	MainTab:AddLabel("Xeno Hub Loaded Successfully! ✅")
	MainTab:AddParagraph("Welcome", "Thank you for using Xeno Hub with Orion UI")
	
	-- Add some example elements
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
	
	-- Create another tab
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
	
	-- Play music for 30 seconds
	music:Play()
	task.delay(30, function() 
		music:Stop() 
	end)
	
	-- Close the key GUI
	gui:Destroy()
	
	-- Init Orion
	OrionLib:Init()
end

local function checkKey(k)
	attempts += 1
	if k == correctKey then
		ding:Play()
		info.Text = "Correct!"
		task.delay(1, loadOrion)
	else
		local left = maxAttempts - attempts
		if left <= 0 then
			info.Text = "Locked out."
			submit.Active = false
			keyBox.TextEditable = false
		else
			info.Text = "Wrong key. Attempts left: " .. left
		end
	end
end

-- Buttons logic
submit.MouseButton1Click:Connect(function()
	if keyBox.Text ~= "" then checkKey(keyBox.Text) end
end)
close.MouseButton1Click:Connect(function() gui:Destroy() end)
keyBox.FocusLost:Connect(function(enter) 
	if enter and keyBox.Text ~= "" then 
		checkKey(keyBox.Text) 
	end 
end)
