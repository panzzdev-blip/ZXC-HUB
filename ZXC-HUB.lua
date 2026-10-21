--[[
    ███████╗██╗  ██╗ ██████╗    ██╗  ██╗██╗   ██╗██████╗
    ╚══███╔╝╚██╗██╔╝██╔════╝    ██║  ██║██║   ██║██╔══██╗
      ███╔╝  ╚███╔╝ ██║         ███████║██║   ██║██████╔╝
     ███╔╝   ██╔██╗ ██║         ██╔══██║██║   ██║██╔══██╗
    ███████╗██╔╝ ██╗╚██████╗    ██║  ██║╚██████╔╝██████╔╝
    ╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝

    ZXC HUB v12.3.8
    Ultimate Performance Edition
    UI Framework: Native Roblox Lua
]]

--==================================================
-- SERVICES
--==================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIGURATION
--==================================================

local CONFIG = {
    Name = "ZXC HUB",
    Version = "12.3.8",
    FPSUpdateRate = 0.5,
    DefaultFOV = 70,
}

local COLORS = {
    Background = Color3.fromRGB(8, 11, 19),
    Sidebar = Color3.fromRGB(12, 17, 29),
    Panel = Color3.fromRGB(17, 24, 39),
    Card = Color3.fromRGB(23, 32, 50),
    Accent = Color3.fromRGB(0, 145, 255),
    Cyan = Color3.fromRGB(0, 220, 255),
    White = Color3.fromRGB(240, 246, 255),
    Muted = Color3.fromRGB(137, 153, 178),
    Green = Color3.fromRGB(66, 255, 163),
    Red = Color3.fromRGB(255, 91, 112),
}

--==================================================
-- CLEANUP
--==================================================

local Previous = PlayerGui:FindFirstChild("ZXC_HUB_1238")

if Previous then
    Previous:Destroy()
end

--==================================================
-- STATE
--==================================================

local State = {
    Visible = true,
    Minimized = false,
    LowGraphics = false,
    ReduceEffects = false,
    FPSMonitor = true,
    CurrentTab = "Performance",
    FOV = CONFIG.DefaultFOV,
}

local Connections = {}
local OriginalLighting = {
    GlobalShadows = Lighting.GlobalShadows,
    FogEnd = Lighting.FogEnd,
}

local OriginalEffects = {}

local function Track(connection)
    table.insert(Connections, connection)
    return connection
end

local function Tween(object, duration, properties)
    local animation = TweenService:Create(
        object,
        TweenInfo.new(
            duration,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        properties
    )

    animation:Play()
    return animation
end

--==================================================
-- GUI ROOT
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "ZXC_HUB_1238"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = false
Gui.DisplayOrder = 100
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

--==================================================
-- MAIN WINDOW
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.Size = UDim2.new(0.88, 0, 0.75, 0)
Main.BackgroundColor3 = COLORS.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Gui

local SizeConstraint = Instance.new("UISizeConstraint")
SizeConstraint.MinSize = Vector2.new(280, 320)
SizeConstraint.MaxSize = Vector2.new(520, 650)
SizeConstraint.Parent = Main

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = COLORS.Accent
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.2
MainStroke.Parent = Main

--==================================================
-- HEADER
--==================================================

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 76)
Header.BackgroundColor3 = COLORS.Sidebar
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header

local Logo = Instance.new("TextLabel")
Logo.Name = "Logo"
Logo.Position = UDim2.new(0, 16, 0, 10)
Logo.Size = UDim2.new(1, -105, 0, 32)
Logo.BackgroundTransparency = 1
Logo.Text = "ZXC HUB"
Logo.TextColor3 = COLORS.Cyan
Logo.TextSize = 25
Logo.Font = Enum.Font.GothamBlack
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.Parent = Header

local Version = Instance.new("TextLabel")
Version.Position = UDim2.new(0, 17, 0, 44)
Version.Size = UDim2.new(1, -110, 0, 18)
Version.BackgroundTransparency = 1
Version.Text = "ULTIMATE EDITION  •  v" .. CONFIG.Version
Version.TextColor3 = COLORS.Muted
Version.TextSize = 9
Version.Font = Enum.Font.GothamBold
Version.TextXAlignment = Enum.TextXAlignment.Left
Version.Parent = Header

local Minimize = Instance.new("TextButton")
Minimize.Name = "Minimize"
Minimize.Position = UDim2.new(1, -79, 0, 17)
Minimize.Size = UDim2.fromOffset(28, 30)
Minimize.BackgroundColor3 = COLORS.Card
Minimize.Text = "−"
Minimize.TextColor3 = COLORS.White
Minimize.TextSize = 22
Minimize.Font = Enum.Font.GothamBold
Minimize.Parent = Header

