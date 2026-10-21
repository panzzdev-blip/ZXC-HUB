--[[
    ZXC HUB v20.1.5 — NEXUS ULTIMATE
    Module: Settings
    Theme: Black + Electric Blue Neon
]]

local Settings = {}

Settings.Version = "20.1.5"
Settings.Name = "ZXC HUB"
Settings.Edition = "NEXUS ULTIMATE"

-- Theme configuration
Settings.Theme = {
    Background = Color3.fromRGB(10, 12, 18),
    Panel = Color3.fromRGB(17, 21, 31),
    Secondary = Color3.fromRGB(24, 30, 43),
    Accent = Color3.fromRGB(0, 170, 255),
    AccentLight = Color3.fromRGB(80, 200, 255),
    Text = Color3.fromRGB(240, 245, 255),
    MutedText = Color3.fromRGB(145, 158, 180),
    Success = Color3.fromRGB(60, 220, 140),
    Warning = Color3.fromRGB(255, 190, 60),
    Error = Color3.fromRGB(255, 80, 100)
}

-- Default UI preferences
Settings.Defaults = {
    WindowWidth = 560,
    WindowHeight = 380,
    Minimized = false,
    ShowFPS = true,
    ShowCharacterInfo = true,
    FOV = 70
}

-- Current settings
Settings.Current = {}

function Settings.Reset()
    Settings.Current = {}

    for key, value in pairs(Settings.Defaults) do
        Settings.Current[key] = value
    end

    return Settings.Current
end

function Settings.Get(key)
    if Settings.Current[key] == nil then
        return Settings.Defaults[key]
    end

    return Settings.Current[key]
end

function Settings.Set(key, value)
    if Settings.Defaults[key] == nil then
        return false, "Unknown setting: " .. tostring(key)
    end

    Settings.Current[key] = value

    return true
end

function Settings.GetTheme()
    return Settings.Theme
end

-- Initialize defaults
Settings.Reset()

return Settings
