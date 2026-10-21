--[[
    ZXC HUB v20.1.5
    Module: Performance
    Purpose: Client-side performance utilities
]]

local Performance = {}

function Performance.GetFPSMonitor()
    local RunService = game:GetService("RunService")

    local monitor = {
        FPS = 0,
        FrameTime = 0,
        _frames = 0,
        _elapsed = 0,
        _connection = nil
    }

    function monitor:Start(callback)
        if self._connection then
            self._connection:Disconnect()
        end

        self._frames = 0
        self._elapsed = 0

        self._connection = RunService.RenderStepped:Connect(function(deltaTime)
            self._frames += 1
            self._elapsed += deltaTime

            if self._elapsed >= 1 then
                self.FPS = math.floor(self._frames / self._elapsed + 0.5)
                self.FrameTime = self._elapsed / self._frames * 1000

                self._frames = 0
                self._elapsed = 0

                if callback then
                    callback(self.FPS, self.FrameTime)
                end
            end
        end)
    end

    function monitor:Stop()
        if self._connection then
            self._connection:Disconnect()
            self._connection = nil
        end
    end

    return monitor
end

function Performance.GetDeviceInfo()
    local UserInputService = game:GetService("UserInputService")

    return {
        TouchEnabled = UserInputService.TouchEnabled,
        KeyboardEnabled = UserInputService.KeyboardEnabled,
        GamepadEnabled = UserInputService.GamepadEnabled
    }
end

return Performance