Instance.new("UICorner", Minimize).CornerRadius =
    UDim.new(0, 8)

local Close = Instance.new("TextButton")
Close.Name = "Close"
Close.Position = UDim2.new(1, -43, 0, 17)
Close.Size = UDim2.fromOffset(28, 30)
Close.BackgroundColor3 = Color3.fromRGB(65, 24, 39)
Close.Text = "×"
Close.TextColor3 = COLORS.Red
Close.TextSize = 22
Close.Font = Enum.Font.GothamBold
Close.Parent = Header

Instance.new("UICorner", Close).CornerRadius =
    UDim.new(0, 8)

--==================================================
-- FPS DISPLAY
--==================================================

local FPSCard = Instance.new("Frame")
FPSCard.Name = "FPSCard"
FPSCard.Position = UDim2.new(0, 12, 0, 86)
FPSCard.Size = UDim2.new(1, -24, 0, 62)
FPSCard.BackgroundColor3 = COLORS.Panel
FPSCard.BorderSizePixel = 0
FPSCard.Parent = Main

Instance.new("UICorner", FPSCard).CornerRadius =
    UDim.new(0, 12)

local FPSTitle = Instance.new("TextLabel")
FPSTitle.Position = UDim2.new(0, 12, 0, 8)
FPSTitle.Size = UDim2.new(0.6, 0, 0, 16)
FPSTitle.BackgroundTransparency = 1
FPSTitle.Text = "LIVE FPS"
FPSTitle.TextColor3 = COLORS.Muted
FPSTitle.TextSize = 10
FPSTitle.Font = Enum.Font.GothamBold
FPSTitle.TextXAlignment = Enum.TextXAlignment.Left
FPSTitle.Parent = FPSCard

local FPSValue = Instance.new("TextLabel")
FPSValue.Position = UDim2.new(0, 12, 0, 25)
FPSValue.Size = UDim2.new(0.6, 0, 0, 28)
FPSValue.BackgroundTransparency = 1
FPSValue.Text = "--"
FPSValue.TextColor3 = COLORS.Green
FPSValue.TextSize = 24
FPSValue.Font = Enum.Font.GothamBlack
FPSValue.TextXAlignment = Enum.TextXAlignment.Left
FPSValue.Parent = FPSCard

local FPSUnit = Instance.new("TextLabel")
FPSUnit.Position = UDim2.new(0, 72, 0, 32)
FPSUnit.Size = UDim2.fromOffset(45, 17)
FPSUnit.BackgroundTransparency = 1
FPSUnit.Text = "FPS"
FPSUnit.TextColor3 = COLORS.Muted
FPSUnit.TextSize = 11
FPSUnit.Font = Enum.Font.GothamBold
FPSUnit.TextXAlignment = Enum.TextXAlignment.Left
FPSUnit.Parent = FPSCard

local FPSStatus = Instance.new("TextLabel")
FPSStatus.AnchorPoint = Vector2.new(1, 0.5)
FPSStatus.Position = UDim2.new(1, -12, 0.5, 0)
FPSStatus.Size = UDim2.new(0.38, 0, 0, 22)
FPSStatus.BackgroundTransparency = 1
FPSStatus.Text = "● MONITORING"
FPSStatus.TextColor3 = COLORS.Green
FPSStatus.TextSize = 9
FPSStatus.Font = Enum.Font.GothamBold
FPSStatus.TextXAlignment = Enum.TextXAlignment.Right
FPSStatus.Parent = FPSCard

--==================================================
-- TAB BAR
--==================================================

local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Position = UDim2.new(0, 12, 0, 157)
TabBar.Size = UDim2.new(1, -24, 0, 38)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabLayout.Padding = UDim.new(0, 5)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Parent = TabBar

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("ScrollingFrame")
Content.Name = "Content"
Content.Position = UDim2.new(0, 12, 0, 202)
Content.Size = UDim2.new(1, -24, 1, -240)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 = COLORS.Accent
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.Parent = Main

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 9)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = Content

--==================================================
-- UI HELPERS
--==================================================

local function ClearContent()
    for _, child in ipairs(Content:GetChildren()) do
        if child ~= ContentLayout then
            child:Destroy()
        end
    end
end

local function CreateSection(text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -4, 0, 24)
    Label.BackgroundTransparency = 1
    Label.Text = string.upper(text)
    Label.TextColor3 = COLORS.Cyan
    Label.TextSize = 11
    Label.Font = Enum.Font.GothamBlack
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Content

    return Label
