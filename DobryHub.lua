-- GUI to Lua 
-- Version: 0.0.3

-- Instances:

local DobryHub = Instance.new("ScreenGui")
local Menu_1 = Instance.new("Frame")
local UICorner_1 = Instance.new("UICorner")
local HubName_1 = Instance.new("TextLabel")
local RobloxName_1 = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")
local Scroll_1 = Instance.new("ScrollingFrame")
local MovementButton_1 = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local TeleportButton_1 = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local TextLabel_1 = Instance.new("TextLabel")
local UICorner_5 = Instance.new("UICorner")
local TabFrames_1 = Instance.new("Frame")
local UICorner_6 = Instance.new("UICorner")
local Tab2_1 = Instance.new("ScrollingFrame")
local Tab1_1 = Instance.new("ScrollingFrame")
local FillingBars_1 = Instance.new("Frame")
local UICorner_7 = Instance.new("UICorner")
local JumpHack2Frame_1 = Instance.new("Frame")
local FillBar_1 = Instance.new("Frame")
local UICorner_8 = Instance.new("UICorner")
local UICorner_9 = Instance.new("UICorner")
local JumpLabel_1 = Instance.new("TextLabel")
local UICorner_10 = Instance.new("UICorner")
local JumpHackFrame_1 = Instance.new("Frame")
local FillBar_2 = Instance.new("Frame")
local UICorner_11 = Instance.new("UICorner")
local UICorner_12 = Instance.new("UICorner")
local JumpLabel_2 = Instance.new("TextLabel")
local UICorner_13 = Instance.new("UICorner")
local SpeedHackFrame_1 = Instance.new("Frame")
local FillBar_3 = Instance.new("Frame")
local UICorner_14 = Instance.new("UICorner")
local UICorner_15 = Instance.new("UICorner")
local SpeedLabel_1 = Instance.new("TextLabel")
local UICorner_16 = Instance.new("UICorner")
local JumpInfo_1 = Instance.new("TextLabel")
local JumpInfo2_1 = Instance.new("TextLabel")
local SpeedHackInfo_1 = Instance.new("TextLabel")

-- Properties:
DobryHub.Name = "DobryHub"
DobryHub.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Menu_1.Name = "Menu"
Menu_1.Parent = DobryHub
Menu_1.BackgroundColor3 = Color3.fromRGB(27,27,27)
Menu_1.BackgroundTransparency = 0.6499999761581421
Menu_1.BorderColor3 = Color3.fromRGB(0,0,0)
Menu_1.BorderSizePixel = 0
Menu_1.Position = UDim2.new(0.334763944, 0,0.241206035, 0)
Menu_1.Size = UDim2.new(0, 532,0, 432)

UICorner_1.Parent = Menu_1

HubName_1.Name = "HubName"
HubName_1.Parent = Menu_1
HubName_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
HubName_1.BackgroundTransparency = 1
HubName_1.BorderColor3 = Color3.fromRGB(0,0,0)
HubName_1.BorderSizePixel = 0
HubName_1.Position = UDim2.new(0.0206766911, 0,0.0254629627, 0)
HubName_1.Size = UDim2.new(0, 138,0, 38)
HubName_1.Font = Enum.Font.SourceSans
HubName_1.Text = "Dobry Hub"
HubName_1.TextColor3 = Color3.fromRGB(255,255,255)
HubName_1.TextScaled = true
HubName_1.TextSize = 14
HubName_1.TextWrapped = true

RobloxName_1.Name = "RobloxName"
RobloxName_1.Parent = Menu_1
RobloxName_1.BackgroundColor3 = Color3.fromRGB(74,74,74)
RobloxName_1.BackgroundTransparency = 0.6499999761581421
RobloxName_1.BorderColor3 = Color3.fromRGB(0,0,0)
RobloxName_1.BorderSizePixel = 0
RobloxName_1.Position = UDim2.new(0.0206766911, 0,0.930555582, 0)
RobloxName_1.Size = UDim2.new(0, 137,0, 23)
RobloxName_1.Font = Enum.Font.SourceSans
RobloxName_1.Text = "Label"
RobloxName_1.TextColor3 = Color3.fromRGB(255,255,255)
RobloxName_1.TextScaled = true
RobloxName_1.TextSize = 14
RobloxName_1.TextWrapped = true

UICorner_2.Parent = RobloxName_1

