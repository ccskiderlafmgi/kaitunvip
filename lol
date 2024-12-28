local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "FPSCounterGUI"

local fpsLabel = Instance.new("TextLabel", screenGui)
fpsLabel.Size = UDim2.new(0, 200, 0, 50) 
fpsLabel.Position = UDim2.new(0.5, -100, 0.1, 0) 
fpsLabel.AnchorPoint = Vector2.new(0.5, 0) 
fpsLabel.TextScaled = true
fpsLabel.BackgroundTransparency = 1
fpsLabel.Font = Enum.Font.SourceSansBold
fpsLabel.TextColor3 = Color3.new(1, 1, 1) 

local lastUpdate = tick()
local frameCount = 0

RunService.RenderStepped:Connect(function(deltaTime)
    frameCount = frameCount + 1
    local currentTime = tick()
    if currentTime - lastUpdate >= 1 then
        local fps = frameCount / (currentTime - lastUpdate)
        lastUpdate = currentTime
        frameCount = 0

        fpsLabel.Text = string.format("FPS: %.0f", fps)

        if fps < 20 then
            fpsLabel.TextColor3 = Color3.new(1, 0, 0) 
        else
            fpsLabel.TextColor3 = Color3.new(0, 1, 0) 
        end
    end
end)
