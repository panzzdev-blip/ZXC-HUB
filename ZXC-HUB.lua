--[[
    ZXC HUB v21.0
    NEXUS INFINITY

    Design:
    Cyber + Glass + Dark Pro

    Environment:
    Roblox LocalScript
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIGURATION
--==================================================

local CONFIG = {
    Name = "ZXC HUB",
    Version = "21.0",
    Edition = "NEXUS INFINITY",

    AnimationTime = 0.22,
    LoadingTime = 1.5,

    DefaultFOV = 70,
    MinFOV = 40,
    MaxFOV = 100,
}

local THEME = {
    Background = Color3.fromRGB(7, 9, 15),
    Panel = Color3.fromRGB(13, 17, 27),
    Card = Color3.fromRGB(20, 27, 41),

    Blue = Color3.fromRGB(0, 170, 255),
    Cyan = Color3.fromRGB(65, 220, 255),

    White = Color3.fromRGB(240, 246, 255),
    Muted = Color3.fromRGB(135, 151, 176),

    Green = Color3.fromRGB(55, 220, 145),
    Red = Color3.fromRGB(255, 80, 105),
}

local STATE = {
    Open = true,
    SidebarExpanded = true,

    FPSMonitor = true,
    UIEffects = true,
    SmoothAnimations = true,

    CurrentTab = "Dashboard",
    FOV = CONFIG.DefaultFOV,
}

--==================================================
-- CLEANUP
--==================================================

local Previous = PlayerGui:FindFirstChild("ZXC_NEXUS_INFINITY")

if Previous then
    Previous:Destroy()
end

--==================================================
-- HELPERS
--==================================================

local function Create(className, properties, parent)
    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do
        object[property] = value
    end

    object.Parent = parent

    return object
end

local function AddCorner(object, radius)
    return Create("UICorner", {
        CornerRadius = UDim.new(0, radius),
    }, object)
end

local function AddStroke(object, color, thickness, transparency)
    return Create("UIStroke", {
        Color = color,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
    }, object)
end

local function Tween(object, duration, properties)
    local actualDuration = STATE.SmoothAnimations
        and duration
        or 0

    local tween = TweenService:Create(
        object,
        TweenInfo.new(
            actualDuration,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        properties
    )

    tween:Play()

    return tween
end

local function AddPadding(object, left, top, right, bottom)
    return Create("UIPadding", {
        PaddingLeft = UDim.new(0, left or 0),
        PaddingTop = UDim.new(0, top or 0),
        PaddingRight = UDim.new(0, right or 0),
        PaddingBottom = UDim.new(0, bottom or 0),
    }, object)
end

--==================================================
-- SCREEN GUI
--==================================================

local GUI = Create("ScreenGui", {
    Name = "ZXC_NEXUS_INFINITY",

    ResetOnSpawn = false,
    IgnoreGuiInset = false,
    DisplayOrder = 100,

    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, PlayerGui)

--==================================================
-- LOADING SCREEN
--==================================================

local Loader = Create("Frame", {
    Name = "LoadingScreen",

    Size = UDim2.fromScale(1, 1),

    BackgroundColor3 = THEME.Background,
    BorderSizePixel = 0,

    ZIndex = 100,
}, GUI)

local LoaderPanel = Create("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),

    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(0.84, 0, 0, 235),

    BackgroundColor3 = THEME.Panel,
    BorderSizePixel = 0,

    ZIndex = 101,
}, Loader)

AddCorner(LoaderPanel, 18)
AddStroke(LoaderPanel, THEME.Blue, 1.5)

Create("UISizeConstraint", {
    MinSize = Vector2.new(260, 220),
    MaxSize = Vector2.new(400, 260),
}, LoaderPanel)

local LoaderLogo = Create("TextLabel", {
    Position = UDim2.new(0, 0, 0, 25),
    Size = UDim2.new(1, 0, 0, 48),

    BackgroundTransparency = 1,

    Text = "Z X C",

    TextColor3 = THEME.Cyan,

    Font = Enum.Font.GothamBlack,
    TextSize = 34,

    ZIndex = 102,
}, LoaderPanel)

local LoaderTitle = Create("TextLabel", {
    Position = UDim2.new(0, 0, 0, 75),
    Size = UDim2.new(1, 0, 0, 25),

    BackgroundTransparency = 1,

    Text = "N E X U S   I N F I N I T Y",

    TextColor3 = THEME.White,

    Font = Enum.Font.GothamBold,
    TextSize = 13,

    ZIndex = 102,
}, LoaderPanel)

local LoaderStatus = Create("TextLabel", {
    Position = UDim2.new(0, 15, 0, 120),
    Size = UDim2.new(1, -30, 0, 22),

    BackgroundTransparency = 1,

    Text = "Initializing interface...",

    TextColor3 = THEME.Muted,

    Font = Enum.Font.Gotham,
    TextSize = 11,

    ZIndex = 102,
}, LoaderPanel)

local ProgressBackground = Create("Frame", {
    Position = UDim2.new(0, 20, 0, 153),
    Size = UDim2.new(1, -40, 0, 7),

    BackgroundColor3 = THEME.Card,
    BorderSizePixel = 0,

    ZIndex = 102,
}, LoaderPanel)

AddCorner(ProgressBackground, 5)

local ProgressFill = Create("Frame", {
    Size = UDim2.fromScale(0, 1),

    BackgroundColor3 = THEME.Blue,
    BorderSizePixel = 0,

    ZIndex = 103,
}, ProgressBackground)

AddCorner(ProgressFill, 5)

local ProgressText = Create("TextLabel", {
    Position = UDim2.new(0, 20, 0, 170),
    Size = UDim2.new(1, -40, 0, 20),

    BackgroundTransparency = 1,

    Text = "0%",

    TextColor3 = THEME.Cyan,

    Font = Enum.Font.GothamBold,
    TextSize = 11,

    TextXAlignment = Enum.TextXAlignment.Right,

    ZIndex = 102,
}, LoaderPanel)

local LoaderVersion = Create("TextLabel", {
    Position = UDim2.new(0, 0, 1, -27),
    Size = UDim2.new(1, 0, 0, 16),

    BackgroundTransparency = 1,

    Text = "VERSION 21.0",

    TextColor3 = THEME.Muted,

    Font = Enum.Font.Gotham,
    TextSize = 10,

    ZIndex = 102,
}, LoaderPanel)

--==================================================
-- MAIN WINDOW
--==================================================

local Main = Create("Frame", {
    Name = "MainWindow",

    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),

    Size = UDim2.new(0.94, 0, 0.72, 0),

    BackgroundColor3 = THEME.Background,
    BorderSizePixel = 0,

    Visible = false,

    ClipsDescendants = true,
}, GUI)

AddCorner(Main, 16)
AddStroke(Main, THEME.Blue, 1.2)

Create("UISizeConstraint", {
    MinSize = Vector2.new(280, 300),
    MaxSize = Vector2.new(620, 470),
}, Main)

--==================================================
-- HEADER
--==================================================

local Header = Create("Frame", {
    Name = "Header",

    Size = UDim2.new(1, 0, 0, 54),

    BackgroundColor3 = THEME.Panel,
    BorderSizePixel = 0,
}, Main)

local HeaderAccent = Create("Frame", {
    Position = UDim2.new(0, 0, 1, -2),
    Size = UDim2.new(1, 0, 0, 2),

    BackgroundColor3 = THEME.Blue,
    BorderSizePixel = 0,
}, Header)

local HeaderTitle = Create("TextLabel", {
    Position = UDim2.new(0, 14, 0, 5),
    Size = UDim2.new(1, -125, 0, 25),

    BackgroundTransparency = 1,

    Text = "ZXC HUB",

    TextColor3 = THEME.Cyan,

    Font = Enum.Font.GothamBlack,
    TextSize = 19,

    TextXAlignment = Enum.TextXAlignment.Left,
}, Header)

local HeaderSubtitle = Create("TextLabel", {
    Position = UDim2.new(0, 15, 0, 29),
    Size = UDim2.new(1, -130, 0, 14),

    BackgroundTransparency = 1,

    Text = "NEXUS INFINITY  •  v21.0",

    TextColor3 = THEME.Muted,

    Font = Enum.Font.Gotham,
    TextSize = 9,

    TextXAlignment = Enum.TextXAlignment.Left,
}, Header)

local function HeaderButton(text, position, color)
    local button = Create("TextButton", {
        Position = position,
        Size = UDim2.new(0, 29, 0, 29),

        BackgroundColor3 = color or THEME.Card,
        BorderSizePixel = 0,

        Text = text,
        TextColor3 = THEME.White,

        Font = Enum.Font.GothamBold,
        TextSize = 16,

        AutoButtonColor = false,
    }, Header)

    AddCorner(button, 8)

    return button
end

local MinimizeButton = HeaderButton(
    "—",
    UDim2.new(1, -72, 0, 12)
)

local CloseButton = HeaderButton(
    "×",
    UDim2.new(1, -37, 0, 12),
    Color3.fromRGB(80, 28, 43)
)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Create("Frame", {
    Name = "Sidebar",

    Position = UDim2.new(0, 9, 0, 63),
    Size = UDim2.new(0, 105, 1, -72),

    BackgroundColor3 = THEME.Panel,
    BorderSizePixel = 0,
}, Main)

AddCorner(Sidebar, 11)

local SidebarTitle = Create("TextLabel", {
    Position = UDim2.new(0, 8, 0, 8),
    Size = UDim2.new(1, -16, 0, 22),

    BackgroundTransparency = 1,

    Text = "NAVIGATION",

    TextColor3 = THEME.Muted,

    Font = Enum.Font.GothamBold,
    TextSize = 9,
}, Sidebar)

local SidebarToggle = Create("TextButton", {
    Position = UDim2.new(1, -27, 0, 6),
    Size = UDim2.new(0, 21, 0, 24),

    BackgroundColor3 = THEME.Card,
    BorderSizePixel = 0,

    Text = "‹",
    TextColor3 = THEME.Cyan,

    Font = Enum.Font.GothamBold,
    TextSize = 18,

    AutoButtonColor = false,
}, Sidebar)

AddCorner(SidebarToggle, 6)

--==================================================
-- CONTENT AREA
--==================================================

local Content = Create("Frame", {
    Name = "Content",

    Position = UDim2.new(0, 123, 0, 63),
    Size = UDim2.new(1, -132, 1, -72),

    BackgroundColor3 = THEME.Panel,
    BorderSizePixel = 0,

    ClipsDescendants = true,
}, Main)

AddCorner(Content, 11)

--==================================================
-- PAGE SYSTEM
--==================================================

local Pages = {}
local NavButtons = {}

local function CreatePage(name)
    local page = Create("ScrollingFrame", {
        Name = name,

        Size = UDim2.fromScale(1, 1),

        BackgroundTransparency = 1,
        BorderSizePixel = 0,

        ScrollBarThickness = 3,
        ScrollBarImageColor3 = THEME.Blue,

        CanvasSize = UDim2.new(0, 0, 0, 0),

        Visible = false,
    }, Content)

    AddPadding(page, 10, 10, 10, 12)

    local layout = Create("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, page)

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(
            0,
            0,
            0,
            layout.AbsoluteContentSize.Y + 24
        )
    end)

    Pages[name] = page

    return page
end

local function CreateLabel(parent, text, height, color)
    local item = Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, height or 38),

        BackgroundColor3 = THEME.Card,
        BorderSizePixel = 0,

        Text = text,
        TextColor3 = color or THEME.White,

        Font = Enum.Font.Gotham,
        TextSize = 12,

        TextWrapped = true,
    }, parent)

    AddCorner(item, 8)

    return item