Scroll_1.Name = "Scroll"
Scroll_1.Parent = Menu_1
Scroll_1.Active = true
Scroll_1.BackgroundColor3 = Color3.fromRGB(59,59,59)
Scroll_1.BackgroundTransparency = 0.75
Scroll_1.BorderColor3 = Color3.fromRGB(0,0,0)
Scroll_1.BorderSizePixel = 0
Scroll_1.Position = UDim2.new(0.0206766911, 0,0.136574075, 0)
Scroll_1.Size = UDim2.new(0, 138,0, 337)
Scroll_1.ClipsDescendants = true
Scroll_1.AutomaticCanvasSize = Enum.AutomaticSize.None
Scroll_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
Scroll_1.CanvasPosition = Vector2.new(0, 0)
Scroll_1.CanvasSize = UDim2.new(0, 0,0, 98)
Scroll_1.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
Scroll_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
Scroll_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
Scroll_1.ScrollBarImageColor3 = Color3.fromRGB(85,85,85)
Scroll_1.ScrollBarImageTransparency = 0
Scroll_1.ScrollBarThickness = 2
Scroll_1.ScrollingDirection = Enum.ScrollingDirection.XY
Scroll_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
Scroll_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
Scroll_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

MovementButton_1.Name = "MovementButton"
MovementButton_1.Parent = Scroll_1
MovementButton_1.Active = true
MovementButton_1.BackgroundColor3 = Color3.fromRGB(0,0,0)
MovementButton_1.BackgroundTransparency = 0.550000011920929
MovementButton_1.BorderColor3 = Color3.fromRGB(0,0,0)
MovementButton_1.BorderSizePixel = 0
MovementButton_1.Position = UDim2.new(0.0579710156, 0,0.0339433365, 0)
MovementButton_1.Size = UDim2.new(0, 121,0, 28)
MovementButton_1.Font = Enum.Font.SourceSans
MovementButton_1.Text = "Movement"
MovementButton_1.TextColor3 = Color3.fromRGB(255,255,255)
MovementButton_1.TextSize = 19
MovementButton_1.TextWrapped = true

UICorner_3.Parent = MovementButton_1

TeleportButton_1.Name = "TeleportButton"
TeleportButton_1.Parent = Scroll_1
TeleportButton_1.Active = true
TeleportButton_1.BackgroundColor3 = Color3.fromRGB(0,0,0)
TeleportButton_1.BackgroundTransparency = 0.75
TeleportButton_1.BorderColor3 = Color3.fromRGB(0,0,0)
TeleportButton_1.BorderSizePixel = 0
TeleportButton_1.Position = UDim2.new(0.0579710156, 0,0.135000005, 0)
TeleportButton_1.Size = UDim2.new(0, 121,0, 28)
TeleportButton_1.Font = Enum.Font.SourceSans
TeleportButton_1.Text = "Teleports"
TeleportButton_1.TextColor3 = Color3.fromRGB(255,255,255)
TeleportButton_1.TextSize = 19
TeleportButton_1.TextWrapped = true

UICorner_4.Parent = TeleportButton_1

TextLabel_1.Parent = Menu_1
TextLabel_1.BackgroundColor3 = Color3.fromRGB(74,74,74)
TextLabel_1.BackgroundTransparency = 0.75
TextLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
TextLabel_1.BorderSizePixel = 0
TextLabel_1.Position = UDim2.new(0.296063185, 0,0.0185185187, 0)
TextLabel_1.Size = UDim2.new(0, 361,0, 41)
TextLabel_1.Font = Enum.Font.SourceSans
TextLabel_1.Text = "    🔥Dobry Hub Momento,  by xprcx on disocord 🔥"
TextLabel_1.TextColor3 = Color3.fromRGB(255,255,255)
TextLabel_1.TextSize = 20
TextLabel_1.TextXAlignment = Enum.TextXAlignment.Left

UICorner_5.Parent = TextLabel_1

TabFrames_1.Name = "TabFrames"
TabFrames_1.Parent = Menu_1
TabFrames_1.BackgroundColor3 = Color3.fromRGB(59,59,59)
TabFrames_1.BackgroundTransparency = 0.75
TabFrames_1.BorderColor3 = Color3.fromRGB(0,0,0)
TabFrames_1.BorderSizePixel = 0
TabFrames_1.Position = UDim2.new(0.295112789, 0,0.134259254, 0)
TabFrames_1.Size = UDim2.new(0, 362,0, 366)

UICorner_6.Parent = TabFrames_1

