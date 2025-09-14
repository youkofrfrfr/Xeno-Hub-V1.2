-- Xeno Hub Key System with Orion-Style UI
-- Key: xenhub123

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local correctKey = "xenhub123"
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
	local ok, OrionLib = pcall(function()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
	end)
	if not ok then
		info.Text = "Failed to load Orion."
		return
	end
	local Window = OrionLib:MakeWindow({Name="Xeno Hub", HidePremium=false, IntroText="Welcome!"})
	local Tab = Window:MakeTab({Name="Main",Icon="rbxassetid://4483345998"})
	Tab:AddLabel("Xeno Hub Loaded ✅")
	-- Music play for 30s
	music:Play()
	task.delay(30,function() music:Stop() end)
	gui:Destroy()
end

local function checkKey(k)
	attempts+=1
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
			info.Text = "Wrong key. Attempts left: "..left
		end
	end
end

-- Buttons logic
submit.MouseButton1Click:Connect(function()
	if keyBox.Text ~= "" then checkKey(keyBox.Text) end
end)
close.MouseButton1Click:Connect(function() gui:Destroy() end)
keyBox.FocusLost:Connect(function(enter) if enter and keyBox.Text~="" then checkKey(keyBox.Text) end end)title.TextColor3 = Color3.fromRGB(255,255,255)
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