end

local function CreateAction(parent, text, callback)
    local button = Create("TextButton", {
        Size = UDim2.new(1, 0, 0, 38),

        BackgroundColor3 = THEME.Card,
        BorderSizePixel = 0,

        Text = text,
        TextColor3 = THEME.White,

        Font = Enum.Font.GothamMedium,
        TextSize = 12,

        AutoButtonColor = false,
    }, parent)

    AddCorner(button, 8)
    AddStroke(button, THEME.Blue, 0.8, 0.45)

    button.Activated:Connect(function()
        if button.Parent then
            callback(button)
        end
    end)

    button.MouseEnter:Connect(function()
        if STATE.UIEffects then
            Tween(button, 0.12, {
                BackgroundColor3 = Color3.fromRGB(28, 43, 63),
            })
        end
    end)

    button.MouseLeave:Connect(function()
        Tween(button, 0.12, {
            BackgroundColor3 = THEME.Card,
        })
    end)

    return button
end

--==================================================
-- CREATE PAGES
--==================================================

local Dashboard = CreatePage("Dashboard")
local Performance = CreatePage("Performance")
local Visual = CreatePage("Visual")
local CharacterPage = CreatePage("Character")
local Utilities = CreatePage("Utilities")
local SettingsPage = CreatePage("Settings")

