-- Mobile Friendly Key System for Xeno Hub
-- Key: xenhub123

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

local correctKey = "xenhub123"
local maxAttempts = 5
local attempts = 0

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XenoKeyGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.85, 0, 0.35, 0) -- responsive width/height
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5,0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,12)

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.new(0,10,0,10)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.Text = "Xeno Hub - Key Required"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Center

-- Subtitle
local subtitle = Instance.new("TextLabel", mainFrame)
subtitle.Size = UDim2.new(1, -20, 0, 25)
subtitle.Position = UDim2.new(0,10,0,50)
subtitle.BackgroundTransparency = 1
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 16
subtitle.Text = "Enter your key to unlock"
subtitle.TextColor3 = Color3.fromRGB(200,200,200)
subtitle.TextXAlignment = Enum.TextXAlignment.Center

-- Key Box
local keyBox = Instance.new("TextBox", mainFrame)
keyBox.Size = UDim2.new(0.9,0,0,50)
keyBox.Position = UDim2.new(0.5,0,0.45,0)
keyBox.AnchorPoint = Vector2.new(0.5,0.5)
keyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
keyBox.PlaceholderText = "Enter key here..."
keyBox.Text = ""
keyBox.TextScaled = true
keyBox.Font = Enum.Font.Gotham
keyBox.TextColor3 = Color3.fromRGB(255,255,255)
keyBox.ClearTextOnFocus = false
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0,8)

-- Submit Button
local submitBtn = Instance.new("TextButton", mainFrame)
submitBtn.Size = UDim2.new(0.4,0,0,45)
submitBtn.Position = UDim2.new(0.05,0,0.8,0)
submitBtn.BackgroundColor3 = Color3.fromRGB(45,150,255)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 20
submitBtn.TextColor3 = Color3.fromRGB(255,255,255)
submitBtn.Text = "Submit"
Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0,8)

-- Cancel Button
local cancelBtn = Instance.new("TextButton", mainFrame)
cancelBtn.Size = UDim2.new(0.4,0,0,45)
cancelBtn.Position = UDim2.new(0.55,0,0.8,0)
cancelBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
cancelBtn.Font = Enum.Font.GothamBold
cancelBtn.TextSize = 20
cancelBtn.TextColor3 = Color3.fromRGB(255,255,255)
cancelBtn.Text = "Close"
Instance.new("UICorner", cancelBtn).CornerRadius = UDim.new(0,8)

-- Info label
local infoLabel = Instance.new("TextLabel", mainFrame)
infoLabel.Size = UDim2.new(1, -20, 0, 25)
infoLabel.Position = UDim2.new(0,10,1,-30)
infoLabel.BackgroundTransparency = 1
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 16
infoLabel.Text = "Attempts left: "..(maxAttempts - attempts)
infoLabel.TextColor3 = Color3.fromRGB(200,200,200)
infoLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Dragging support (works for touch + mouse)
local dragging, dragInput, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)
UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Notify helper
local function notify(text,dur)
	infoLabel.Text = text
	delay(dur or 2,function()
		infoLabel.Text = "Attempts left: "..math.max(0,maxAttempts - attempts)
	end)
end

-- Destroy GUI
local function destroyKeyGui()
	if screenGui then screenGui:Destroy() end
end

-- Load Orion
local function loadOrion()
	local success, OrionLib = pcall(function()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
	end)
	if not success then
		notify("Failed to load Orion",3)
		return
	end
	local Window = OrionLib:MakeWindow({
		Name = "Xeno Hub",
		HidePremium = false,
		IntroText = "Xeno Hub",
		SaveConfig = true
	})
	local MainTab = Window:MakeTab({
		Name = "Main",
		Icon = "rbxassetid://4483345998",
		PremiumOnly = false
	})
	MainTab:AddLabel("Welcome mobile user!")
	destroyKeyGui()
end

-- Key Check
local function checkKey(inputKey)
	attempts += 1
	if inputKey == correctKey then
		notify("Correct Key!",2)
		delay(1,loadOrion)
	else
		local left = math.max(0,maxAttempts - attempts)
		if left <= 0 then
			notify("Locked out.",3)
			keyBox.TextEditable = false
			submitBtn.Active = false
		else
			notify("Wrong key. "..left.." left.",2)
		end
	end
end

-- Connections
submitBtn.MouseButton1Click:Connect(function()
	if keyBox.Text ~= "" then
		checkKey(keyBox.Text)
	end
end)
cancelBtn.MouseButton1Click:Connect(destroyKeyGui)
keyBox.FocusLost:Connect(function(enter)
	if enter and keyBox.Text ~= "" then
		checkKey(keyBox.Text)
	end
end)

notify("Enter the key to continue.",3)
