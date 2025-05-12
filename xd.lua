local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local coreGui = game:GetService("CoreGui")
local workspace = game:GetService("Workspace")
local car, root
local function updateCarReference()
    car = workspace:WaitForChild("Cars"):WaitForChild(player.Name):WaitForChild("VisualCarBody")
    root = car:FindFirstChild("Origin") or car:FindFirstChild("VehicleSeat")
end
updateCarReference()
player.CharacterAdded:Connect(function()
    task.wait(1)
    updateCarReference()
end)
local hitboxes = {}
local autoFarmEnabled = false
local autoFarmEnabled2 = false
local velocityLoopRunning = false

-- Lokacje dla przeskakiwania
local location1 = CFrame.new(-639.7, 285.1, 1423.7)
local location2 = CFrame.new(-200.7, 285.1, 1423.7)

-- BodyVelocity setup
local spinning = false
local flying = false
local flySpeed = 150
local control = {F = 0, B = 0, L = 0, R = 0}
local bodyGyro, bodyVelocity

if coreGui:FindFirstChild("DriftCarts") then
    coreGui:FindFirstChild("DriftCarts"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DriftCarts"
screenGui.ResetOnSpawn = false
screenGui.Parent = coreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 450, 0, 350)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Visible = true
frame.ZIndex = 1
frame.Parent = screenGui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
topBar.BorderSizePixel = 0
topBar.Parent = frame
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "☠️     Drift Carts 🛒    ☠️"
title.TextColor3 = Color3.fromRGB(255, 0, 0)
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

local function createButton(name, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Text = name
    button.Font = Enum.Font.Gotham
    button.TextSize = 16
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    button.BorderSizePixel = 0
    button.Parent = scrolling
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 10)

    button.MouseButton1Click:Connect(callback)
end
local function createSliderButton(labelText, defaultValue, minValue, maxValue, callback)
    -- Tworzymy kontener (Frame zamiast TextButton)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 0, 40)
    container.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    container.BorderSizePixel = 0
    container.Parent = scrolling
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 10)
    
    -- Dodajemy przezroczysty TextButton do obsługi zdarzeń
    local hitbox = Instance.new("TextButton")
    hitbox.Size = UDim2.new(1, 0, 1, 0)
    hitbox.Text = ""
    hitbox.BackgroundTransparency = 1
    hitbox.Parent = container

    -- Etykieta z nazwą suwaka
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 100, 1, 0)
    label.Text = labelText
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.Parent = container

    -- Kontener na slider
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -120, 0, 16)
    sliderFrame.Position = UDim2.new(0, 110, 0.5, -8)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = container
    Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(1, 0)

    -- Dynamicznie zapełniający się pasek
    local fillBar = Instance.new("Frame")
    fillBar.Size = UDim2.new(0, 0, 1, 0)
    fillBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    fillBar.BorderSizePixel = 0
    fillBar.Parent = sliderFrame
    Instance.new("UICorner", fillBar).CornerRadius = UDim.new(1, 0)

    -- Tekst z wartością liczbową
    local valueBox = Instance.new("TextBox")
    valueBox.Size = UDim2.new(0, 50, 1, 0)
    valueBox.Position = UDim2.new(0.7, -60, 0, 0)
    valueBox.Text = tostring(defaultValue)
    valueBox.Font = Enum.Font.Gotham
    valueBox.TextSize = 14
    valueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    valueBox.BackgroundTransparency = 1
    valueBox.TextXAlignment = Enum.TextXAlignment.Center
    valueBox.ClearTextOnFocus = false
    valueBox.Parent = container

    -- Funkcja do aktualizacji suwaka
    local function updateSlider(input)
        local sliderX = sliderFrame.AbsolutePosition.X
        local sliderWidth = sliderFrame.AbsoluteSize.X
        
        local mouseX = input.Position.X
        local relativeX = math.clamp(mouseX - sliderX, 0, sliderWidth)
        local normalizedValue = relativeX / sliderWidth
        
        local currentValue = minValue + (normalizedValue * (maxValue - minValue))
        currentValue = math.floor(currentValue)
        
        fillBar.Size = UDim2.new(normalizedValue, 0, 1, 0)
        valueBox.Text = tostring(currentValue)
        
        if callback then
            callback(currentValue)
        end
    end

    -- Obsługa zdarzeń myszy dla slidera
    local dragging = false
    
    hitbox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local sliderBounds = sliderFrame.AbsolutePosition
            local mouseX = input.Position.X
            
            if mouseX >= sliderBounds.X and mouseX <= (sliderBounds.X + sliderFrame.AbsoluteSize.X) then
                dragging = true
                updateSlider(input)
            end
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)

    -- Obsługa edycji wartości
    local lastClickTime = 0
    
    valueBox.FocusLost:Connect(function()
        local text = valueBox.Text
        local number = tonumber(text)
        
        if number then
            number = math.clamp(number, minValue, maxValue)
            local normalized = (number - minValue) / (maxValue - minValue)
            fillBar.Size = UDim2.new(normalized, 0, 1, 0)
            valueBox.Text = tostring(math.floor(number))
            
            if callback then
                callback(number)
            end
        else
            valueBox.Text = tostring(math.floor(tonumber(valueBox.Text) or defaultValue))
        end
    end)
    
    valueBox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local currentTime = tick()
            if currentTime - lastClickTime < 0.5 then
                valueBox:CaptureFocus()
            end
            lastClickTime = currentTime
        end
    end)

    -- Inicjalizacja suwaka
    local initialNormalized = (defaultValue - minValue) / (maxValue - minValue)
    fillBar.Size = UDim2.new(initialNormalized, 0, 1, 0)
    valueBox.Text = tostring(defaultValue)

    return function(value)
        if value then
            local normalized = (value - minValue) / (maxValue - minValue)
            fillBar.Size = UDim2.new(normalized, 0, 1, 0)
            valueBox.Text = tostring(math.floor(value))
        end
        return tonumber(valueBox.Text)
    end
