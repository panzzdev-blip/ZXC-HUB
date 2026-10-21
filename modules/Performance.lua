-- ZXC HUB v20.1.5
-- Module: Performance

local Performance = {}

function Performance.MeasureFPS()
    local RunService = game:GetService("RunService")

    local frames = 0
    local elapsed = 0
    local fps = 0

    local connection

    connection = RunService.RenderStepped:Connect(function(dt)
        frames = frames + 1
        elapsed = elapsed + dt

        if elapsed >= 0.5 then
            fps = math.floor(frames / elapsed)

            frames = 0
            elapsed = 0
        end
    end)

    return function()
        if connection then
            connection:Disconnect()
        end
    end, function()
        return fps
    end
end

return Performance