Tab2_1.Name = "Tab2"
Tab2_1.Parent = TabFrames_1
Tab2_1.Active = true
Tab2_1.BackgroundColor3 = Color3.fromRGB(59,59,59)
Tab2_1.BackgroundTransparency = 1
Tab2_1.BorderColor3 = Color3.fromRGB(0,0,0)
Tab2_1.BorderSizePixel = 0
Tab2_1.Position = UDim2.new(0.00139672717, 0,0.0252842307, 0)
Tab2_1.Size = UDim2.new(0, 360,0, 350)
Tab2_1.Visible = false
Tab2_1.ClipsDescendants = true
Tab2_1.AutomaticCanvasSize = Enum.AutomaticSize.None
Tab2_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
Tab2_1.CanvasPosition = Vector2.new(0, 0)
Tab2_1.CanvasSize = UDim2.new(0, 0,1, 0)
Tab2_1.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
Tab2_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
Tab2_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
Tab2_1.ScrollBarImageColor3 = Color3.fromRGB(85,85,85)
Tab2_1.ScrollBarImageTransparency = 0
Tab2_1.ScrollBarThickness = 2
Tab2_1.ScrollingDirection = Enum.ScrollingDirection.XY
Tab2_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
Tab2_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
Tab2_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

Tab1_1.Name = "Tab1"
Tab1_1.Parent = TabFrames_1
Tab1_1.Active = true
Tab1_1.BackgroundColor3 = Color3.fromRGB(59,59,59)
Tab1_1.BackgroundTransparency = 1
Tab1_1.BorderColor3 = Color3.fromRGB(0,0,0)
Tab1_1.BorderSizePixel = 0
Tab1_1.Position = UDim2.new(0.00139672717, 0,0.0252842307, 0)
Tab1_1.Size = UDim2.new(0, 360,0, 350)
Tab1_1.ClipsDescendants = true
Tab1_1.AutomaticCanvasSize = Enum.AutomaticSize.None
Tab1_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
Tab1_1.CanvasPosition = Vector2.new(0, 0)
Tab1_1.CanvasSize = UDim2.new(0, 0,1, 0)
Tab1_1.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
Tab1_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
Tab1_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
Tab1_1.ScrollBarImageColor3 = Color3.fromRGB(85,85,85)
Tab1_1.ScrollBarImageTransparency = 0
Tab1_1.ScrollBarThickness = 2
Tab1_1.ScrollingDirection = Enum.ScrollingDirection.XY
Tab1_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
Tab1_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
Tab1_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

FillingBars_1.Name = "FillingBars"
FillingBars_1.Parent = Tab1_1
FillingBars_1.BackgroundColor3 = Color3.fromRGB(0,0,0)
FillingBars_1.BackgroundTransparency = 0.8500000238418579
FillingBars_1.BorderColor3 = Color3.fromRGB(0,0,0)
FillingBars_1.BorderSizePixel = 0
FillingBars_1.Position = UDim2.new(0.0388888903, 0,0.0124973841, 0)
FillingBars_1.Size = UDim2.new(0, 332,0, 111)

UICorner_7.Parent = FillingBars_1

JumpHack2Frame_1.Name = "JumpHack2Frame"
JumpHack2Frame_1.Parent = FillingBars_1
JumpHack2Frame_1.BackgroundColor3 = Color3.fromRGB(63,63,63)
JumpHack2Frame_1.BackgroundTransparency = 0.6000000238418579
JumpHack2Frame_1.BorderColor3 = Color3.fromRGB(0,0,0)
JumpHack2Frame_1.BorderSizePixel = 0
JumpHack2Frame_1.Position = UDim2.new(0.381000012, 0,0, 83)
JumpHack2Frame_1.Size = UDim2.new(0.563218474, 0,0.0115484633, 15)

FillBar_1.Name = "FillBar"
FillBar_1.Parent = JumpHack2Frame_1
FillBar_1.BackgroundColor3 = Color3.fromRGB(91,91,91)
FillBar_1.BackgroundTransparency = 0.6499999761581421
FillBar_1.BorderColor3 = Color3.fromRGB(0,0,0)
FillBar_1.BorderSizePixel = 0
FillBar_1.Position = UDim2.new(0, 0,3.72750446e-06, 0)
FillBar_1.Size = UDim2.new(0, 59,0, 16)

UICorner_8.Parent = FillBar_1

UICorner_9.Parent = JumpHack2Frame_1

JumpLabel_1.Name = "JumpLabel"
JumpLabel_1.Parent = JumpHack2Frame_1
JumpLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
JumpLabel_1.BackgroundTransparency = 1
JumpLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
JumpLabel_1.BorderSizePixel = 0
JumpLabel_1.Size = UDim2.new(0, 186,0, 16)
JumpLabel_1.Font = Enum.Font.SourceSans
JumpLabel_1.Text = "50"
JumpLabel_1.TextColor3 = Color3.fromRGB(255,255,255)
JumpLabel_1.TextSize = 14

UICorner_10.Parent = JumpLabel_1

