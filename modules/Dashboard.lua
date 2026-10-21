
-- ZXC HUB v20.1.5
-- Module: Dashboard

local Dashboard = {}

function Dashboard.GetInfo()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    return {
        Name = "ZXC HUB",
        Version = "20.1.5",
        Edition = "NEXUS ULTIMATE",
        Player = player and player.Name or "Unknown",
        Status = "Running"
    }
end

function Dashboard.Create(parent, theme)
    local label = Instance.new("TextLabel")

    label.Name = "Dashboard"
    label.Size = UDim2.new(1, -20, 0, 70)
    label.BackgroundColor3 = theme.Panel
    label.TextColor3 = theme.Text
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextWrapped = true

    local info = Dashboard.GetInfo()

    label.Text = string.format(
        "%s v%s\n%s\nPlayer: %s",
        info.Name,
        info.Version,
        info.Edition,
        info.Player
    )

    label.Parent = parent

    return label
end

return Dashboard