--==================================================
-- DASHBOARD
--==================================================

CreateLabel(Dashboard, "WELCOME TO NEXUS INFINITY", 44, THEME.Cyan)

CreateLabel(
    Dashboard,
    "Premium mobile interface • Cyber / Glass / Dark Pro",
    43
)

local DashboardFPS = CreateLabel(
    Dashboard,
    "FPS: measuring...",
    38,
    THEME.Green
)

local DashboardStatus = CreateLabel(
    Dashboard,
    "STATUS: INITIALIZED",
    36
)

CreateLabel(
    Dashboard,
    "Tip: Drag the floating ZXC logo to move it.",
    43,
    THEME.Muted
)

--==================================================
-- PERFORMANCE
--==================================================

CreateLabel(Performance, "PERFORMANCE MONITOR", 42, THEME.Cyan)

local FPSLabel = CreateLabel(
    Performance,
    "FPS: measuring...",
    38,
    THEME.Green
)

local FrameTimeLabel = CreateLabel(
    Performance,
    "Frame time: measuring...",
    38
)

local DeviceLabel = CreateLabel(
    Performance,
    "Device: detecting...",
    38
)

local FPSButton

FPSButton = CreateAction(
    Performance,
    "FPS Monitor: ON",
    function(button)
        STATE.FPSMonitor = not STATE.FPSMonitor

        button.Text = "FPS Monitor: "
            .. (STATE.FPSMonitor and "ON" or "OFF")

        FPSLabel.Visible = STATE.FPSMonitor
        FrameTimeLabel.Visible = STATE.FPSMonitor
        DashboardFPS.Visible = STATE.FPSMonitor
    end
)