end

local function CreateButton(title, description, callback)
    local Button = Instance.new("TextButton")
    Button.Name = title:gsub("%W", "") .. "Button"
    Button.Size = UDim2.new(1, -4, 0, 57)
    Button.BackgroundColor3 = COLORS.Card
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = Content

    Instance.new("UICorner", Button).CornerRadius =
        UDim.new(0, 10)

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = COLORS.Accent
    Stroke.Thickness = 1
    Stroke.Transparency = 0.85
    Stroke.Parent = Button

    local Name = Instance.new("TextLabel")
    Name.Position = UDim2.new(0, 12, 0, 7)
    Name.Size = UDim2.new(1, -90, 0, 21)
    Name.BackgroundTransparency = 1
    Name.Text = title
    Name.TextColor3 = COLORS.White
    Name.TextSize = 12
    Name.Font = Enum.Font.GothamBold
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.Parent = Button

    local Description = Instance.new("TextLabel")
    Description.Position = UDim2.new(0, 12, 0, 29)
    Description.Size = UDim2.new(1, -24, 0, 18)
    Description.BackgroundTransparency = 1
    Description.Text = description
    Description.TextColor3 = COLORS.Muted
    Description.TextSize = 9
    Description.Font = Enum.Font.Gotham
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.TextTruncate = Enum.TextTruncate.AtEnd
    Description.Parent = Button

    local Indicator = Instance.new("TextLabel")
    Indicator.AnchorPoint = Vector2.new(1, 0.5)
    Indicator.Position = UDim2.new(1, -12, 0.5, 0)
    Indicator.Size = UDim2.fromOffset(20, 25)
    Indicator.BackgroundTransparency = 1
    Indicator.Text = "›"
    Indicator.TextColor3 = COLORS.Cyan
    Indicator.TextSize = 23
    Indicator.Font = Enum.Font.GothamBold
    Indicator.Parent = Button

    Track(Button.Activated:Connect(function()
        Tween(Button, 0.12, {
            BackgroundColor3 = COLORS.Panel
        })

        task.delay(0.15, function()
            if Button.Parent then
                Tween(Button, 0.15, {
                    BackgroundColor3 = COLORS.Card
                })
            end
        end)

        local success, err = pcall(callback)

        if not success then
            warn("[ZXC HUB] " .. tostring(err))
        end
    end))

    return Button
end

local function CreateToggle(title, description, initial, callback)
    local enabled = initial

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -4, 0, 57)
    Button.BackgroundColor3 = COLORS.Card
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = Content

    Instance.new("UICorner", Button).CornerRadius =
        UDim.new(0, 10)

    local Name = Instance.new("TextLabel")
    Name.Position = UDim2.new(0, 12, 0, 7)
    Name.Size = UDim2.new(1, -90, 0, 21)
    Name.BackgroundTransparency = 1
    Name.Text = title
    Name.TextColor3 = COLORS.White
    Name.TextSize = 12
    Name.Font = Enum.Font.GothamBold
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.Parent = Button

    local Desc = Instance.new("TextLabel")
    Desc.Position = UDim2.new(0, 12, 0, 29)
    Desc.Size = UDim2.new(1, -90, 0, 18)
    Desc.BackgroundTransparency = 1
    Desc.Text = description
    Desc.TextColor3 = COLORS.Muted
    Desc.TextSize = 9
    Desc.Font = Enum.Font.Gotham
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextTruncate = Enum.TextTruncate.AtEnd
    Desc.Parent = Button

    local Switch = Instance.new("Frame")
    Switch.AnchorPoint = Vector2.new(1, 0.5)
    Switch.Position = UDim2.new(1, -12, 0.5, 0)
    Switch.Size = UDim2.fromOffset(38, 21)
    Switch.BackgroundColor3 = enabled and COLORS.Accent
        or COLORS.Sidebar
    Switch.BorderSizePixel = 0
    Switch.Parent = Button

    Instance.new("UICorner", Switch).CornerRadius =
        UDim.new(1, 0)

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.fromOffset(15, 15)
    Knob.Position = enabled
        and UDim2.new(1, -18, 0.5, 0)
        or UDim2.new(0, 3, 0.5, 0)
    Knob.AnchorPoint = Vector2.new(0, 0.5)
    Knob.BackgroundColor3 = COLORS.White
    Knob.BorderSizePixel = 0
    Knob.Parent = Switch

    Instance.new("UICorner", Knob).CornerRadius =
        UDim.new(1, 0)

    local function Refresh()
        Tween(Switch, 0.15, {
            BackgroundColor3 = enabled
                and COLORS.Accent
                or COLORS.Sidebar
        })

        Tween(Knob, 0.15, {
            Position = enabled
                and UDim2.new(1, -18, 0.5, 0)
                or UDim2.new(0, 3, 0.5, 0)
        })
    end

    Track(Button.Activated:Connect(function()
        enabled = not enabled
        Refresh()
        callback(enabled)
    end))

    return {
        Button = Button,

        Get = function()
            return enabled
        end,

        Set = function(value)
            enabled = value
            Refresh()
            callback(enabled)
        end
    }
