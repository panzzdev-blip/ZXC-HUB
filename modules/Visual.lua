--[[
    ZXC HUB v20.1.5 — NEXUS ULTIMATE
    Module: Visual
    Description: Client-side visual and camera utilities
]]

local Visual = {}

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

-- Get the player's current camera
function Visual.GetCamera()
    return Workspace.CurrentCamera
end

-- Get the current field of view
function Visual.GetFOV()
    local camera = Visual.GetCamera()

    if not camera then
        return nil
    end

    return camera.FieldOfView
end

-- Set the camera field of view
function Visual.SetFOV(value)
    local camera = Visual.GetCamera()

    if not camera then
        return false, "Camera is unavailable"
    end

    value = tonumber(value)

    if not value then
        return false, "FOV must be a number"
    end

    camera.FieldOfView = math.clamp(value, 40, 100)

    return true
end

-- Read the current brightness
function Visual.GetBrightness()
    return Lighting.Brightness
end

-- Set local lighting brightness
function Visual.SetBrightness(value)
    value = tonumber(value)

    if not value then
        return false, "Brightness must be a number"
    end

    Lighting.Brightness = math.clamp(value, 0, 5)

    return true
end

-- Restore default camera FOV
function Visual.ResetFOV()
    local camera = Visual.GetCamera()

    if camera then
        camera.FieldOfView = 70
        return true
    end

    return false
end

return Visual
