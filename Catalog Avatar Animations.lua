--[[
Animacje posegregowane po kategoriach:
Walk, Run, Idle, Jump, Fall, Swim, Climb
Menu toggle, drag, toggle pod M
Animacje odtwarzane tylko podczas ruchu
Po śmierci animacje się wczytują z powrotem jeśli były włączone
]]

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local userInput = game:GetService("UserInputService")
local runService = game:GetService("RunService")

-- Lista animacji z przykładowymi ID i kategoriami (wklej swoje animacje tutaj)
local animationsData = {
    -- Walk
    {Name="Confident Walk", Id="rbxassetid://131484850111972", Category="Walk"},
    {Name="Rollerblading Walk", Id="rbxassetid://84716488243415", Category="Walk"},
    {Name="Sneaky Walk", Id="rbxassetid://76437363984905", Category="Walk"},
    {Name="Wide Step Walk", Id="rbxassetid://94561001455949", Category="Walk"},
    -- Run
    {Name="Skating Run", Id="rbxassetid://121752094901886", Category="Run"},
    {Name="Animal Run", Id="rbxassetid://134367868832429", Category="Run"},
    {Name="Goofy Run", Id="rbxassetid://81856419768731", Category="Run"},
    {Name="Busy Run", Id="rbxassetid://131253192760707", Category="Run"},
    -- Idle
    {Name="Grooving Idle", Id="rbxassetid://97331965888047", Category="Idle"},
    {Name="Main Character Idle", Id="rbxassetid://93786252227118", Category="Idle"},
    {Name="Mech Hover Idle", Id="rbxassetid://72961981611136", Category="Idle"},
    {Name="Twirl Idle", Id="rbxassetid://108753414496165", Category="Idle"},
    -- Jump
    {Name="Heel Click Jump", Id="rbxassetid://88280575875870", Category="Jump"},
    {Name="Karate Kick Jump", Id="rbxassetid://89572325456925", Category="Jump"},
    {Name="Spin Jump", Id="rbxassetid://91171578413331", Category="Jump"},
    {Name="Star Jump", Id="rbxassetid://78672681774138", Category="Jump"},
    -- Fall
    {Name="Velocity Dive Fall", Id="rbxassetid://120501543724366", Category="Fall"},
    {Name="Spin Fall", Id="rbxassetid://79564456347137", Category="Fall"},
    {Name="Free fall", Id="rbxassetid://139534974770329", Category="Fall"},
    -- Swim
    {Name="Backstroke Swim", Id="rbxassetid://128573701026158", Category="Swim"},
    {Name="Demure Swim", Id="rbxassetid://78501103128048", Category="Swim"},
    {Name="T-pose Swim", Id="rbxassetid://126023385214025", Category="Swim"},
    {Name="Mermaid Swim", Id="rbxassetid://136983943791538", Category="Swim"},
    -- Climb
    {Name="Float Climb", Id="rbxassetid://73924343992153", Category="Climb"},
    {Name="Fold Climb", Id="rbxassetid://98255792426801", Category="Climb"},
    {Name="Wall Walk Climb", Id="rbxassetid://85176970586818", Category="Climb"},
    {Name="Bouldering Climb", Id="rbxassetid://118050475384620", Category="Climb"},
}

-- Przechowuje toggle i animacje
local toggles = {}
local tracks = {}
local playing = {}

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AnimationsCatalogGui"
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = false -- Będziemy robić własny drag system
MainFrame.Parent = ScreenGui

-- Tytuł
local Title = Instance.new("TextLabel")
Title.Text = "Animations Catalog Avatar Creator"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = MainFrame

-- ScrollFrame do listy animacji
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 1, -50)
Scroll.Position = UDim2.new(0, 10, 0, 45)
Scroll.CanvasSize = UDim2.new(0, 0, 3, 0)
Scroll.ScrollBarThickness = 8
Scroll.BackgroundTransparency = 0.5
Scroll.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Scroll.Parent = MainFrame

-- Layout pionowy
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = Scroll