local EffectsButton

EffectsButton = CreateAction(
    Performance,
    "UI Effects: ON",
    function(button)
        STATE.UIEffects = not STATE.UIEffects

        button.Text = "UI Effects: "
            .. (STATE.UIEffects and "ON" or "OFF")

        DashboardStatus.Text = STATE.UIEffects
            and "STATUS: UI EFFECTS ENABLED"
            or "STATUS: UI EFFECTS REDUCED"
    end
)

local SmoothButton

SmoothButton = CreateAction(
    Performance,
    "Smooth Animations: ON",
    function(button)
        STATE.SmoothAnimations = not STATE.SmoothAnimations

        button.Text = "Smooth Animations: "
            .. (STATE.SmoothAnimations and "ON" or "OFF")
    end
)

CreateLabel(
    Performance,
    "These controls affect this hub's interface, not the game's rendering engine.",
    55,
    THEME.Muted
)

--==================================================
-- VISUAL
--==================================================

CreateLabel(Visual, "CAMERA & VISUAL SETTINGS", 42, THEME.Cyan)

local FOVLabel = CreateLabel(
    Visual,
    "Camera FOV: 70",
    40
)

local function ApplyFOV(value)
    value = math.clamp(
        math.floor(value),
        CONFIG.MinFOV,
        CONFIG.MaxFOV
    )

    STATE.FOV = value

    local camera = workspace.CurrentCamera

    if camera then
        camera.FieldOfView = value
    end

    FOVLabel.Text = "Camera FOV: " .. value
end

CreateAction(Visual, "FOV +5", function()
    ApplyFOV(STATE.FOV + 5)
end)

