-- ZXC HUB v20.1.5
-- Module: Visual

local Visual = {}

function Visual.SetFOV(value)
    local camera = workspace.CurrentCamera

    if not camera then
        return false
    end

    camera.FieldOfView = math.clamp(value, 40, 100)

    return true
end

function Visual.ResetFOV()
    return Visual.SetFOV(70)
end

function Visual.GetFOV()
    local camera = workspace.CurrentCamera

    if camera then
        return camera.FieldOfView
    end

    return nil
end

return Visual