-- Funkcja tworząca kategorię + jej animacje w ScrollFrame
local function createCategory(categoryName, anims)
    local categoryLabel = Instance.new("TextLabel")
    categoryLabel.Text = categoryName
    categoryLabel.Font = Enum.Font.GothamBold
    categoryLabel.TextSize = 18
    categoryLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    categoryLabel.BackgroundTransparency = 1
    categoryLabel.Size = UDim2.new(1, 0, 0, 30)
    categoryLabel.Parent = Scroll

    for _, animData in pairs(anims) do
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 35)
        frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        frame.Parent = Scroll

        local label = Instance.new("TextLabel")
        label.Text = animData.Name
        label.Font = Enum.Font.Gotham
        label.TextSize = 16
        label.TextColor3 = Color3.fromRGB(230, 230, 230)
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.Parent = frame

        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Text = "OFF"
        toggleBtn.Font = Enum.Font.GothamBold
        toggleBtn.TextSize = 14
        toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        toggleBtn.Size = UDim2.new(0.25, -15, 0.7, 0)
        toggleBtn.Position = UDim2.new(0.75, 0, 0.15, 0)
        toggleBtn.Parent = frame

        toggles[animData.Id] = false

        toggleBtn.MouseButton1Click:Connect(function()
            if toggles[animData.Id] then
                -- Wyłącz animację
                toggleBtn.Text = "OFF"
                toggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
                toggles[animData.Id] = false
                if tracks[animData.Id] then
                    tracks[animData.Id]:Stop()
                    playing[animData.Id] = false
                end
            else
                -- Włącz animację - ale odtwarzaj tylko podczas ruchu (sterowanie ruchem będzie dalej)
                toggleBtn.Text = "ON"
                toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
                toggles[animData.Id] = true
                -- Załaduj animację, ale nie odtwarzaj od razu (uruchomimy ją na ruch)
                if not tracks[animData.Id] then
                    local anim = Instance.new("Animation")
                    anim.AnimationId = animData.Id
                    tracks[animData.Id] = humanoid:LoadAnimation(anim)
                end
            end
        end)
    end
end

-- Grupowanie animacji po kategoriach
local categories = {}
for _, animData in pairs(animationsData) do
    if not categories[animData.Category] then
        categories[animData.Category] = {}
    end
    table.insert(categories[animData.Category], animData)
end

-- Tworzenie GUI dla każdej kategorii
for categoryName, anims in pairs(categories) do
    createCategory(categoryName, anims)
end

-- Toggle widoczności menu pod klawiszem M
local menuVisible = true
local function toggleMenu()
    menuVisible = not menuVisible
    MainFrame.Visible = menuVisible
end

userInput.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.M then
        toggleMenu()
    end
end)

-- Dragging system dla MainFrame
local dragging = false
local dragInput, dragStart, startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

userInput.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- Odtwarzanie animacji podczas ruchu - zatrzymywanie gdy stoi
runService.RenderStepped:Connect(function()
    local speed = humanoid.MoveDirection.Magnitude

    for animId, isToggled in pairs(toggles) do
        if isToggled then
            local track = tracks[animId]
            if speed > 0.1 then
                if track and not playing[animId] then
                    track:Play()
                    playing[animId] = true
                end
            else
                if track and playing[animId] then
                    track:Stop()
                    playing[animId] = false
                end
            end
        else
            -- Jeśli toggle wyłączone, na pewno zatrzymujemy animację
            if tracks[animId] and playing[animId] then
                tracks[animId]:Stop()
                playing[animId] = false
            end
        end
    end
end)

-- Funkcja do odświeżania humanoida i eventów po respawnie
local function refreshHumanoid()
    char = player.Character or player.CharacterAdded:Wait()
    humanoid = char:WaitForChild("Humanoid")

    -- Wczytaj animacje dla aktywnych toggle
    for animId, _ in pairs(toggles) do
        if toggles[animId] then
            local anim = Instance.new("Animation")
            anim.AnimationId = animId
            tracks[animId] = humanoid:LoadAnimation(anim)
        end
    end

    -- Podłącz event śmierci
    humanoid.Died:Connect(function()
        player.CharacterAdded:Wait()
        wait(0.5)
        refreshHumanoid()
    end)
end

-- Inicjuj odświeżanie humanoida i eventów
refreshHumanoid()