JumpHackFrame_1.Name = "JumpHackFrame"
JumpHackFrame_1.Parent = FillingBars_1
JumpHackFrame_1.BackgroundColor3 = Color3.fromRGB(63,63,63)
JumpHackFrame_1.BackgroundTransparency = 0.6000000238418579
JumpHackFrame_1.BorderColor3 = Color3.fromRGB(0,0,0)
JumpHackFrame_1.BorderSizePixel = 0
JumpHackFrame_1.Position = UDim2.new(0.381000012, 0,0, 45)
JumpHackFrame_1.Size = UDim2.new(0.563218474, 0,0.0115484633, 15)

FillBar_2.Name = "FillBar"
FillBar_2.Parent = JumpHackFrame_1
FillBar_2.BackgroundColor3 = Color3.fromRGB(91,91,91)
FillBar_2.BackgroundTransparency = 0.6499999761581421
FillBar_2.BorderColor3 = Color3.fromRGB(0,0,0)
FillBar_2.BorderSizePixel = 0
FillBar_2.Position = UDim2.new(0, 0,3.72750446e-06, 0)
FillBar_2.Size = UDim2.new(0, 29,0, 16)

UICorner_11.Parent = FillBar_2

UICorner_12.Parent = JumpHackFrame_1

JumpLabel_2.Name = "JumpLabel"
JumpLabel_2.Parent = JumpHackFrame_1
JumpLabel_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
JumpLabel_2.BackgroundTransparency = 1
JumpLabel_2.BorderColor3 = Color3.fromRGB(0,0,0)
JumpLabel_2.BorderSizePixel = 0
JumpLabel_2.Size = UDim2.new(0, 186,0, 16)
JumpLabel_2.Font = Enum.Font.SourceSans
JumpLabel_2.Text = "7.2"
JumpLabel_2.TextColor3 = Color3.fromRGB(255,255,255)
JumpLabel_2.TextSize = 14

UICorner_13.Parent = JumpLabel_2

SpeedHackFrame_1.Name = "SpeedHackFrame"
SpeedHackFrame_1.Parent = FillingBars_1
SpeedHackFrame_1.BackgroundColor3 = Color3.fromRGB(63,63,63)
SpeedHackFrame_1.BackgroundTransparency = 0.6000000238418579
SpeedHackFrame_1.BorderColor3 = Color3.fromRGB(0,0,0)
SpeedHackFrame_1.BorderSizePixel = 0
SpeedHackFrame_1.Position = UDim2.new(0.381000012, 0,0, 8)
SpeedHackFrame_1.Size = UDim2.new(0.563218474, 0,0.0115484633, 15)

FillBar_3.Name = "FillBar"
FillBar_3.Parent = SpeedHackFrame_1
FillBar_3.BackgroundColor3 = Color3.fromRGB(91,91,91)
FillBar_3.BackgroundTransparency = 0.6499999761581421
FillBar_3.BorderColor3 = Color3.fromRGB(0,0,0)
FillBar_3.BorderSizePixel = 0
FillBar_3.Position = UDim2.new(0, 0,3.72750446e-06, 0)
FillBar_3.Size = UDim2.new(0, 12,0, 16)

UICorner_14.Parent = FillBar_3

UICorner_15.Parent = SpeedHackFrame_1

SpeedLabel_1.Name = "SpeedLabel"
SpeedLabel_1.Parent = SpeedHackFrame_1
SpeedLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
SpeedLabel_1.BackgroundTransparency = 1
SpeedLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
SpeedLabel_1.BorderSizePixel = 0
SpeedLabel_1.Size = UDim2.new(0, 186,0, 18)
SpeedLabel_1.Font = Enum.Font.SourceSans
SpeedLabel_1.Text = "16"
SpeedLabel_1.TextColor3 = Color3.fromRGB(255,255,255)
SpeedLabel_1.TextSize = 14

UICorner_16.Parent = SpeedLabel_1

JumpInfo_1.Name = "JumpInfo"
JumpInfo_1.Parent = FillingBars_1
JumpInfo_1.BackgroundColor3 = Color3.fromRGB(77,77,77)
JumpInfo_1.BackgroundTransparency = 1
JumpInfo_1.BorderColor3 = Color3.fromRGB(0,0,0)
JumpInfo_1.BorderSizePixel = 0
JumpInfo_1.Position = UDim2.new(0.00282287598, 0,0, 40)
JumpInfo_1.Size = UDim2.new(0, 129,0, 30)
JumpInfo_1.Font = Enum.Font.SourceSansBold
JumpInfo_1.Text = "Jump Height"
JumpInfo_1.TextColor3 = Color3.fromRGB(209,209,209)
JumpInfo_1.TextSize = 24
JumpInfo_1.TextWrapped = true

