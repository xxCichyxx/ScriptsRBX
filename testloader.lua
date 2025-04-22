local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local coreGui = game:GetService("CoreGui")

warn("[Testy by xxCichyxx] - Menu otwierasz/zamykasz klawiszem M")

if coreGui:FindFirstChild("TestyGUI") then
	coreGui:FindFirstChild("TestyGUI"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TestyGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = coreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 450, 0, 350)
frame.Position = UDim2.new(0.5, -225, 0.5, -175)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
topBar.BorderSizePixel = 0
topBar.Parent = frame

-- Efekt RGB tytułu
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "Testy by xxCichyxx"
title.TextColor3 = Color3.fromRGB(255, 0, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -40, 0, 0)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 20
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeButton.Parent = topBar

closeButton.MouseButton1Click:Connect(function()
	frame.Visible = false
end)

-- ScrollFrame
local scrolling = Instance.new("ScrollingFrame")
scrolling.Size = UDim2.new(1, -20, 1, -60)
scrolling.Position = UDim2.new(0, 10, 0, 50)
scrolling.CanvasSize = UDim2.new(0, 0, 0, 500)
scrolling.ScrollBarThickness = 6
scrolling.BackgroundTransparency = 1
scrolling.BorderSizePixel = 0
scrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrolling.CanvasPosition = Vector2.new(0, 0)
scrolling.ScrollingDirection = Enum.ScrollingDirection.Y
scrolling.Parent = frame

-- Layout w ScrollFrame
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scrolling

-- Lista linków
local scriptLinks = {
	["CherryEnvironmentTest.lua"] = "https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/Testy/CherryEnvironmentTest.lua",
	["IndentityTest.lua"] = "https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/Testy/IndentityTest.lua",
	["LevelTest.lua"] = "https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/Testy/LevelTest.lua",
	["RequireChecker.lua"] = "https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/Testy/RequireChecker.lua",
	["Sunc.lua"] = "https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/Testy/Sunc.lua",
	["UNCTEST.lua"] = "https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/Testy/UNCTEST.lua",
	["Vulntest.lua"] = "https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/Testy/Vulntest.lua",
	["XenoDLLTEST.lua"] = "https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/Testy/XenoDLLTEST.lua"
}

-- Tworzenie przycisków
for name, url in pairs(scriptLinks) do
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 40)
	button.Text = name
	button.Font = Enum.Font.Gotham
	button.TextSize = 18
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	button.BorderSizePixel = 0
	button.Parent = scrolling

	button.MouseButton1Click:Connect(function()
		pcall(function()
			loadstring(game:HttpGet(url))()
		end)
	end)
end
local isVisible = true
UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.M then
		isVisible = not isVisible
		frame.Visible = isVisible
	end
end)