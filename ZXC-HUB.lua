--[[
    ZXC HUB v20.1.5
    NEXUS ULTIMATE
    Standalone UI Prototype
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Avoid duplicate GUI
local existing = playerGui:FindFirstChild("ZXC_HUB")
if existing then
    existing:Destroy()
end

-- Theme
local C = {
    BG = Color3.fromRGB(9, 11, 18),
    PANEL = Color3.fromRGB(17, 21, 32),
    CARD = Color3.fromRGB(24, 30, 44),
    BLUE = Color3.fromRGB(0, 170, 255),
    WHITE = Color3.fromRGB(240, 245, 255),
    MUTED = Color3.fromRGB(140, 155, 180),
    GREEN = Color3.fromRGB(60, 220, 140)
}

local gui = Instance.new("ScreenGui")
gui.Name = "ZXC_HUB"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = playerGui

local function make(class, props, parent)
    local obj = Instance.new(class)

    for key, value in pairs(props) do
        obj[key] = value
    end

    obj.Parent = parent
    return obj
end

local function corner(parent, radius)
    make("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, parent)
end

local function stroke(parent, color, thickness)
    make("UIStroke", {
        Color = color,
        Thickness = thickness,
        Transparency = 0.15
    }, parent)
end

-- Main window
local main = make("Frame", {
    Name = "MainWindow",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(0.9, 0, 0, 360),
    BackgroundColor3 = C.BG,
    BorderSizePixel = 0
}, gui)

main.Size = UDim2.new(
    0.9, 0,
    0, math.min(380, workspace.CurrentCamera.ViewportSize.Y * 0.75)
)

corner(main, 14)
stroke(main, C.BLUE, 1.5)

make("UISizeConstraint", {
    MinSize = Vector2.new(280, 280),
    MaxSize = Vector2.new(560, 420)
}, main)

-- Header
local header = make("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 54),
    BackgroundColor3 = C.PANEL,
    BorderSizePixel = 0
}, main)

corner(header, 14)

make("TextLabel", {
    Position = UDim2.new(0, 15, 0, 5),
    Size = UDim2.new(0.7, 0, 0, 24),
    BackgroundTransparency = 1,
    Text = "ZXC HUB",
    TextColor3 = C.BLUE,
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

make("TextLabel", {
    Position = UDim2.new(0, 16, 0, 28),
    Size = UDim2.new(0.7, 0, 0, 15),
    BackgroundTransparency = 1,
    Text = "v20.1.5 • NEXUS ULTIMATE",
    TextColor3 = C.MUTED,
    Font = Enum.Font.Gotham,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

local minimize = make("TextButton", {
    Position = UDim2.new(1, -76, 0, 10),
    Size = UDim2.new(0, 28, 0, 28),
    BackgroundColor3 = C.CARD,
    Text = "—",
    TextColor3 = C.WHITE,
    Font = Enum.Font.GothamBold,
    TextSize = 16
}, header)
corner(minimize, 8)

local close = make("TextButton", {
    Position = UDim2.new(1, -40, 0, 10),
    Size = UDim2.new(0, 28, 0, 28),
    BackgroundColor3 = Color3.fromRGB(100, 35, 50),
    Text = "×",
    TextColor3 = C.WHITE,
    Font = Enum.Font.GothamBold,
    TextSize = 18
}, header)
corner(close, 8)

-- Navigation
local nav = make("Frame", {
    Position = UDim2.new(0, 10, 0, 65),
    Size = UDim2.new(0, 100, 1, -76),
    BackgroundColor3 = C.PANEL,
    BorderSizePixel = 0
}, main)
corner(nav, 10)

local content = make("Frame", {
    Position = UDim2.new(0, 120, 0, 65),
    Size = UDim2.new(1, -130, 1, -76),
    BackgroundColor3 = C.PANEL,
    BorderSizePixel = 0
}, main)
corner(content, 10)

local pages = {}
local activePage

local function createPage(name)
    local page = make("ScrollingFrame", {
        Name = name,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = C.BLUE,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Visible = false
    }, content)

    make("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10)
    }, page)

    local layout = make("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, page)

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(
            0, 0, 0, layout.AbsoluteContentSize.Y + 20
        )
    end)

    pages[name] = page
    return page
end

local function label(parent, text, height)
    local item = make("TextLabel", {
        Size = UDim2.new(1, 0, 0, height or 35),
        BackgroundColor3 = C.CARD,
        BorderSizePixel = 0,
        Text = text,
        TextColor3 = C.WHITE,
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextWrapped = true
    }, parent)

    corner(item, 8)
    return item
end

local function button(parent, text, callback)
    local item = make("TextButton", {
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = C.CARD,
        BorderSizePixel = 0,
        Text = text,
        TextColor3 = C.WHITE,
        Font = Enum.Font.GothamMedium,
        TextSize = 13
    }, parent)

    corner(item, 8)
    stroke(item, C.BLUE, 0.7)

    item.Activated:Connect(callback)
    return item
end

local dashboard = createPage("Dashboard")
local performance = createPage("Performance")
local visual = createPage("Visual")
local characterPage = createPage("Character")
local settingsPage = createPage("Settings")

-- Dashboard
label(dashboard, "WELCOME TO ZXC HUB", 42)
label(dashboard, "NEXUS ULTIMATE • CLIENT UI", 35)
local fpsLabel = label(dashboard, "FPS: measuring...", 38)
local statusLabel = label(dashboard, "Status: UI running", 35)

-- Performance
label(performance, "PERFORMANCE MONITOR", 40)
local detailedFPS = label(performance, "FPS: measuring...", 38)
local frameTime = label(performance, "Frame time: measuring...", 38)
label(performance, "Monitor only — FPS gains are not guaranteed.", 50)

-- Visual
label(visual, "VISUAL SETTINGS", 40)
local fovLabel = label(visual, "Camera FOV: 70", 35)

button(visual, "FOV 70", function()
    local camera = workspace.CurrentCamera
    if camera then
        camera.FieldOfView = 70
        fovLabel.Text = "Camera FOV: 70"
    end
end)

button(visual, "FOV 85", function()
    local camera = workspace.CurrentCamera
    if camera then
        camera.FieldOfView = 85
        fovLabel.Text = "Camera FOV: 85"
    end
end)

button(visual, "Reset FOV", function()
    local camera = workspace.CurrentCamera
    if camera then
        camera.FieldOfView = 70
        fovLabel.Text = "Camera FOV: 70"
    end
end)

-- Character
label(characterPage, "CHARACTER INFORMATION", 40)
local healthLabel = label(characterPage, "Health: loading...", 35)
local speedLabel = label(characterPage, "WalkSpeed: loading...", 35)
local nameLabel = label(characterPage, "Player: " .. player.Name, 35)

-- Settings
label(settingsPage, "HUB SETTINGS", 40)

local showFPS = true
button(settingsPage, "Toggle FPS display", function()
    showFPS = not showFPS
    fpsLabel.Visible = showFPS
    detailedFPS.Visible = showFPS
end)

button(settingsPage, "Reset camera FOV", function()
    local camera = workspace.CurrentCamera
    if camera then
        camera.FieldOfView = 70
        fovLabel.Text = "Camera FOV: 70"
    end
end)

-- Navigation buttons
local navNames = {
    "Dashboard",
    "Performance",
    "Visual",
    "Character",
    "Settings"
}

local function showPage(name)
    for pageName, page in pairs(pages) do
        page.Visible = pageName == name
    end

    activePage = name
end

for index, name in ipairs(navNames) do
    local navButton = make("TextButton", {
        Position = UDim2.new(0, 6, 0, 8 + (index - 1) * 43),
        Size = UDim2.new(1, -12, 0, 37),
        BackgroundColor3 = C.CARD,
        BorderSizePixel = 0,
        Text = name,
        TextColor3 = C.WHITE,
        Font = Enum.Font.GothamMedium,
        TextSize = 11
    }, nav)

    corner(navButton, 8)

    navButton.Activated:Connect(function()
        showPage(name)
    end)
end

showPage("Dashboard")

-- Floating ZXC logo
local floating = make("TextButton", {
    Name = "FloatingZXC",
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, -18, 1, -100),
    Size = UDim2.new(0, 58, 0, 58),
    BackgroundColor3 = C.PANEL,
    BorderSizePixel = 0,
    Text = "ZXC",
    TextColor3 = C.BLUE,
    Font = Enum.Font.GothamBlack,
    TextSize = 17,
    ZIndex = 20
}, gui)

corner(floating, 29)
stroke(floating, C.BLUE, 2)

-- Minimize keeps floating logo visible
minimize.Activated:Connect(function()
    main.Visible = false
end)

floating.Activated:Connect(function()
    main.Visible = not main.Visible
end)

-- Close removes the GUI
close.Activated:Connect(function()
    gui:Destroy()
end)

-- FPS + character monitor
local frames = 0
local elapsed = 0
local monitorConnection

monitorConnection = RunService.RenderStepped:Connect(function(dt)
    if not gui.Parent then
        if monitorConnection then
            monitorConnection:Disconnect()
        end
        return
    end

    frames += 1
    elapsed += dt

    if elapsed >= 1 then
        local fps = math.floor(frames / elapsed + 0.5)
        local ms = frames > 0 and (elapsed / frames) * 1000 or 0

        fpsLabel.Text = "FPS: " .. fps
        detailedFPS.Text = "FPS: " .. fps
        frameTime.Text = string.format("Frame time: %.2f ms", ms)

        frames = 0
        elapsed = 0
    end

    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        healthLabel.Text = string.format(
            "Health: %d / %d",
            math.floor(humanoid.Health),
            math.floor(humanoid.MaxHealth)
        )

        speedLabel.Text = "WalkSpeed: " .. tostring(humanoid.WalkSpeed)
    end
end)

-- Drag the main window on touch or mouse
local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("ZXC HUB v20.1.5 initialized")