JumpInfo2_1.Name = "JumpInfo2"
JumpInfo2_1.Parent = FillingBars_1
JumpInfo2_1.BackgroundColor3 = Color3.fromRGB(77,77,77)
JumpInfo2_1.BackgroundTransparency = 1
JumpInfo2_1.BorderColor3 = Color3.fromRGB(0,0,0)
JumpInfo2_1.BorderSizePixel = 0
JumpInfo2_1.Position = UDim2.new(0.0148710683, 0,0.341504276, 37)
JumpInfo2_1.Size = UDim2.new(0, 120,0, 30)
JumpInfo2_1.Font = Enum.Font.SourceSansBold
JumpInfo2_1.Text = "Jump Power"
JumpInfo2_1.TextColor3 = Color3.fromRGB(209,209,209)
JumpInfo2_1.TextSize = 24
JumpInfo2_1.TextWrapped = true

SpeedHackInfo_1.Name = "SpeedHackInfo"
SpeedHackInfo_1.Parent = FillingBars_1
SpeedHackInfo_1.BackgroundColor3 = Color3.fromRGB(77,77,77)
SpeedHackInfo_1.BackgroundTransparency = 1
SpeedHackInfo_1.BorderColor3 = Color3.fromRGB(0,0,0)
SpeedHackInfo_1.BorderSizePixel = 0
SpeedHackInfo_1.Position = UDim2.new(0.00583492406, 0,0.0223650243, 0)
SpeedHackInfo_1.Size = UDim2.new(0, 126,0, 30)
SpeedHackInfo_1.Font = Enum.Font.SourceSansBold
SpeedHackInfo_1.Text = "Speed Hack"
SpeedHackInfo_1.TextColor3 = Color3.fromRGB(209,209,209)
SpeedHackInfo_1.TextSize = 24
SpeedHackInfo_1.TextWrapped = true

local function DSAJsdPhYKicQTXl()
local script = Instance.new("Script",JumpHack2Frame_1)
local sliderFrame = script.Parent
local fillBar = sliderFrame:FindFirstChild("FillBar")
local jumpLabel = sliderFrame:FindFirstChild("JumpLabel")
local userInput = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")

local player = players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")

local minHeight = 0
local maxHeight = 250
local lockedHeight = 50
local isDragging = false
local function updateCharacter(newCharacter)
	character = newCharacter
	humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid.JumpPower = lockedHeight
	end
	humanoid.Died:Connect(function()
	end)
end
player.CharacterAdded:Connect(updateCharacter)
local function updateSlider(inputX)
	local sliderStart = sliderFrame.AbsolutePosition.X
	local sliderWidth = sliderFrame.AbsoluteSize.X
	local relativePos = math.clamp((inputX - sliderStart) / sliderWidth, 0, 1)

	-- Obliczenie nowej wysokości skoku
	lockedHeight = minHeight + (maxHeight - minHeight) * relativePos

	-- Zastosowanie zmiany w JumpHeight
	if humanoid then
		humanoid.JumpPower = lockedHeight
	end

	-- Aktualizacja interfejsu
	fillBar.Size = UDim2.new(relativePos, 0, 1, 0)
	jumpLabel.Text = tostring(math.floor(lockedHeight))
	jumpLabel.Position = UDim2.new(0.5, -jumpLabel.AbsoluteSize.X / 2, 0.5, -jumpLabel.AbsoluteSize.Y / 2)
end

-- Funkcja inicjująca suwak
local function initializeSlider()
	local currentJumpHeight = humanoid.JumpPower
	local relativePos = (currentJumpHeight - minHeight) / (maxHeight - minHeight)
	updateSlider(sliderFrame.AbsolutePosition.X + sliderFrame.AbsoluteSize.X * relativePos)
end

initializeSlider()

-- Nasłuchiwanie zmiany pozycji suwaka
sliderFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isDragging = true
		updateSlider(input.Position.X)
	end
end)

userInput.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isDragging = false
	end
end)

userInput.InputChanged:Connect(function(input)
	if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		updateSlider(input.Position.X)
	end
end)
updateCharacter(character)
end
coroutine.wrap(DSAJsdPhYKicQTXl)()


local function vCehdlOWSbEQoPHh()
local script = Instance.new("Script",JumpHackFrame_1)
local sliderFrame = script.Parent
local fillBar = sliderFrame:FindFirstChild("FillBar")
local jumpLabel = sliderFrame:FindFirstChild("JumpLabel")
local userInput = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")

local player = players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")

local minHeight = 0
local maxHeight = 250
local lockedHeight = 50
local isDragging = false
local function updateCharacter(newCharacter)
	character = newCharacter
	humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid.JumpHeight = lockedHeight
	end
	humanoid.Died:Connect(function()
	end)