CreateAction(Visual, "FOV -5", function()
    ApplyFOV(STATE.FOV - 5)
end)

CreateAction(Visual, "Reset FOV", function()
    ApplyFOV(CONFIG.DefaultFOV)
end)

CreateLabel(
    Visual,
    "FOV changes camera perspective; it does not directly increase FPS.",
    48,
    THEME.Muted
)

--==================================================
-- CHARACTER
--==================================================

CreateLabel(CharacterPage, "CHARACTER DASHBOARD", 42, THEME.Cyan)

local NameLabel = CreateLabel(
    CharacterPage,
    "Player: " .. Player.Name,
    38
)

local HealthLabel = CreateLabel(
    CharacterPage,
    "Health: loading...",
    38
)

local SpeedLabel = CreateLabel(
    CharacterPage,
    "WalkSpeed: loading...",
    38
)

local JumpLabel = CreateLabel(
    CharacterPage,
    "JumpPower: loading...",
    38
)

local function UpdateCharacter()
    local character = Player.Character

    local humanoid = character
        and character:FindFirstChildOfClass("Humanoid")

    if not humanoid then
        HealthLabel.Text = "Health: character loading..."
        SpeedLabel.Text = "WalkSpeed: unavailable"
        JumpLabel.Text = "JumpPower: unavailable"

        return
    end

    HealthLabel.Text = string.format(
        "Health: %d / %d",
        math.floor(humanoid.Health),
        math.floor(humanoid.MaxHealth)
    )

    SpeedLabel.Text = "WalkSpeed: " .. tostring(humanoid.WalkSpeed)

    JumpLabel.Text = "JumpPower: " .. tostring(humanoid.JumpPower)
end

--==================================================
-- UTILITIES
--==================================================

CreateLabel(Utilities, "QUICK UTILITIES", 42, THEME.Cyan)

local CompactButton

CompactButton = CreateAction(
    Utilities,
    "Compact Sidebar: OFF",
    function(button)
        STATE.SidebarExpanded = not STATE.SidebarExpanded

        local width = STATE.SidebarExpanded and 105 or 42

        Tween(Sidebar, 0.2, {
            Size = UDim2.new(0, width, 1, -72),
        })

        Tween(Content, 0.2, {
            Position = UDim2.new(0, width + 18, 0, 63),
            Size = UDim2.new(1, -(width + 27), 1, -72),
        })

        button.Text = "Compact Sidebar: "
            .. (STATE.SidebarExpanded and "OFF" or "ON")

        SidebarTitle.Visible = STATE.SidebarExpanded

        for _, nav in pairs(NavButtons) do
            nav.Text = STATE.SidebarExpanded
                and nav:GetAttribute("PageName")
                or nav:GetAttribute("Icon")
        end

        SidebarToggle.Text = STATE.SidebarExpanded and "‹" or "›"
    end
)

local ResetPositionButton

--==================================================
-- SETTINGS
--==================================================

CreateLabel(SettingsPage, "NEXUS CONFIGURATION", 42, THEME.Cyan)

local InfoLabel = CreateLabel(
    SettingsPage,
    "ZXC HUB v21.0 • NEXUS INFINITY",
    40
)

CreateAction(SettingsPage, "Reset FOV", function()
    ApplyFOV(CONFIG.DefaultFOV)
end)

CreateAction(SettingsPage, "Reset UI Settings", function()
    STATE.FPSMonitor = true
    STATE.UIEffects = true
    STATE.SmoothAnimations = true

    FPSLabel.Visible = true
    FrameTimeLabel.Visible = true
    DashboardFPS.Visible = true

    FPSButton.Text = "FPS Monitor: ON"
    EffectsButton.Text = "UI Effects: ON"
    SmoothButton.Text = "Smooth Animations: ON"

    DashboardStatus.Text = "STATUS: INITIALIZED"

    ApplyFOV(CONFIG.DefaultFOV)
end)

--==================================================
-- NAVIGATION
--==================================================

