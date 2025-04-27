local Library = {}

local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

function Library:CreateWindow(config)
    -- Usuwanie starego GUI jeśli istnieje
    local existingGui = PlayerGui:FindFirstChild(config.Name or "MyLibraryUI")
    if existingGui then
        existingGui:Destroy()
    end

    -- Tworzenie głównego GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = config.Name or "MyLibraryUI"
    screenGui.Parent = PlayerGui

    -- Główne okno
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    -- Zaokrąglone rogi
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainFrame

    -- Tytuł
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = config.Title or "Library UI"
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 24
    titleLabel.Parent = mainFrame

    -- Background pod tytuł/taby (drag bar)
    local dragBar = Instance.new("Frame")
    dragBar.Size = UDim2.new(1, 0, 0, 60)
    dragBar.Position = UDim2.new(0, 0, 0, 40)
    dragBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    dragBar.Parent = mainFrame

    local dragBarCorner = Instance.new("UICorner")
    dragBarCorner.CornerRadius = UDim.new(0, 8)
    dragBarCorner.Parent = dragBar

    -- Holder na przyciski tabów
    local tabButtonsHolder = Instance.new("Frame")
    tabButtonsHolder.Size = UDim2.new(1, -20, 0, 30)
    tabButtonsHolder.Position = UDim2.new(0, 10, 0, 45)
    tabButtonsHolder.BackgroundTransparency = 1
    tabButtonsHolder.Parent = mainFrame

    local tabButtonLayout = Instance.new("UIListLayout")
    tabButtonLayout.FillDirection = Enum.FillDirection.Horizontal
    tabButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabButtonLayout.Padding = UDim.new(0, 5)
    tabButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabButtonLayout.Parent = tabButtonsHolder

    -- Holder na zawartość tabów
    local tabContentHolder = Instance.new("Frame")
    tabContentHolder.Size = UDim2.new(1, -20, 1, -110)
    tabContentHolder.Position = UDim2.new(0, 10, 0, 100)
    tabContentHolder.BackgroundTransparency = 1
    tabContentHolder.Parent = mainFrame

    local tabs = {}

    local window = {}

    function window:CreateTab(tabName)
        -- Tworzenie przycisku Taba
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0, 100, 1, 0)
        tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        tabButton.Text = tabName
        tabButton.Font = Enum.Font.GothamBold
        tabButton.TextSize = 14
        tabButton.Parent = tabButtonsHolder

        local tabButtonCorner = Instance.new("UICorner")
        tabButtonCorner.CornerRadius = UDim.new(0, 8)
        tabButtonCorner.Parent = tabButton

        -- Tworzenie ScrollingFrame dla zawartości tabów
        local tabFrame = Instance.new("ScrollingFrame")
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabFrame.ScrollBarThickness = 5
        tabFrame.ScrollingDirection = Enum.ScrollingDirection.Y
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false
        tabFrame.Parent = tabContentHolder

        -- Smooth Scrolling
        local UIS = game:GetService("UserInputService")
        tabFrame.MouseWheelForward:Connect(function()
            tabFrame.CanvasPosition = tabFrame.CanvasPosition - Vector2.new(0, 30)
        end)
        tabFrame.MouseWheelBackward:Connect(function()
            tabFrame.CanvasPosition = tabFrame.CanvasPosition + Vector2.new(0, 30)
        end)

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 5)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = tabFrame

        -- Funkcja wyboru Taba
        tabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(tabContentHolder:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            tabFrame.Visible = true
        end)

        local tab = {}

        function tab:CreateButton(buttonText, callback)
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -10, 0, 40)
            button.Position = UDim2.new(0, 5, 0, 0)
            button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Text = buttonText
            button.Font = Enum.Font.Gotham
            button.TextSize = 16
            button.Parent = tabFrame

            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 8)
            buttonCorner.Parent = button

            -- Hover efekt
            button.MouseEnter:Connect(function()
                button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            end)
            button.MouseLeave:Connect(function()
                button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            end)

            button.MouseButton1Click:Connect(function()
                callback()
            end)

            -- Update Scroll Size
            layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                tabFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
            end)
        end

        table.insert(tabs, tab)
        return tab
    end

    return window
end

return Library
