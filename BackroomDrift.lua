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
local CoinsFolder = workspace.CoinsSetup:WaitForChild("CoinsFolder")
local Cars = workspace:WaitForChild("Cars")
local spinning = false
local myCar = nil
local autoTeleporting = false
local flying = false
local flySpeed = 150
local control = {F = 0, B = 0, L = 0, R = 0}
local bodyGyro, bodyVelocity

local boostEnabled = false
local boostValue = 50
local originalSpeed = nil
local boostConnection = nil

for i = 1, 30 do
    warn("🔥 Witaj w skrypcie Backrooms Drift! Subskrybuj twórcę na YouTube: XenoScriptsPL 🔥")
    print("🔥 Witaj w skrypcie Backrooms Drift! Subskrybuj twórcę na YouTube: XenoScriptsPL 🔥")
end

task.spawn(function()
    for i = 1, 30 do
        game.StarterGui:SetCore("SendNotification", {
            Title = "Backrooms Drift",
            Text = "Subskrybuj YouTube: XenoScriptsPL 🔥",
            Duration = 3
        })
    end
end)

if coreGui:FindFirstChild("FireTouchMenu") then
    coreGui:FindFirstChild("FireTouchMenu"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FireTouchMenu"
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
title.Text = "☠️     Backrooms Drift (UGC 🔥)    ☠️"
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
local function findClosestCoin(position)
    local closestCoin = nil
    local shortestDistance = math.huge
    for _, coin in pairs(CoinsFolder:GetChildren()) do
        if coin:IsA("BasePart") then
            local distance = (coin.Position - position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestCoin = coin
            end
        end
    end

    return closestCoin
end
local function findBigOrMediumCoin(position)
    local closestCoin = nil
    local shortestDistance = math.huge
    for _, coin in pairs(CoinsFolder:GetChildren()) do
        if coin:IsA("BasePart") and (coin.Name == "BigCoin" or coin.Name == "MediumCoin") then
            local distance = (coin.Position - position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestCoin = coin
            end
        end
    end

    return closestCoin
end
local function findPlayerCarByID(playerID)
    for _, car in pairs(Cars:GetChildren()) do
        if car:IsA("Model") and car:GetAttribute("PlayerId") then
            local ownerID = car:GetAttribute("PlayerId")
            if ownerID == playerID then
                return car
            end
        end
    end
    return nil
end
local function causeSeizure(car)
	if not car or not car.PrimaryPart then return end

	local angular = Instance.new("BodyAngularVelocity")
	angular.AngularVelocity = Vector3.new(
		math.random(-5, 5),
		math.random(-10, 10),
		math.random(-5, 5)
	)
	angular.MaxTorque = Vector3.new(5e4, 5e4, 5e4)
	angular.P = 1000
	angular.Name = "SeizureSpin"
	angular.Parent = car.PrimaryPart

	local force = Instance.new("BodyForce")
	force.Force = Vector3.new(
		math.random(-250, 250),
		math.random(150, 300),
		math.random(-250, 250)
	)
	force.Name = "SeizureForce"
	force.Parent = car.PrimaryPart

	task.delay(1, function()
		if angular and angular.Parent then angular:Destroy() end
		if force and force.Parent then force:Destroy() end
	end)
end
local function startSpinner()
    if not myCar or not myCar.PrimaryPart then return end
    local angular = Instance.new("BodyAngularVelocity")
    angular.AngularVelocity = Vector3.new(0, 50, 0)  -- Obrót wokół osi Y (pionowej)
    angular.MaxTorque = Vector3.new(5e4, 5e4, 5e4)   -- Siła obrotu
    angular.P = 1000                                   -- Wartość rotacji
    angular.Name = "Spinner"
    angular.Parent = myCar.PrimaryPart
end
local function stopSpinner()
    if not myCar or not myCar.PrimaryPart then return end
    local spinner = myCar.PrimaryPart:FindFirstChild("Spinner")
    if spinner then
        spinner:Destroy()  -- Usuwamy BodyAngularVelocity
    end
end

local function teleportToClosestCoin()
    if not myCar or not myCar.PrimaryPart then return end
    local carPos = myCar.PrimaryPart.Position
    local coin = findClosestCoin(carPos)
    if coin then
        local offset = Vector3.new(0, 1, 0)
        local newCFrame = CFrame.new(coin.Position + offset)
        myCar:SetPrimaryPartCFrame(newCFrame)
    else
        warn("Nie znaleziono żadnej monety.")
    end
end
local function teleportToBigOrMediumCoin()
    if not myCar or not myCar.PrimaryPart then return end

    local carPos = myCar.PrimaryPart.Position
    local coin = findBigOrMediumCoin(carPos)
    if coin then
        local offset = Vector3.new(0, 1, 0)
        local newCFrame = CFrame.new(coin.Position + offset)
        myCar:SetPrimaryPartCFrame(newCFrame)
    else
        warn("Nie znaleziono BigCoin ani MediumCoin.")
    end
end
local function setupPlayerCar()
    local playerID = player.UserId
    myCar = findPlayerCarByID(playerID)

    if myCar then
        if not myCar.PrimaryPart then
            myCar.PrimaryPart = myCar:FindFirstChild("Chassis")
        end
        print("Znaleziono samochód przypisany do gracza:", myCar.Name)
    else
        print("Nie znaleziono samochodu przypisanego do gracza.")
    end
end
local function monitorPlayerCar()
    while true do
        local newCar = findPlayerCarByID(player.UserId)

        if newCar and newCar ~= myCar then
            myCar = newCar
            if not myCar.PrimaryPart then
                myCar.PrimaryPart = myCar:FindFirstChild("Chassis")
            end
        end
        wait(1)
    end
end
local function startAutoTeleport()
    while autoTeleporting do
	    causeSeizure(myCar)
        teleportToClosestCoin()
        wait(0.08)
    end
end
local function startBigMediumCoinTeleport()
    while autoTeleporting do
        teleportToBigOrMediumCoin()
        local waitTime = math.random(3, 5)
        wait(waitTime)
    end
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
local function applyBoost(car)
    if not car or not car.PrimaryPart then return end
    
    -- Znajdź lub utwórz BodyVelocity dla boostu
    local boostVelocity = car.PrimaryPart:FindFirstChild("BoostVelocity")
    if not boostVelocity then
        boostVelocity = Instance.new("BodyVelocity")
        boostVelocity.Name = "BoostVelocity"
        boostVelocity.MaxForce = Vector3.new(4000, 0, 4000)
        boostVelocity.P = 1000
        boostVelocity.Parent = car.PrimaryPart
    end
    
    -- Ustaw prędkość boostu w kierunku jazdy
    local direction = car.PrimaryPart.CFrame.LookVector
    boostVelocity.Velocity = direction * boostValue
end

local function removeBoost(car)
    if not car or not car.PrimaryPart then return end
    local boostVelocity = car.PrimaryPart:FindFirstChild("BoostVelocity")
    if boostVelocity then
        boostVelocity:Destroy()
    end
end

local function setupBoost()
    if boostConnection then
        boostConnection:Disconnect()
        boostConnection = nil
    end
    
    boostConnection = RunService.Heartbeat:Connect(function()
        if boostEnabled and myCar and myCar.PrimaryPart then
            -- Sprawdź czy gracz próbuje jechać do przodu
            if UIS:IsKeyDown(Enum.KeyCode.W) or UIS:IsKeyDown(Enum.KeyCode.Up) then
                applyBoost(myCar)
            else
                removeBoost(myCar)
            end
        else
            removeBoost(myCar)
        end
    end)
end
local function stopFlying()
	flying = false
	if bodyGyro then bodyGyro:Destroy() end
	if bodyVelocity then bodyVelocity:Destroy() end
end
local function flipCar180()
    if not myCar or not myCar.PrimaryPart then return end
    
    -- Pobierz obecną orientację samochodu
    local currentCFrame = myCar.PrimaryPart.CFrame
    local currentPosition = currentCFrame.Position
    
    -- Oblicz nową orientację (obrót o 180 stopni wokół osi Y)
    local newCFrame = CFrame.new(currentPosition) * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, 0.5, 0)
    
    -- Zastosuj nową orientację z małym efektem wizualnym
    for i = 1, 10 do
        myCar:SetPrimaryPartCFrame(currentCFrame:Lerp(newCFrame, i/10))
        wait(0.02)
    end
    
    -- Dodaj mały efekt fizyczny dla bardziej naturalnego wyglądu
    local angularVelocity = Instance.new("BodyAngularVelocity")
    angularVelocity.AngularVelocity = Vector3.new(0, 5, 0)
    angularVelocity.MaxTorque = Vector3.new(1000, 1000, 1000)
    angularVelocity.Parent = myCar.PrimaryPart
    
    -- Usuń efekt po chwili
    wait(0.5)
    if angularVelocity and angularVelocity.Parent then
        angularVelocity:Destroy()
    end
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
createButton("Car Flip", function()
    flipCar180()
end)
createToggleButton("Fly", function(state)
	if state then
		startFlying()
	else
		stopFlying()
	end
end)
createToggleButton("AutoDetect (Car)", function(state)
	if state then
		spawn(monitorPlayerCar)
	else

	end
end)
createToggleButton("AutoFarm (Points)", function(state)
    autoTeleporting = state
	if state then
		spawn(startAutoTeleport)
        spawn(startBigMediumCoinTeleport)
	else

	end
end)
createToggleButton("Spinner", function(state)
    if state then
        startSpinner()
    else
        stopSpinner()
    end
end)
createSliderButton("WalkSpeed", 16, 0, 200, function(speed)
        humanoid.WalkSpeed = speed
end)
local boostToggle = createToggleButton("Vehicle Boost", function(state)
    boostEnabled = state
    if state then
        setupBoost()
    else
        if boostConnection then
            boostConnection:Disconnect()
            boostConnection = nil
        end
        removeBoost(myCar)
    end
end)

local boostSlider = createSliderButton("Boost Value", 50, 10, 200, function(value)
    boostValue = value
    -- Aktualizuj boost jeśli jest aktywny
    if boostEnabled and myCar and myCar.PrimaryPart then
        applyBoost(myCar)
    end
end)
local function monitorPlayerCar()
    while true do
        local newCar = findPlayerCarByID(player.UserId)

        if newCar and newCar ~= myCar then
            if myCar then
                removeBoost(myCar)
            end
            
            myCar = newCar
            if not myCar.PrimaryPart then
                myCar.PrimaryPart = myCar:FindFirstChild("Chassis")
            end
            if boostEnabled then
                setupBoost()
            end
        end
        wait(1)
    end
end

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
setupPlayerCar()