end
player.CharacterAdded:Connect(updateCharacter)
local function updateSlider(inputX)
	local sliderStart = sliderFrame.AbsolutePosition.X
	local sliderWidth = sliderFrame.AbsoluteSize.X
	local relativePos = math.clamp((inputX - sliderStart) / sliderWidth, 0, 1)

	-- Obliczenie nowej wysokości skoku
	lockedHeight = minHeight + (maxHeight - minHeight) * relativePos

	-- Zastosowanie zmiany w JumpHeight
	if humanoid then
		humanoid.JumpHeight = lockedHeight
	end

	-- Aktualizacja interfejsu
	fillBar.Size = UDim2.new(relativePos, 0, 1, 0)
	jumpLabel.Text = tostring(math.floor(lockedHeight))
	jumpLabel.Position = UDim2.new(0.5, -jumpLabel.AbsoluteSize.X / 2, 0.5, -jumpLabel.AbsoluteSize.Y / 2)
end

-- Funkcja inicjująca suwak
local function initializeSlider()
	local currentJumpHeight = humanoid.JumpHeight
	local relativePos = (currentJumpHeight - minHeight) / (maxHeight - minHeight)
	updateSlider(sliderFrame.AbsolutePosition.X + sliderFrame.AbsoluteSize.X * relativePos)
end

initializeSlider()

-- Nasłuchiwanie zmiany pozycji suwaka
sliderFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isDragging = true
		updateSlider(input.Position.X)
	end
end)

userInput.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isDragging = false
	end
end)

userInput.InputChanged:Connect(function(input)
	if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		updateSlider(input.Position.X)
	end
end)
updateCharacter(character)
end
coroutine.wrap(vCehdlOWSbEQoPHh)()


local function BeXUDavvZxgzCkuC()
local script = Instance.new("Script",SpeedHackFrame_1)
local sliderFrame = script.Parent
local fillBar = sliderFrame:FindFirstChild("FillBar")
local speedLabel = sliderFrame:FindFirstChild("SpeedLabel")
local userInput = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")

local player = players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")

local minSpeed = 0
local maxSpeed = 250
local lockedSpeed = 16
local isDragging = false
local isMoving = false
local isJumping = false

local currentSpeed = lockedSpeed

-- Funkcja aktualizująca postać
local function updateCharacter(newCharacter)
	character = newCharacter
	humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		-- Ustawienie prędkości po respawnie
		humanoid.WalkSpeed = currentSpeed
		humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
			isMoving = humanoid.MoveDirection.Magnitude > 0
		end)

		humanoid.StateChanged:Connect(function(_, newState)
			if newState == Enum.HumanoidStateType.Freefall then
				isJumping = true
			elseif newState == Enum.HumanoidStateType.Landed then
				isJumping = false
			end
		end)

		humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			if humanoid.WalkSpeed ~= currentSpeed then
				humanoid.WalkSpeed = currentSpeed
			end
		end)

		-- Podłącz funkcję po śmierci
		humanoid.Died:Connect(function()
			-- W momencie śmierci resetujemy postać, co spowoduje ponowne wywołanie updateCharacter
			print("Gracz umarł. Czekam na respawn...")
		end)
	end
end

-- Podłączenie do CharacterAdded, aby aktualizować postać po respawnie
player.CharacterAdded:Connect(updateCharacter)

-- Funkcja do aktualizacji prędkości przy przeciąganiu suwaka
local function updateSlider(inputX)
	local sliderStart = sliderFrame.AbsolutePosition.X
	local sliderWidth = sliderFrame.AbsoluteSize.X
	local relativePos = math.clamp((inputX - sliderStart) / sliderWidth, 0, 1)

	lockedSpeed = minSpeed + (maxSpeed - minSpeed) * relativePos
	fillBar.Size = UDim2.new(relativePos, 0, 1, 0)
	speedLabel.Text = tostring(math.floor(lockedSpeed))
	speedLabel.Position = UDim2.new(0.5, -speedLabel.AbsoluteSize.X / 2, 0.5, -speedLabel.AbsoluteSize.Y / 2)

	if humanoid then
		currentSpeed = lockedSpeed
		humanoid.WalkSpeed = currentSpeed
	end
end

-- Rozpoczęcie przeciągania suwaka
sliderFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isDragging = true
		updateSlider(input.Position.X)
	end
end)

-- Zakończenie przeciągania
userInput.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isDragging = false
	end
end)

-- Zmiana pozycji suwaka
userInput.InputChanged:Connect(function(input)
	if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		updateSlider(input.Position.X)
	end
end)

