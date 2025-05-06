local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local coreGui = game:GetService("CoreGui")

if coreGui:FindFirstChild("TestyGUI") then
	coreGui:FindFirstChild("TestyGUI"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TestyGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = coreGui

-- Główna ramka
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 450, 0, 350)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Visible = true  -- Menu jest od razu widoczne
frame.ZIndex = 1
frame.Parent = screenGui

-- Zaokrąglenie głównej ramki
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 16)

-- Górny pasek
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
topBar.BorderSizePixel = 0
topBar.Parent = frame
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "🔥 Testy by xxCichyxx 🔥 Menu Bind: M"
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
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 12)

-- ScrollFrame automatycznie dopasowany
local scrolling = Instance.new("ScrollingFrame")
scrolling.Position = UDim2.new(0, 10, 0, 50)
scrolling.Size = UDim2.new(1, -20, 1, -60)
scrolling.BackgroundTransparency = 1
scrolling.BorderSizePixel = 0
scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
scrolling.ScrollBarThickness = 6
scrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrolling.ScrollingDirection = Enum.ScrollingDirection.Y
scrolling.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scrolling

-- Tablica z nazwami skryptów
local scriptLinks = {
	"UNCTEST.lua",
	"Sunc.lua",
	"Vulntest.lua",
	"RequireChecker.lua",
	"IndentityTest.lua",
	"LevelTest.lua",
	"XenoDLLTEST.lua"
}

-- URL do każdego skryptu
local scriptURLs = {
	"https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/Testy/UNCTEST.lua",
	"https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/Testy/Sunc.lua",
	"https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/Testy/Vulntest.lua",
	"https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/Testy/RequireChecker.lua",
	"https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/Testy/IndentityTest.lua",
	"https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/Testy/LevelTest.lua",
	"https://raw.githubusercontent.com/xxCichyxx/ScriptsRBX/refs/heads/main/Testy/XenoDLLTEST.lua"
}

-- Tworzenie przycisków na podstawie tablicy
for i, name in ipairs(scriptLinks) do
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -20, 0, 40)
    button.Position = UDim2.new(0, 10, 0, (i - 1) * 46) -- Dystans między przyciskami
	button.Text = i..". " .. name
	button.Font = Enum.Font.Gotham
	button.TextSize = 18
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	button.BorderSizePixel = 0
	button.Parent = scrolling
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 10)
	button.AutomaticSize = Enum.AutomaticSize.None

	-- Po kliknięciu przycisku ładujemy odpowiedni skrypt
	button.MouseButton1Click:Connect(function()
		pcall(function()
			loadstring(game:HttpGet(scriptURLs[i]))()
		end)
	end)
end

-- Animacje otwierania/zamykania
local function toggleMenu(show)
	if show then
		frame.Visible = true
		frame.Size = UDim2.new(0, 0, 0, 0)
		TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {
			Size = UDim2.new(0, 450, 0, 350),
			BackgroundTransparency = 0
		}):Play()
	else
		local tween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
			Size = UDim2.new(0, 0, 0, 0),
			BackgroundTransparency = 1
		})
		tween:Play()
		tween.Completed:Wait()
		frame.Visible = false
	end
end

closeButton.MouseButton1Click:Connect(function()
	toggleMenu(false)
end)

-- Klawisz M
local isVisible = true  -- Menu jest widoczne od razu
UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.M then
		isVisible = not isVisible
		toggleMenu(isVisible)
	end
end)

-- Zaawansowane przeciąganie
local dragging = false
local dragInput, dragStart, startPos
local smoothPos = frame.Position

topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

topBar.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

RunService.RenderStepped:Connect(function()
	if dragging and dragInput then
		local delta = dragInput.Position - dragStart
		smoothPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	frame.Position = frame.Position:Lerp(smoothPos, 0.2)
end)