end
local function createToggleButton(labelText, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Text = labelText
    button.Font = Enum.Font.Gotham
    button.TextSize = 16
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    button.BorderSizePixel = 0
    button.Parent = scrolling
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 10)

    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0, 60, 0, 24)
    toggleFrame.Position = UDim2.new(1, -70, 0.5, 0)
    toggleFrame.AnchorPoint = Vector2.new(0, 0.5)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(170, 0, 0)  -- Kolor czerwony (domyślny)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = button
    Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 20, 0, 20)
    circle.Position = UDim2.new(0, 2, 0.5, 0)
    circle.AnchorPoint = Vector2.new(0, 0.5)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Parent = toggleFrame
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

    local toggled = false
    local function updateToggle(animated)
        local newPos = toggled and UDim2.new(1, -22, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
        local newColor = toggled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)

        if animated then
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = newPos}):Play()
            TweenService:Create(toggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = newColor}):Play()
        else
            circle.Position = newPos
            toggleFrame.BackgroundColor3 = newColor
        end

        if callback then
            callback(toggled)
        end
    end

    -- Obsługuje kliknięcia przycisku
    button.MouseButton1Click:Connect(function()
        toggled = not toggled
        updateToggle(true)  -- Animacja toggle
    end)

    -- Inicjalizacja przycisku
    updateToggle(false)

    return function()
        return toggled
    end
end