local NAVIGATION = {
    {
        Name = "Dashboard",
        Icon = "⌂",
    },
    {
        Name = "Performance",
        Icon = "⚡",
    },
    {
        Name = "Visual",
        Icon = "◈",
    },
    {
        Name = "Character",
        Icon = "♙",
    },
    {
        Name = "Utilities",
        Icon = "✦",
    },
    {
        Name = "Settings",
        Icon = "⚙",
    },
}

local function ShowPage(name)
    local page = Pages[name]

    if not page then
        return
    end

    STATE.CurrentTab = name

    for pageName, otherPage in pairs(Pages) do
        otherPage.Visible = pageName == name
    end

    for _, button in pairs(NavButtons) do
        local selected = button:GetAttribute("PageName") == name

        Tween(button, 0.15, {
            BackgroundColor3 = selected
                and Color3.fromRGB(0, 66, 103)
                or THEME.Card,

            TextColor3 = selected
                and THEME.Cyan
                or THEME.White,
        })
    end
end

for index, item in ipairs(NAVIGATION) do
    local nav = Create("TextButton", {
        Name = item.Name .. "Button",

        Position = UDim2.new(0, 6, 0, 36 + (index - 1) * 42),
        Size = UDim2.new(1, -12, 0, 36),

        BackgroundColor3 = THEME.Card,
        BorderSizePixel = 0,

        Text = item.Name,
        TextColor3 = THEME.White,

        Font = Enum.Font.GothamMedium,
        TextSize = 10,

        AutoButtonColor = false,
    }, Sidebar)

    AddCorner(nav, 8)

    nav:SetAttribute("PageName", item.Name)
    nav:SetAttribute("Icon", item.Icon)

    NavButtons[#NavButtons + 1] = nav

    nav.Activated:Connect(function()
        ShowPage(item.Name)
    end)
end

ShowPage("Dashboard")

SidebarToggle.Activated:Connect(function()
    CompactButton:Activate()
end)

--==================================================
-- FLOATING LOGO
--==================================================

local Floating = Create("TextButton", {
    Name = "FloatingZXC",

    AnchorPoint = Vector2.new(0.5, 0.5),

    Position = UDim2.new(1, -42, 0.76, 0),
    Size = UDim2.new(0, 56, 0, 56),

    BackgroundColor3 = THEME.Panel,
    BorderSizePixel = 0,

    Text = "ZXC",
    TextColor3 = THEME.Cyan,

    Font = Enum.Font.GothamBlack,
    TextSize = 16,

    AutoButtonColor = false,

    ZIndex = 50,
}, GUI)

AddCorner(Floating, 28)
AddStroke(Floating, THEME.Blue, 2)

local FloatingGradient = Create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, THEME.Panel),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 50, 85)),
    }),

    Rotation = 45,
}, Floating)

local FloatingScale = Create("UIScale", {
    Scale = 1,
}, Floating)

-- Drag handling: distinguish tap from drag
local dragging = false
local dragMoved = false

local dragInput
local dragStart
local startPosition

local DRAG_THRESHOLD = 8

local function ClampFloatingPosition(position)
    local camera = workspace.CurrentCamera

    if not camera then
        return position
    end

    local viewport = camera.ViewportSize

    local halfX = Floating.AbsoluteSize.X / 2
    local halfY = Floating.AbsoluteSize.Y / 2

    local x = math.clamp(
        position.X.Offset,
        halfX,
        viewport.X - halfX
    )

    local y = math.clamp(
        position.Y.Offset,
        halfY,
        viewport.Y - halfY
    )

    return UDim2.fromOffset(x, y)
end

local function StartDragging(input)
    dragging = true
    dragMoved = false

    dragInput = input
    dragStart = input.Position

    startPosition = UDim2.fromOffset(
        Floating.AbsolutePosition.X + Floating.AbsoluteSize.X / 2,
        Floating.AbsolutePosition.Y + Floating.AbsoluteSize.Y / 2
    )
end

