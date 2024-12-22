-- Function to reduce graphics, remove objects, and character outfit or delete the character
function extremeGraphicsReduction()
    local Lighting = game:GetService("Lighting")
    local Terrain = workspace:FindFirstChildOfClass("Terrain")
    local player = game.Players.LocalPlayer

    -- Disable or reduce lighting effects
    Lighting.GlobalShadows = false
    Lighting.Brightness = 1
    Lighting.ClockTime = 14 -- Set daytime lighting
    Lighting.FogEnd = 500 -- Reduce the fog distance more aggressively

    -- Lower the quality of terrain
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1 -- Make water almost invisible
        Terrain.WaterWaveSpeed = 0
    end

    -- Turn off graphical effects for all characters
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            for _, descendant in pairs(v.Character:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false
                end
            end
        end
    end

    -- Remove trees, plants, rocks, and other decorations from the map
    local objectsToRemove = {"Tree", "Plant", "Bush", "Rock", "Decoration", "PalmTree", "Flower", "Grass"} -- Add more names as needed

    for _, object in pairs(workspace:GetDescendants()) do
        for _, objName in pairs(objectsToRemove) do
            if object:IsA("Model") and object.Name:find(objName) then
                object:Destroy() -- Remove unnecessary objects
            end
        end
    end

    -- Lower detail for all objects in the workspace
    for _, object in pairs(workspace:GetDescendants()) do
        if object:IsA("BasePart") or object:IsA("UnionOperation") then
            object.Material = Enum.Material.Plastic
            object.Reflectance = 0
        end
    end

    -- Remove player's outfit or delete the character
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        -- Option 1: Remove clothes and accessories
        for _, accessory in pairs(player.Character:GetChildren()) do
            if accessory:IsA("Accessory") or accessory:IsA("Clothing") then
                accessory:Destroy()
            end
        end

        -- Option 2: Delete the entire character (uncomment to use)
        -- player.Character:Destroy() -- Completely removes the character model
    end

    -- Set quality level to the lowest
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end

-- Run the function to apply the changes
extremeGraphicsReduction()
