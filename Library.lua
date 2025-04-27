local Library = {}

local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Funkcja tworząca główne okno
function Library:CreateWindow(config)
    -- Jeśli GUI już istnieje — usuń je
    local existingGui = PlayerGui:FindFirstChild(config.Name or "MyLibraryUI")
    if existingGui then
        existingGui:Destroy()
    end

    -- Teraz tworzymy nowe GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = config.Name or "MyLibraryUI"
    screenGui.Parent = PlayerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.Parent = screenGui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    titleLabel.Text = config.Title or "Library UI"
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Parent = mainFrame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = mainFrame

    -- Funkcje do dodawania elementów
    local window = {}

    function window:CreateButton(text, callback)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 0, 40)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        button.TextColor3 = Color3.fromRGB(1, 1, 1)
        button.Text = text
        button.Parent = mainFrame

        button.MouseButton1Click:Connect(function()
            callback()
        end)
    end

    return window
end

return Library
