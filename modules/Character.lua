-- ZXC HUB v20.1.5
-- Module: Character

local Character = {}

function Character.GetInfo()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    if not player then
        return nil
    end

    local character = player.Character

    if not character then
        return {
            Name = player.Name,
            State = "Character not loaded"
        }
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")

    return {
        Name = player.Name,
        State = "Loaded",
        Health = humanoid and humanoid.Health or 0,
        MaxHealth = humanoid and humanoid.MaxHealth or 0
    }
end

return Character