local function optimizedAutoFarmLoop()
    while autoFarmEnabled do
        if #hitboxes > 0 then
            local randomHitbox = hitboxes[math.random(1, #hitboxes)]
            if randomHitbox and randomHitbox:IsA("BasePart") then
                randomHitbox.CFrame = root.CFrame
            end
        end
        task.wait(0.5) -- Większy odstęp czasowy, aby zmniejszyć obciążenie
    end
end
spawn(function()
    while true do
        if autoFarmEnabled then  -- Sprawdzenie, czy AutoFarm jest włączone
            hitboxes = {}  -- Resetowanie listy hitboxów
            for _, obj in ipairs(workspace.Destructibles:GetChildren()) do
                local hitbox = obj:FindFirstChild("Hitbox")
                if hitbox and hitbox:IsA("BasePart") then
                    table.insert(hitboxes, hitbox)
                end
            end
        end
        task.wait(0.25)
    end
end)
local bodyVelocity2 = Instance.new("BodyVelocity")
bodyVelocity2.MaxForce = Vector3.new(500000, 0, 500000)
bodyVelocity2.Velocity = Vector3.new(0, 0, 0)
local function loopMoveBetweenPoints()
    if velocityLoopRunning then return end
    velocityLoopRunning = true

    while autoFarmEnabled2 do
        root.CFrame = location1
        task.wait(0.2)  -- Zwiększ czas oczekiwania w celu zmniejszenia obciążenia

        local direction = (location2.Position - root.Position)
        direction = Vector3.new(direction.X, 0, direction.Z).Unit * 20
        bodyVelocity2.Velocity = direction
        bodyVelocity2.Parent = root

        root.CFrame = location2
        task.wait(0.2)  -- Zwiększ czas oczekiwania w celu zmniejszenia obciążenia

        root.CFrame = location1
        task.wait(0.2)  -- Zwiększ czas oczekiwania w celu zmniejszenia obciążenia
    end

    -- Wyłącz BodyVelocity po wyłączeniu autofarma
    bodyVelocity2:Destroy()
    velocityLoopRunning = false
end


local function startFlying()
	character = player.Character or player.CharacterAdded:Wait()
	humanoidRootPart = character:WaitForChild("HumanoidRootPart")

	bodyGyro = Instance.new("BodyGyro")
	bodyGyro.P = 9e4
	bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	bodyGyro.CFrame = humanoidRootPart.CFrame
	bodyGyro.Parent = humanoidRootPart

	bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.Velocity = Vector3.zero
	bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
	bodyVelocity.Parent = humanoidRootPart

	flying = true

	RunService.RenderStepped:Connect(function()
		if flying and bodyVelocity and bodyGyro then
			local camera = workspace.CurrentCamera
			local moveVec = Vector3.new(control.L - control.R, 0, control.B - control.F)
			moveVec = camera.CFrame:VectorToWorldSpace(moveVec)
			bodyVelocity.Velocity = moveVec * flySpeed
			bodyGyro.CFrame = camera.CFrame
		end
	end)
end

local function stopFlying()
	flying = false
	if bodyGyro then bodyGyro:Destroy() end
	if bodyVelocity then bodyVelocity:Destroy() end
end
UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.W then control.F = 1 end
	if input.KeyCode == Enum.KeyCode.S then control.B = 1 end
	if input.KeyCode == Enum.KeyCode.A then control.R = 1 end
	if input.KeyCode == Enum.KeyCode.D then control.L = 1 end
end)

UIS.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.W then control.F = 0 end
	if input.KeyCode == Enum.KeyCode.S then control.B = 0 end
	if input.KeyCode == Enum.KeyCode.A then control.R = 0 end
	if input.KeyCode == Enum.KeyCode.D then control.L = 0 end
end)
createToggleButton("Fly", function(state)
	if state then
		startFlying()
	else
		stopFlying()
	end
end)
createToggleButton("AutoFarm", function(state)
    autoFarmEnabled = state
    if state then
        spawn(optimizedAutoFarmLoop)
        spawn(function()
            while autoFarmEnabled do
                if #hitboxes > 0 then
                    local randomHitbox = hitboxes[math.random(1, #hitboxes)]
                    if randomHitbox and randomHitbox:IsA("BasePart") then
                        randomHitbox.CFrame = root.CFrame
                    end
                end
                task.wait()
            end
        end)
    end
end)
createToggleButton("Long Drift", function(state)
    autoFarmEnabled2 = state
    if state then
		loopMoveBetweenPoints()
    else

    end
end)

createSliderButton("WalkSpeed", 16, 0, 200, function(speed)
        humanoid.WalkSpeed = speed
end)

local function toggleMenu(show)
    if not frame then
        warn("Frame is not initialized!")
        return
    end

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

local isVisible = true
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.M then
        isVisible = not isVisible
        toggleMenu(isVisible)
    end
end)

-- Dragging
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