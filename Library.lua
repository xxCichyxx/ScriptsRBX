local Library = {}

local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

function Library:CreateWindow(config)
    local existingGui = PlayerGui:FindFirstChild(config.Name or "MyLibraryUI")
    local mainFrame, screenGui, firstTab, tabContentHolder
    local initialPosition
    local savedTabs = {} -- Lista do przechowywania utworzonych tabów

    -- Tworzymy GUI tylko, jeśli nie istnieje w PlayerGui
    if existingGui then
        existingGui:Destroy() -- Upewniamy się, że nie ma starego GUI
    end

    -- Tworzymy nowe GUI
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = config.Name or "MyLibraryUI"
    screenGui.Parent = PlayerGui

    -- Główne okno
    mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainFrame

    -- Pasek tytułowy
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
    tabContentHolder = Instance.new("Frame")
    tabContentHolder.Size = UDim2.new(1, -20, 1, -100)
    tabContentHolder.Position = UDim2.new(0, 10, 0, 100)
    tabContentHolder.BackgroundTransparency = 1
    tabContentHolder.Parent = mainFrame

    local tabs = {}
    firstTab = nil

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

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 5)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = tabFrame

        -- Przełączenie widoczności tabów po kliknięciu przycisku
        tabButton.MouseButton1Click:Connect(function()
            -- Ukrywamy wszystkie taby
            for _, v in pairs(tabContentHolder:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            -- Pokazujemy kliknięty tab
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

        table.insert(tabs, tab)

        -- Jeśli to pierwszy tab -> automatycznie włącz
        if not firstTab then
            firstTab = tabFrame
            -- Ustawiamy widoczność pierwszego taba na true
            tabFrame.Visible = true
        end

        return tab
    end

    -- Funkcja do zamykania/otwierania menu
    local isMenuOpen = true

    local function toggleMenu()
        if isMenuOpen then
            -- Animacja ukrywania
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -200, 0.5, 500)}):Play()
        else
            -- Animacja pokazywania
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -200, 0.5, -175)}):Play()
        end
        isMenuOpen = not isMenuOpen
    end

    -- Sprawdzamy czy naciśnięto klawisz 'N' do otwarcia/zamykania menu
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.N then
            toggleMenu()
        end
    end)

    -- Funkcja monitorująca zniknięcie menu i ponowne tworzenie
    initialPosition = mainFrame.Position

    RunService.Heartbeat:Connect(function()
        if not PlayerGui:FindFirstChild(config.Name or "MyLibraryUI") then
            -- Jeśli GUI zostało usunięte, przywróć je
            local newWindow = Library:CreateWindow(config)

            -- Przywracamy zapisane taby
            for _, tab in pairs(savedTabs) do
                local newTab = newWindow:CreateTab(tab.name)
                for _, buttonData in pairs(tab.buttons) do
                    newTab:CreateButton(buttonData.text, buttonData.callback)
                end
            end

            -- Sprawdzamy, czy `mainFrame` został stworzony poprawnie przed przypisaniem pozycji
            if newWindow.mainFrame then
                newWindow.mainFrame.Position = initialPosition
            end
        end
    end)

    return window
end

return Library