end

--==================================================
-- PERFORMANCE FEATURES
--==================================================

local function SetLowGraphics(enabled)
    State.LowGraphics = enabled

    if enabled then
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 100000
    else
        Lighting.GlobalShadows =
            OriginalLighting.GlobalShadows

        Lighting.FogEnd = OriginalLighting.FogEnd
    end
end

local function SetReduceEffects(enabled)
    State.ReduceEffects = enabled

    if enabled then
        table.clear(OriginalEffects)

        for _, object in ipairs(game:GetDescendants()) do
            if object:IsA("ParticleEmitter")
                or object:IsA("Trail")
                or object:IsA("Beam") then

                OriginalEffects[object] = object.Enabled
                object.Enabled = false
            end
        end
    else
        for object, wasEnabled in pairs(OriginalEffects) do
            if object and object.Parent then
                pcall(function()
                    object.Enabled = wasEnabled
                end)
            end
        end

        table.clear(OriginalEffects)
    end
end

--==================================================
-- TAB SYSTEM
--==================================================

local RenderTab

local function CreateTab(name, order)
    local Button = Instance.new("TextButton")
    Button.Name = name .. "Tab"
    Button.LayoutOrder = order
    Button.Size = UDim2.new(0.333, -5, 1, 0)
    Button.BackgroundColor3 = COLORS.Panel
    Button.BorderSizePixel = 0
    Button.Text = name
    Button.TextColor3 = COLORS.Muted
    Button.TextSize = 10
    Button.Font = Enum.Font.GothamBold
    Button.AutoButtonColor = false
    Button.Parent = TabBar

    Instance.new("UICorner", Button).CornerRadius =
        UDim.new(0, 8)

    Track(Button.Activated:Connect(function()
        State.CurrentTab = name
        RenderTab(name)
    end))

    return Button
end

local PerformanceTab = CreateTab("Performance", 1)
local VisualTab = CreateTab("Visual", 2)
local AboutTab = CreateTab("About", 3)

local function UpdateTabs(active)
    local tabs = {
        Performance = PerformanceTab,
        Visual = VisualTab,
        About = AboutTab
    }

    for name, button in pairs(tabs) do
        local selected = name == active

        Tween(button, 0.15, {
            BackgroundColor3 = selected
                and COLORS.Accent
                or COLORS.Panel
        })

        button.TextColor3 = selected
            and COLORS.White
            or COLORS.Muted
    end
end

--==================================================
-- TAB CONTENT
--==================================================