-- Aktualizacja prędkości w zależności od ruchu i skoku
runService.Stepped:Connect(function()
	if humanoid then
		if isMoving then
			local speedMultiplier = isJumping and 0.9 or 0.95
			humanoid.WalkSpeed = currentSpeed * speedMultiplier
		else
			humanoid.WalkSpeed = 16
		end
	end
end)

-- Upewniamy się, że ustawienia są zachowane po respawnie
updateCharacter(character)

end
coroutine.wrap(BeXUDavvZxgzCkuC)()


local function FbbyctsPvouwUnWW()
local script = Instance.new("Script",FillingBars_1)

end
coroutine.wrap(FbbyctsPvouwUnWW)()


local function BjnjxTXodtKvvuLC()
local script = Instance.new("Script",Menu_1)
local Trollware = script.Parent.Parent.Parent:WaitForChild("DobryHub")
Trollware.ResetOnSpawn = false
local dragFrame = script.Parent
local player = game.Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local scrollingFrame = dragFrame:FindFirstChild("Scroll")
local Tab2 = dragFrame.TabFrames:FindFirstChild("Tab2")
local RobloxName = dragFrame:WaitForChild("RobloxName")
local userInput = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local dragging = false
local dragStart, startPos

local screenSize = workspace.CurrentCamera.ViewportSize
local isMenuVisible = true
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")

RobloxName.Text = player.Name
local function isInsideScrollingFrame(input)
	if scrollingFrame then
		local absPos = scrollingFrame.AbsolutePosition
		local absSize = scrollingFrame.AbsoluteSize

		return input.Position.X >= absPos.X and input.Position.X <= absPos.X + absSize.X and
			input.Position.Y >= absPos.Y and input.Position.Y <= absPos.Y + absSize.Y
	end
	return false
end

local locations = {
	{name = "📍 Checkpoint 1", pos = Vector3.new(-16.2081, 424.3245, -1219.8966)},
	{name = "📍 Checkpoint 2", pos = Vector3.new(-1016.5502, 425.3245, -1223.9514)},
	{name = "📍 Checkpoint 3", pos = Vector3.new(-2123.8684, 425.3245, -2126.4228)},
	{name = "📍 Checkpoint 4", pos = Vector3.new(-535.4802, 425.3245, -3354.5544)},
	{name = "📍 Checkpoint 5", pos = Vector3.new(-310.2325, 425.3245, -5783.3056)},
	{name = "📍 Checkpoint 6", pos = Vector3.new(-310.3312, 425.3245, -7339.6093)},
	{name = "📍 Checkpoint 7", pos = Vector3.new(-1703.3302, 543.4370, -9143.2060)},
	{name = "📍 Checkpoint 8", pos = Vector3.new(-992.1283, 635.4371, -9915.4853)},
	{name = "📍 Chapter 2", pos = Vector3.new(-310.8330, 423.8274, -7570.8808)}
}
local function getPlayerVehicleFromZone()
	local playerName = player.Name
	local buildZones = Workspace:FindFirstChild("BuildZones")
	local verifiedCar = nil
	if buildZones then
		for _, zone in pairs(buildZones:GetChildren()) do
			if zone.Name == "Zone" then
				local playerObjectValue = zone:FindFirstChild("Player")
				if playerObjectValue and playerObjectValue:IsA("ObjectValue") then
					local playerNameInZone = tostring(playerObjectValue.Value)
					if playerNameInZone == playerName then
						print(playerName .. " is in zone: " .. zone.Name)
						local vehicle = zone:FindFirstChild("Vehicle")
						if vehicle and vehicle:FindFirstChild("CarModel") then
							verifiedCar = vehicle.CarModel
						end
						break
					end
				end
			end
		end
	end
	return verifiedCar
end
for i, loc in ipairs(locations) do
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -10, 0, 35)
	button.Position = UDim2.new(0, 5, 0, (i - 1) * 40)
	button.Text = loc.name
	button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Font = Enum.Font.Gotham
	button.TextSize = 14
	button.BackgroundTransparency = 0.7
	button.Parent = Tab2
	local buttonCorner = Instance.new("UICorner")
	buttonCorner.CornerRadius = UDim.new(0, 6)
	buttonCorner.Parent = button
	button.MouseButton1Click:Connect(function()
		local verifiedCar = getPlayerVehicleFromZone()
		if verifiedCar and verifiedCar.PrimaryPart then
			for _, part in ipairs(verifiedCar:GetDescendants()) do
				if part:IsA("BasePart") then
					part.Anchored = true
				end
			end
			verifiedCar:SetPrimaryPartCFrame(CFrame.new(loc.pos))
			task.delay(0.1, function()
				for _, part in ipairs(verifiedCar:GetDescendants()) do
					if part:IsA("BasePart") then
						part.Anchored = false
					end
				end
			end)
		else
			player.Character:SetPrimaryPartCFrame(CFrame.new(loc.pos))
		end
	end)