Floating.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then

        StartDragging(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then
        return
    end

    local isRelevantInput =
        input == dragInput
        or input.UserInputType == Enum.UserInputType.MouseMovement

    if not isRelevantInput then
        return
    end

    local delta = input.Position - dragStart

    if delta.Magnitude >= DRAG_THRESHOLD then
        dragMoved = true
    end

    if dragMoved then
        Floating.Position = ClampFloatingPosition(
            UDim2.fromOffset(
                startPosition.X.Offset + delta.X,
                startPosition.Y.Offset + delta.Y
            )
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if not dragging then
        return
    end

    local isRelease =
        input == dragInput
        or input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch

    if not isRelease then
        return
    end

    dragging = false

    if not dragMoved then
        Main.Visible = not Main.Visible
        STATE.Open = Main.Visible
    end
end)

--==================================================
-- MINIMIZE / CLOSE
--==================================================

local function OpenMain()
    Main.Visible = true
    STATE.Open = true

    if STATE.SmoothAnimations then
        Main.BackgroundTransparency = 1

        Tween(Main, 0.2, {
            BackgroundTransparency = 0,
        })
    end
end

local function MinimizeMain()
    Main.Visible = false
    STATE.Open = false
end

MinimizeButton.Activated:Connect(MinimizeMain)

CloseButton.Activated:Connect(function()
    GUI:Destroy()
end)

--==================================================
-- FPS MONITOR
--==================================================

local frameCount = 0
local elapsed = 0

local connections = {}

connections[#connections + 1] =
    RunService.RenderStepped:Connect(function(deltaTime)
        if not GUI.Parent then
            return
        end

        frameCount += 1
        elapsed += deltaTime

        if elapsed >= 1 then
            local fps = math.floor(frameCount / elapsed + 0.5)

            local frameTime = frameCount > 0
                and elapsed / frameCount * 1000
                or 0

            if STATE.FPSMonitor then
                DashboardFPS.Text = "FPS: " .. fps

                FPSLabel.Text = "FPS: " .. fps

                FrameTimeLabel.Text = string.format(
                    "Frame time: %.2f ms",
                    frameTime
                )
            end

            frameCount = 0
            elapsed = 0
        end

        UpdateCharacter()
    end)

--==================================================
-- DEVICE INFO
--==================================================

local isTouch = UserInputService.TouchEnabled
local isKeyboard = UserInputService.KeyboardEnabled
local isGamepad = UserInputService.GamepadEnabled

local deviceParts = {}

if isTouch then
    deviceParts[#deviceParts + 1] = "Touch"
end

if isKeyboard then
    deviceParts[#deviceParts + 1] = "Keyboard"
end

if isGamepad then
    deviceParts[#deviceParts + 1] = "Gamepad"
end

DeviceLabel.Text = "Controls: "
    .. (#deviceParts > 0 and table.concat(deviceParts, " + ") or "Unknown")

--==================================================
-- LOADING SEQUENCE
--==================================================

local function RunLoader()
    local steps = {
        {
            Progress = 0.25,
            Status = "Preparing interface...",
        },
        {
            Progress = 0.50,
            Status = "Building dashboard...",
        },
        {
            Progress = 0.75,
            Status = "Preparing navigation...",
        },
        {
            Progress = 1,
            Status = "Interface ready!",
        },
    }

    for _, step in ipairs(steps) do
        if not GUI.Parent then
            return
        end

        LoaderStatus.Text = step.Status

        Tween(ProgressFill, 0.25, {
            Size = UDim2.new(step.Progress, 0, 1, 0),
        })

        ProgressText.Text = string.format(
            "%d%%",
            math.floor(step.Progress * 100)
        )

        task.wait(CONFIG.LoadingTime / #steps)
    end

    if not GUI.Parent then
        return
    end

    Tween(Loader, 0.25, {
        BackgroundTransparency = 1,
    })

    task.wait(0.27)

    if not GUI.Parent then
        return
    end

    Loader:Destroy()

    Main.Visible = true

    Main.Size = UDim2.new(0.88, 0, 0.66, 0)

    Tween(Main, 0.3, {
        Size = UDim2.new(0.94, 0, 0.72, 0),
    })
end

--==================================================
-- INITIALIZE
--==================================================

RunLoader()

print("ZXC HUB v21.0 — NEXUS INFINITY initialized")
