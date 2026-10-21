-- ZXC HUB v20.1.5
-- Module: Settings

local Settings = {}

Settings.Defaults = {
    Theme = "Midnight Blue",
    ShowFPS = true,
    LowGraphics = false,
    ReduceEffects = false,
    FOV = 70
}

local Current = {}

for key, value in pairs(Settings.Defaults) do
    Current[key] = value
end

function Settings.Get(key)
    return Current[key]
end

function Settings.Set(key, value)
    if Settings.Defaults[key] == nil then
        return false
    end

    if type(value) ~= type(Settings.Defaults[key]) then
        return false
    end

    Current[key] = value

    return true
end

function Settings.Reset()
    for key, value in pairs(Settings.Defaults) do
        Current[key] = value
    end
end

function Settings.GetAll()
    local result = {}

    for key, value in pairs(Current) do
        result[key] = value
    end

    return result
end

return Settings