end

local function updateCharacter(newCharacter)
	character = newCharacter
	humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.Died:Connect(function()
			updateCharacter(character)
		end)
	end
end
player.CharacterAdded:Connect(updateCharacter)
updateCharacter(character)

local function isInsideAnyScrollingFrame(input)
	for _, tab in pairs(dragFrame.TabFrames:GetChildren()) do
		if tab:IsA("ScrollingFrame") then -- Sprawdza, czy to ScrollingFrame
			local absPos = tab.AbsolutePosition
			local absSize = tab.AbsoluteSize

			if input.Position.X >= absPos.X and input.Position.X <= absPos.X + absSize.X and
				input.Position.Y >= absPos.Y and input.Position.Y <= absPos.Y + absSize.Y then
				return true -- Jeśli input jest wewnątrz dowolnej zakładki, zwracamy true
			end
		end
	end
	return false
end
local function openMenu()
	dragFrame.Visible = true  -- Pokazujemy menu przed animacją
	local startPos = UDim2.new(0.5, -dragFrame.AbsoluteSize.X / 2, -1, 0)  -- Start nad ekranem
	local endPos = UDim2.new(0.5, -dragFrame.AbsoluteSize.X / 2, 0.2, 0)  -- Finalna pozycja na środku ekranu

	dragFrame.Position = startPos
	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
	local tween = tweenService:Create(dragFrame, tweenInfo, { Position = endPos })
	tween:Play()
end

-- Funkcja animacji zamykania menu (skok w górę i zniknięcie w dół)
local function closeMenu()
	local jumpUpPos = UDim2.new(dragFrame.Position.X.Scale, dragFrame.Position.X.Offset, dragFrame.Position.Y.Scale - 0.05, dragFrame.Position.Y.Offset)
	local endPos = UDim2.new(dragFrame.Position.X.Scale, dragFrame.Position.X.Offset, 1.2, dragFrame.Position.Y.Offset)

	local tweenUp = tweenService:Create(dragFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = jumpUpPos })
	local tweenDown = tweenService:Create(dragFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Position = endPos })

	tweenUp:Play()
	tweenUp.Completed:Connect(function()
		tweenDown:Play()
	end)

	tweenDown.Completed:Connect(function()
		dragFrame.Visible = false
	end)
end

-- Funkcja do przełączania widoczności menu
local function toggleMenu()
	isMenuVisible = not isMenuVisible
	if isMenuVisible then
		openMenu()
	else
		closeMenu()
	end
end
openMenu()
userInput.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.M then
		toggleMenu()
	end
end)

-- ========================== PRZECIĄGANIE ==========================

-- Rozpoczęcie przeciągania
dragFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		if isInsideScrollingFrame(input) then return end  -- Ignoruj, jeśli zaczynamy w ScrollingFrame
		if isInsideAnyScrollingFrame(input) then return end

		dragging = true
		dragStart = input.Position
		startPos = dragFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

-- Przeciąganie
userInput.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		dragFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Zakończenie przeciągania
userInput.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)


-- ========================= Tabs ============================== --
local MovementButton = scrollingFrame:FindFirstChild("MovementButton")
local RenderButton = scrollingFrame:FindFirstChild("TeleportButton")

local tabs = {
	Tab1 = dragFrame.TabFrames:FindFirstChild("Tab1"),
	Tab2 = dragFrame.TabFrames:FindFirstChild("Tab2"),
}

-- Funkcja przełączania zakładek
local function switchTab(tabName)
	for name, tab in pairs(tabs) do
		if tab then
			tab.Visible = (name == tabName) -- Pokazuje tylko wybraną zakładkę
		end
	end
end

-- ✅ Ustawienie domyślnej zakładki na Tab1
switchTab("Tab1")
if MovementButton then
	MovementButton.BackgroundTransparency = 0.55 -- Podświetlenie aktywnego przycisku
end
if RenderButton then
	RenderButton.BackgroundTransparency = 0.75
end

-- Obsługa kliknięć
if MovementButton then
	MovementButton.MouseButton1Click:Connect(function()
		switchTab("Tab1")
		MovementButton.BackgroundTransparency = 0.55
		RenderButton.BackgroundTransparency = 0.75
	end)
end

if RenderButton then
	RenderButton.MouseButton1Click:Connect(function()
		switchTab("Tab2")
		MovementButton.BackgroundTransparency = 0.75
		RenderButton.BackgroundTransparency = 0.55
	end)
end


end
coroutine.wrap(BjnjxTXodtKvvuLC)()
