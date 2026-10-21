--[[
    ZXC HUB | PERFORMANCE EDITION
    Version: 1.0
    Theme: Midnight Blue
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Remove previous UI
local Previous = PlayerGui:FindFirstChild("ZXCHUB")

if Previous then
    Previous:Destroy()
end

-- Theme
local Theme = {
    Background = Color3.fromRGB(9, 12, 20),
    Panel = Color3.fromRGB(16, 21, 33),
    Card = Color3.fromRGB(23, 30, 45),
    Blue = Color3.fromRGB(0, 145, 255),
    Cyan = Color3.fromRGB(0, 220, 255),
    White = Color3.fromRGB(240, 245, 255),
    Gray = Color3.fromRGB(145, 158, 180),
    Green = Color3.fromRGB(65, 255, 165)
}

-- Main GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "ZXCHUB"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = false
Gui.DisplayOrder = 100
Gui.Parent = PlayerGui

-- Main window
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 340, 0, 390)
Main.Position = UDim2.new(0.5, -170, 0.5, -195)
Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Theme.Blue
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.15
MainStroke.Parent = Main

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 76)
Header.BackgroundColor3 = Theme.Panel
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 0, 32)
Title.Position = UDim2.new(0, 16, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "ZXC HUB"
Title.TextColor3 = Theme.Cyan
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 25
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -25, 0, 20)
Subtitle.Position = UDim2.new(0, 17, 0, 43)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "PERFORMANCE  •  MOBILE EDITION"
Subtitle.TextColor3 = Theme.Gray
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.TextSize = 10
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

-- Close button
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 34, 0, 34)
Close.Position = UDim2.new(1, -45, 0, 14)
Close.BackgroundColor3 = Theme.Card
Close.Text = "×"
Close.TextColor3 = Theme.White
Close.TextSize = 25
Close.Font = Enum.Font.GothamBold
Close.Parent = Header

Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 10)

Close.Activated:Connect(function()
    Gui:Destroy()
end)

-- FPS card
local FPSCard = Instance.new("Frame")
FPSCard.Size = UDim2.new(1, -24, 0, 65)
FPSCard.Position = UDim2.new(0, 12, 0, 88)
FPSCard.BackgroundColor3 = Theme.Panel
FPSCard.BorderSizePixel = 0
FPSCard.Parent = Main

Instance.new("UICorner", FPSCard).CornerRadius = UDim.new(0, 12)

local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.new(0.65, 0, 0, 25)
FPSLabel.Position = UDim2.new(0, 13, 0, 8)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Text = "LIVE PERFORMANCE"
FPSLabel.TextColor3 = Theme.Gray
FPSLabel.TextSize = 11
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.TextXAlignment = Enum.TextXAlignment.Left
FPSLabel.Parent = FPSCard

local FPSValue = Instance.new("TextLabel")
FPSValue.Size = UDim2.new(0.7, 0, 0, 27)
FPSValue.Position = UDim2.new(0, 12, 0, 31)
FPSValue.BackgroundTransparency = 1
FPSValue.Text = "-- FPS"
FPSValue.TextColor3 = Theme.Green
FPSValue.TextSize = 21
FPSValue.Font = Enum.Font.GothamBlack
FPSValue.TextXAlignment = Enum.TextXAlignment.Left
FPSValue.Parent = FPSCard

-- Content
local Content = Instance.new("ScrollingFrame")
Content.Name = "Settings"
Content.Size = UDim2.new(1, -24, 1, -172)
Content.Position = UDim2.new(0, 12, 0, 162)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 = Theme.Blue
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.Parent = Main

local List = Instance.new("UIListLayout")
List.Padding = UDim.new(0, 8)
List.SortOrder = Enum.SortOrder.LayoutOrder
List.Parent = Content

local function CreateButton(text, description, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -4, 0, 58)
    Button.BackgroundColor3 = Theme.Card
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = Content

    Instance.new("UICorner", Button).CornerRadius =
        UDim.new(0, 11)

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Theme.Blue
    Stroke.Transparency = 0.8
    Stroke.Parent = Button

    local Name = Instance.new("TextLabel")
    Name.Size = UDim2.new(1, -20, 0, 23)
    Name.Position = UDim2.new(0, 12, 0, 7)
    Name.BackgroundTransparency = 1
    Name.Text = text
    Name.TextColor3 = Theme.White
    Name.TextSize = 13
    Name.Font = Enum.Font.GothamBold
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.Parent = Button

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -20, 0, 18)
    Desc.Position = UDim2.new(0, 12, 0, 31)
    Desc.BackgroundTransparency = 1
    Desc.Text = description
    Desc.TextColor3 = Theme.Gray
    Desc.TextSize = 10
    Desc.Font = Enum.Font.Gotham
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.Parent = Button

    Button.Activated:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(0.12),
            {BackgroundColor3 = Theme.Blue}
        ):Play()

        task.delay(0.15, function()
            if Button.Parent then
                TweenService:Create(
                    Button,
                    TweenInfo.new(0.18),
                    {BackgroundColor3 = Theme.Card}
                ):Play()
            end
        end)

        callback()
    end)

    return Button
end

-- FPS monitor
local Monitoring = true
local Frames = 0
local LastTime = os.clock()

RunService.RenderStepped:Connect(function()
    if not Monitoring or not Gui.Parent then
        return
    end

    Frames += 1

    local Now = os.clock()
    local Elapsed = Now - LastTime

    if Elapsed >= 1 then
        FPSValue.Text = math.floor(Frames / Elapsed) .. " FPS"
        Frames = 0
        LastTime = Now
    end
end)

-- Example local lighting optimization
local LowGraphics = false
local Original = {
    GlobalShadows = Lighting.GlobalShadows,
    FogEnd = Lighting.FogEnd
}

CreateButton(
    "LOW GRAPHICS",
    "Toggle selected local lighting effects",
    function()
        LowGraphics = not LowGraphics

        if LowGraphics then
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 100000
        else
            Lighting.GlobalShadows = Original.GlobalShadows
            Lighting.FogEnd = Original.FogEnd
        end
    end
)

-- Camera FOV
CreateButton(
    "CAMERA RESET",
    "Restore default camera field of view",
    function()
        local Camera = workspace.CurrentCamera

        if Camera then
            Camera.FieldOfView = 70
        end
    end
)

-- UI information
CreateButton(
    "ABOUT ZXC HUB",
    "Lightweight performance interface",
    function()
        FPSLabel.Text = "ZXC HUB • VERSION 1.0"
    end
)

print("ZXC HUB loaded successfully!")
