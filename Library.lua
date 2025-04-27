local Library = {}

local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

function Library:CreateWindow(config)
    local existingGui = PlayerGui:FindFirstChild(config.Name or "MyLibraryUI")
    if existingGui then
        existingGui:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = config.Name or "MyLibraryUI"
    screenGui.Parent = PlayerGui

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

    local tabContentHolder = Instance.new("Frame")
    tabContentHolder.Size = UDim2.new(1, -20, 1, -100)
    tabContentHolder.Position = UDim2.new(0, 10, 0, 100)
    tabContentHolder.BackgroundTransparency = 1
    tabContentHolder.Parent = mainFrame

    local tabs = {}
    local firstTab = nil

    local window = {}

    -- Create Tab with categories
    function window:CreateTab(tabName)
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

        -- Create tab content scrolling frame
        local tabFrame = Instance.new("ScrollingFrame")
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabFrame.ScrollBarThickness = 5
        tabFrame.ScrollingDirection = Enum.ScrollingDirection.Y
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false
        tabFrame.Parent = tabContentHolder
        tabFrame.ClipsDescendants = true

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

        -- Create Button with category
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

            -- Hover effect
            button.MouseEnter:Connect(function()
                button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            end)
            button.MouseLeave:Connect(function()
                button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            end)

            button.MouseButton1Click:Connect(function()
                callback()
                Library:CreateNotification("Action executed!", "green")
            end)

            -- Update Scroll Size
            layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                tabFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
            end)
        end

        table.insert(tabs, tab)

        if not firstTab then
            firstTab = tabFrame
            task.defer(function()
                tabButton:FireMouseButton1Click()
            end)
        end

        return tab
    end

    -- Slider, Checkbox, InputBox Functions
    function window:CreateSlider(label, min, max, callback)
    -- Slider Frame
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -20, 0, 60)
    sliderFrame.Position = UDim2.new(0, 10, 0, 0)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sliderFrame.Parent = tabFrame

    -- Label for Slider
    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Size = UDim2.new(1, 0, 0, 20)
    sliderLabel.Position = UDim2.new(0, 0, 0, 0)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = label
    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderLabel.TextSize = 16
    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    sliderLabel.Parent = sliderFrame

    -- Slider Bar
    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1, 0, 0, 5)
    sliderBar.Position = UDim2.new(0, 0, 0, 25)
    sliderBar.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    sliderBar.Parent = sliderFrame

    -- Slider Indicator
    local sliderIndicator = Instance.new("Frame")
    sliderIndicator.Size = UDim2.new(0, 20, 0, 20)
    sliderIndicator.Position = UDim2.new(0, 0, 0, -7)
    sliderIndicator.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    sliderIndicator.AnchorPoint = Vector2.new(0.5, 0.5)
    sliderIndicator.Parent = sliderBar

    -- Mouse Input for Slider
    local dragging = false
    sliderIndicator.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    sliderIndicator.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging then
            local newX = math.clamp(input.Position.X - sliderBar.AbsolutePosition.X, 0, sliderBar.AbsoluteSize.X)
            sliderIndicator.Position = UDim2.new(0, newX, 0, -7)
            local value = math.floor((newX / sliderBar.AbsoluteSize.X) * (max - min) + min)
            callback(value)
        end
    end)
end

function window:CreateCheckbox(label, default, callback)
    -- Checkbox Frame
    local checkboxFrame = Instance.new("Frame")
    checkboxFrame.Size = UDim2.new(1, -20, 0, 40)
    checkboxFrame.Position = UDim2.new(0, 10, 0, 0)
    checkboxFrame.BackgroundTransparency = 1
    checkboxFrame.Parent = tabFrame

    -- Label for Checkbox
    local checkboxLabel = Instance.new("TextLabel")
    checkboxLabel.Size = UDim2.new(1, 0, 0, 20)
    checkboxLabel.Position = UDim2.new(0, 0, 0, 0)
    checkboxLabel.BackgroundTransparency = 1
    checkboxLabel.Text = label
    checkboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    checkboxLabel.TextSize = 16
    checkboxLabel.TextXAlignment = Enum.TextXAlignment.Left
    checkboxLabel.Parent = checkboxFrame

    -- Checkbox Button
    local checkboxButton = Instance.new("TextButton")
    checkboxButton.Size = UDim2.new(0, 20, 0, 20)
    checkboxButton.Position = UDim2.new(0, 180, 0, 10)
    checkboxButton.BackgroundColor3 = default and Color3.fromRGB(70, 255, 70) or Color3.fromRGB(255, 70, 70)
    checkboxButton.Text = ""
    checkboxButton.Parent = checkboxFrame

    local checkboxButtonCorner = Instance.new("UICorner")
    checkboxButtonCorner.CornerRadius = UDim.new(0, 5)
    checkboxButtonCorner.Parent = checkboxButton

    -- Checkbox Click Event
    checkboxButton.MouseButton1Click:Connect(function()
        default = not default
        checkboxButton.BackgroundColor3 = default and Color3.fromRGB(70, 255, 70) or Color3.fromRGB(255, 70, 70)
        callback(default)
    end)
end

function window:CreateInputBox(label, callback)
    -- Input Box Frame
    local inputBoxFrame = Instance.new("Frame")
    inputBoxFrame.Size = UDim2.new(1, -20, 0, 60)
    inputBoxFrame.Position = UDim2.new(0, 10, 0, 0)
    inputBoxFrame.BackgroundTransparency = 1
    inputBoxFrame.Parent = tabFrame

    -- Label for Input Box
    local inputBoxLabel = Instance.new("TextLabel")
    inputBoxLabel.Size = UDim2.new(1, 0, 0, 20)
    inputBoxLabel.Position = UDim2.new(0, 0, 0, 0)
    inputBoxLabel.BackgroundTransparency = 1
    inputBoxLabel.Text = label
    inputBoxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBoxLabel.TextSize = 16
    inputBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
    inputBoxLabel.Parent = inputBoxFrame

    -- Input Box Field
    local inputBoxField = Instance.new("TextBox")
    inputBoxField.Size = UDim2.new(1, 0, 0, 30)
    inputBoxField.Position = UDim2.new(0, 0, 0, 25)
    inputBoxField.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    inputBoxField.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBoxField.TextSize = 16
    inputBoxField.ClearTextOnFocus = false
    inputBoxField.PlaceholderText = "Enter text here"
    inputBoxField.Text = ""
    inputBoxField.Parent = inputBoxFrame

    local inputBoxCorner = Instance.new("UICorner")
    inputBoxCorner.CornerRadius = UDim.new(0, 5)
    inputBoxCorner.Parent = inputBoxField

    -- Input Box Text Change Event
    inputBoxField.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(inputBoxField.Text)
        end
    end)
end

    -- Notification Function
    function Library:CreateNotification(text, color)
        local notification = Instance.new("TextLabel")
        notification.Size = UDim2.new(0, 200, 0, 50)
        notification.Position = UDim2.new(0.5, -100, 0.9, 0)
        notification.BackgroundColor3 = color or Color3.fromRGB(255, 0, 0)
        notification.Text = text
        notification.TextColor3 = Color3.fromRGB(255, 255, 255)
        notification.TextSize = 18
        notification.Parent = screenGui

        game:GetService("TweenService"):Create(notification, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -100, 0.8, 0)}):Play()
        task.delay(2, function()
            notification:TweenPosition(UDim2.new(0.5, -100, 0.9, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
            task.delay(0.5, function()
                notification:Destroy()
            end)
        end)
    end

    return window
end

return Library