RenderTab = function(tab)
    ClearContent()
    UpdateTabs(tab)

    if tab == "Performance" then
        CreateSection("Performance Control")

        CreateToggle(
            "Low Graphics",
            "Disable local shadows and adjust fog",
            State.LowGraphics,
            SetLowGraphics
        )

        CreateToggle(
            "Reduce Effects",
            "Disable selected particles, trails and beams",
            State.ReduceEffects,
            SetReduceEffects
        )

        CreateToggle(
            "FPS Monitor",
            "Show live client frame-rate estimate",
            State.FPSMonitor,
            function(enabled)
                State.FPSMonitor = enabled
                FPSValue.Visible = enabled
                FPSUnit.Visible = enabled
                FPSStatus.Text = enabled
                    and "● MONITORING"
                    or "● PAUSED"

                FPSStatus.TextColor3 = enabled
                    and COLORS.Green
                    or COLORS.Muted
            end
        )

        CreateButton(
            "Refresh Character",
            "Reload your character if the game permits",
            function()
                Player:LoadCharacter()
            end
        )

    elseif tab == "Visual" then
        CreateSection("Camera Settings")

        CreateButton(
            "FOV +10",
            "Increase local camera field of view",
            function()
                local camera = workspace.CurrentCamera

                if camera then
                    State.FOV = math.clamp(
                        State.FOV + 10, 40, 100
                    )

                    camera.FieldOfView = State.FOV
                end
            end
        )

        CreateButton(
            "FOV -10",
            "Decrease local camera field of view",
            function()
                local camera = workspace.CurrentCamera

                if camera then
                    State.FOV = math.clamp(
                        State.FOV - 10, 40, 100
                    )

                    camera.FieldOfView = State.FOV
                end
            end
        )

        CreateButton(
            "Reset Camera",
            "Restore default camera field of view",
            function()
                State.FOV = CONFIG.DefaultFOV

                local camera = workspace.CurrentCamera

                if camera then
                    camera.FieldOfView = CONFIG.DefaultFOV
                end
            end
        )

        CreateSection("Visual Information")

        CreateButton(
            "Current Camera",
            "Display the current camera field of view",
            function()
                local camera = workspace.CurrentCamera

                if camera then
                    print(
                        "[ZXC HUB] Camera FOV:",
                        camera.FieldOfView
                    )
                end
            end
        )

    elseif tab == "About" then
        CreateSection("ZXC HUB Information")

        CreateButton(
            "Version 12.3.8",
            "Ultimate Performance Edition",
            function()
                print("[ZXC HUB] Version " .. CONFIG.Version)
            end
        )

        CreateButton(
            "Supported Environment",
            "Roblox client APIs available to this script",
            function()
                print("[ZXC HUB] Running on Roblox client")
            end
        )

        CreateButton(
            "Restore Settings",
            "Restore lighting and camera defaults",
            function()
                SetLowGraphics(false)
                SetReduceEffects(false)

                State.FOV = CONFIG.DefaultFOV

                local camera = workspace.CurrentCamera

                if camera then
                    camera.FieldOfView = CONFIG.DefaultFOV
                end
            end
        )

        CreateSection("Important Notes")

        local Info = Instance.new("TextLabel")
        Info.Size = UDim2.new(1, -4, 0, 74)
        Info.BackgroundColor3 = COLORS.Card
        Info.BorderSizePixel = 0
        Info.Text =
            "ZXC HUB is a client-side interface. " ..
            "FPS improvements depend on your device and game. " ..
            "Some settings cannot affect server-side behavior."
        Info.TextColor3 = COLORS.Muted
        Info.TextSize = 11
        Info.Font = Enum.Font.Gotham
        Info.TextWrapped = true
        Info.Parent = Content

        Instance.new("UICorner", Info).CornerRadius =
            UDim.new(0, 10)
    end
end

--==================================================
-- DRAG WINDOW
--==================================================

local dragging = false
local dragInput
local dragStart
local startPosition

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState ==
                Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        dragInput = input
    end
end)

Track(UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end))

--==================================================
-- MINIMIZE / CLOSE
--==================================================

Minimize.Activated:Connect(function()
    State.Minimized = not State.Minimized

    if State.Minimized then
        Tween(Main, 0.2, {
            Size = UDim2.new(0.88, 0, 0, 76)
        })

        Content.Visible = false
        TabBar.Visible = false
        FPSCard.Visible = false
        Minimize.Text = "+"
    else
        Tween(Main, 0.2, {
            Size = UDim2.new(0.88, 0, 0.75, 0)
        })

        Content.Visible = true
        TabBar.Visible = true
        FPSCard.Visible = true
        Minimize.Text = "−"
    end
end)

Close.Activated:Connect(function()
    for _, connection in ipairs(Connections) do
        pcall(function()
            connection:Disconnect()
        end)
    end

    SetLowGraphics(false)
    SetReduceEffects(false)
    Gui:Destroy()
end)

--==================================================
-- FPS MONITOR
--==================================================

local frameCount = 0
local elapsed = 0

Track(RunService.RenderStepped:Connect(function(deltaTime)
    if not State.FPSMonitor or not Gui.Parent then
        return
    end

    frameCount += 1
    elapsed += deltaTime

    if elapsed >= CONFIG.FPSUpdateRate then
        local fps = math.floor(frameCount / elapsed)

        FPSValue.Text = tostring(fps)

        if fps >= 50 then
            FPSValue.TextColor3 = COLORS.Green
        elseif fps >= 30 then
            FPSValue.TextColor3 = COLORS.Cyan
        else
            FPSValue.TextColor3 = COLORS.Red
        end

        frameCount = 0
        elapsed = 0
    end
end))

--==================================================
-- INITIALIZE
--==================================================

RenderTab("Performance")

Tween(Main, 0.35, {
    BackgroundTransparency = 0
})

print("================================")
print("       ZXC HUB v12.3.8")
print("  Ultimate Performance Edition")
print("       Successfully Loaded")
print("================================")
