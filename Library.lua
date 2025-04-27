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

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainFrame

    -- Pasek tytułu
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = titleBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = config.Title or "Library UI"
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 24
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar

    -- Holder na taby
    local tabButtonsHolder = Instance.new("Frame")
    tabButtonsHolder.Size = UDim2.new(1, -20, 0, 30)
    tabButtonsHolder.Position = UDim2.new(0, 10, 0, 60)
    tabButtonsHolder.BackgroundTransparency = 1
    tabButtonsHolder.Parent = mainFrame

    local tabButtonLayout = Instance.new("UIListLayout")
    tabButtonLayout.FillDirection = Enum.FillDirection.Horizontal
    tabButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabButtonLayout.Padding = UDim.new(0, 5)
    tabButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    tabButtonLayout.Parent = tabButtonsHolder

    -- Holder na zawartość tabów
    local tabContentHolder = Instance.new("Frame")
    tabContentHolder.Size = UDim2.new(1, -20, 1, -100)
    tabContentHolder.Position = UDim2.new(0, 10, 0, 100)
    tabContentHolder.BackgroundTransparency = 1
    tabContentHolder.Parent = mainFrame

    local tabs = {}
    local firstTab = nil

    local window = {}

    -- Funkcja do tworzenia tabów
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
        tabFrame.ClipsDescendants = true

        -- Smooth Scroll
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

        tabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(tabContentHolder:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            tabFrame.Visible = true
        end)

        local tab = {}

        -- Funkcja do tworzenia przycisków w tabie
        function tab:CreateButton(buttonText, callback)
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -20, 0, 40)
            button.Position = UDim2.new(0, 10, 0, 0)
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

        -- Funkcja do tworzenia nagłówków z minimalną przestrzenią
        function window:CreateNapis(napisText)
            local headerLabel = Instance.new("TextLabel")
            headerLabel.Size = UDim2.new(1, 0, 0, 20)  -- Zwiększamy wysokość nagłówka, żeby zmieścił się tekst
            headerLabel.BackgroundTransparency = 1
            headerLabel.Text = napisText
            headerLabel.TextColor3 = Color3.new(1, 1, 1)
            headerLabel.Font = Enum.Font.Gotham
            headerLabel.TextSize = 14  -- Zmniejszamy rozmiar czcionki
            headerLabel.TextXAlignment = Enum.TextXAlignment.Left
            headerLabel.Parent = tabFrame  -- Dodajemy do tabFrame

            -- Minimalna przestrzeń po nagłówku
            local spacer = Instance.new("Frame")
            spacer.Size = UDim2.new(1, 0, 0, 5)  -- Zmniejszona przestrzeń
            spacer.BackgroundTransparency = 1
            spacer.Parent = tabFrame
        end

        table.insert(tabs, tab)

        -- Jeśli to pierwszy tab -> automatycznie włącz
        if not firstTab then
            firstTab = tabFrame
            task.defer(function()
                tabButton:FireMouseButton1Click()
            end)
        end

        return tab
    end

    return window
end

return Library
