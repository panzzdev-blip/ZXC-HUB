--[[
    ZXC HUB
    Version: 20.1.5
    Edition: NEXUS ULTIMATE
]]

local ZXC = {
    Name = "ZXC HUB",
    Version = "20.1.5",
    Edition = "NEXUS ULTIMATE",
    Loaded = false
}

local success, err = pcall(function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local Player = Players.LocalPlayer

    if not Player then
        error("LocalPlayer unavailable")
    end

    local PlayerGui = Player:WaitForChild("PlayerGui")

    local Previous = PlayerGui:FindFirstChild("ZXC_HUB")

    if Previous then
        Previous:Destroy()
    end

    local GUI = Instance.new("ScreenGui")
    GUI.Name = "ZXC_HUB"
    GUI.ResetOnSpawn = false
    GUI.DisplayOrder = 100
    GUI.Parent = PlayerGui

    -- Main panel
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = UDim2.fromOffset(320, 390)
    Main.Position = UDim2.new(0.5, -160, 0.5, -195)
    Main.BackgroundColor3 = Color3.fromRGB(9, 12, 22)
    Main.BorderSizePixel = 0
    Main.Parent = GUI

    Instance.new("UICorner", Main).CornerRadius =
        UDim.new(0, 16)

    local Border = Instance.new("UIStroke")
    Border.Color = Color3.fromRGB(0, 160, 255)
    Border.Thickness = 1.5
    Border.Parent = Main

    -- Header
    local Header = Instance.new("TextLabel")
    Header.Size = UDim2.new(1, -60, 0, 45)
    Header.Position = UDim2.fromOffset(15, 8)
    Header.BackgroundTransparency = 1
    Header.Text = "ZXC HUB"
    Header.TextColor3 = Color3.fromRGB(0, 220, 255)
    Header.TextSize = 25
    Header.Font = Enum.Font.GothamBlack
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Parent = Main

    local Version = Instance.new("TextLabel")
    Version.Size = UDim2.new(1, -30, 0, 20)
    Version.Position = UDim2.fromOffset(16, 48)
    Version.BackgroundTransparency = 1
    Version.Text = "NEXUS ULTIMATE  |  v20.1.5"
    Version.TextColor3 = Color3.fromRGB(145, 160, 185)
    Version.TextSize = 10
    Version.Font = Enum.Font.GothamBold
    Version.TextXAlignment = Enum.TextXAlignment.Left
    Version.Parent = Main

    -- Close / hide button
    local Close = Instance.new("TextButton")
    Close.Size = UDim2.fromOffset(32, 32)
    Close.Position = UDim2.new(1, -44, 0, 12)
    Close.BackgroundColor3 = Color3.fromRGB(45, 24, 40)
    Close.Text = "×"
    Close.TextColor3 = Color3.fromRGB(255, 100, 125)
    Close.TextSize = 23
    Close.Font = Enum.Font.GothamBold
    Close.Parent = Main

    Instance.new("UICorner", Close).CornerRadius =
        UDim.new(0, 8)

    -- Floating logo
    local Logo = Instance.new("TextButton")
    Logo.Name = "FloatingLogo"
    Logo.Size = UDim2.fromOffset(56, 56)
    Logo.Position = UDim2.new(0, 15, 0.5, -28)
    Logo.BackgroundColor3 = Color3.fromRGB(10, 20, 38)
    Logo.Text = "ZXC"
    Logo.TextColor3 = Color3.fromRGB(0, 220, 255)
    Logo.TextSize = 16
    Logo.Font = Enum.Font.GothamBlack
    Logo.Visible = false
    Logo.Parent = GUI

    Instance.new("UICorner", Logo).CornerRadius =
        UDim.new(1, 0)

    local LogoBorder = Instance.new("UIStroke")
    LogoBorder.Color = Color3.fromRGB(0, 160, 255)
    LogoBorder.Thickness = 2
    LogoBorder.Parent = Logo

    -- Hide panel but keep logo
    Close.Activated:Connect(function()
        Main.Visible = false
        Logo.Visible = true
    end)

    -- Reopen panel
    Logo.Activated:Connect(function()
        Main.Visible = true
        Logo.Visible = false
    end)

    -- FPS monitor
    local FPS = Instance.new("TextLabel")
    FPS.Size = UDim2.new(1, -30, 0, 40)
    FPS.Position = UDim2.fromOffset(15, 85)
    FPS.BackgroundColor3 = Color3.fromRGB(18, 28, 45)
    FPS.Text = "FPS: --"
    FPS.TextColor3 = Color3.fromRGB(80, 255, 165)
    FPS.TextSize = 18
    FPS.Font = Enum.Font.GothamBold
    FPS.Parent = Main

    Instance.new("UICorner", FPS).CornerRadius =
        UDim.new(0, 10)

    local frames = 0
    local elapsed = 0

    RunService.RenderStepped:Connect(function(dt)
        if not GUI.Parent then
            return
        end

        frames += 1
        elapsed += dt

        if elapsed >= 0.5 then
            FPS.Text = "FPS: " ..
                tostring(math.floor(frames / elapsed))

            frames = 0
            elapsed = 0
        end
    end)

    ZXC.Loaded = true
    print("ZXC HUB v20.1.5 loaded")
end)

if not success then
    warn("[ZXC HUB] Error: " .. tostring(err))
end

return ZXC
