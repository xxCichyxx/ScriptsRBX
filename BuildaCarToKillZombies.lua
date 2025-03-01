local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = playerGui:FindFirstChild("TeleportMenu") or Instance.new("ScreenGui")
screenGui.Name = "TeleportMenu"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false
screenGui.Enabled = true

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 350)
frame.Position = UDim2.new(0.5, -130, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = frame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Text = "🚗 Teleportacja Pojazdu"
titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleLabel

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 0, 270)  -- Increased height to use up more of the space
scrollFrame.Position = UDim2.new(0, 10, 0, 50)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)  -- We will set this dynamically
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 5
scrollFrame.Parent = frame

local locations = {
    {name = "📍 Miejsce 1 Chapter 1", pos = Vector3.new(-16.2081, 424.3245, -1219.8966)},
    {name = "📍 Miejsce 2 Chapter 1", pos = Vector3.new(-1016.5502, 425.3245, -1223.9514)},
    {name = "📍 Miejsce 3 Chapter 1", pos = Vector3.new(-2123.8684, 425.3245, -2126.4228)},
    {name = "📍 Miejsce 4 Chapter 1", pos = Vector3.new(-535.4802, 425.3245, -3354.5544)},
    {name = "📍 Miejsce 5 Chapter 1", pos = Vector3.new(-310.2325, 425.3245, -5783.3056)},
    {name = "📍 Miejsce 6 Chapter 1", pos = Vector3.new(-310.3312, 425.3245, -7339.6093)},
    {name = "📍 Miejsce 7 Chapter 2", pos = Vector3.new(-1703.3302, 543.4370, -9143.2060)},
    {name = "📍 Miejsce 8 Chapter 2", pos = Vector3.new(-992.1283, 635.4371, -9915.4853)}
}

-- Function to check the player's zone and return the vehicle
local function getPlayerVehicleFromZone()
    local playerName = player.Name
    local buildZones = Workspace:FindFirstChild("BuildZones")
    local verifiedCar = nil

    -- Check player's zone
    if buildZones then
        for _, zone in pairs(buildZones:GetChildren()) do
            if zone.Name == "Zone" then
                local playerObjectValue = zone:FindFirstChild("Player")
                if playerObjectValue and playerObjectValue:IsA("ObjectValue") then
                    local playerNameInZone = tostring(playerObjectValue.Value)
                    if playerNameInZone == playerName then
                        print(playerName .. " is in zone: " .. zone.Name)
                        -- Try to find the vehicle in this zone
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

-- Create buttons for teleportation locations
for i, loc in ipairs(locations) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 35)
    button.Position = UDim2.new(0, 5, 0, (i - 1) * 40)
    button.Text = loc.name
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = scrollFrame

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button

    button.MouseButton1Click:Connect(function()
        -- Get the vehicle from the player's zone
        local verifiedCar = getPlayerVehicleFromZone()
        if verifiedCar and verifiedCar.PrimaryPart then
            for _, part in ipairs(verifiedCar:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Anchored = true
                end
            end
            verifiedCar:SetPrimaryPartCFrame(CFrame.new(loc.pos))
            print("🚗 Vehicle teleported to: " .. tostring(loc.pos))
            
            task.delay(2, function()
                for _, part in ipairs(verifiedCar:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Anchored = false
                    end
                end
                print("🔓 Vehicle unlocked after teleportation.")
            end)
        else
            warn("❌ No vehicle found or player is not in the correct zone!")
        end
    end)
end

scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #locations * 40)

-- Make the frame draggable
local isDragging = false
local dragStart = Vector2.new()
local startPos = UDim2.new()
titleLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

titleLabel.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        local targetPos = startPos + UDim2.new(0, delta.X, 0, delta.Y)
        RunService.RenderStepped:Wait()
        frame.Position = UDim2.new(frame.Position.X.Scale, targetPos.X.Offset, frame.Position.Y.Scale, targetPos.Y.Offset)
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.M then
        screenGui.Enabled = not screenGui.Enabled
    end
end)