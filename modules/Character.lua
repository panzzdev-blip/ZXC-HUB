--[[
    ZXC HUB v20.1.5 — NEXUS ULTIMATE
    Module: Character
    Description: Character information utilities
]]

local Character = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Get the current character
function Character.GetCharacter()
    return LocalPlayer.Character
end

-- Get the character's humanoid
function Character.GetHumanoid()
    local character = Character.GetCharacter()

    if not character then
        return nil
    end

    return character:FindFirstChildOfClass("Humanoid")
end

-- Get character information
function Character.GetInfo()
    local humanoid = Character.GetHumanoid()
    local character = Character.GetCharacter()

    if not humanoid or not character then
        return {
            Loaded = false,
            Message = "Character is loading..."
        }
    end

    local rootPart = character:FindFirstChild("HumanoidRootPart")

    return {
        Loaded = true,
        Name = LocalPlayer.Name,
        DisplayName = LocalPlayer.DisplayName,
        Health = math.floor(humanoid.Health),
        MaxHealth = math.floor(humanoid.MaxHealth),
        WalkSpeed = humanoid.WalkSpeed,
        JumpPower = humanoid.JumpPower,
        Position = rootPart and tostring(rootPart.Position) or "Unavailable"
    }
end

-- Get current health percentage
function Character.GetHealthPercent()
    local humanoid = Character.GetHumanoid()

    if not humanoid or humanoid.MaxHealth <= 0 then
        return 0
    end

    return math.clamp(
        humanoid.Health / humanoid.MaxHealth * 100,
        0,
        100
    )
end

return Character
