-- V5.5: SMART PATHFINDER (AUTO-WALK TO BUTTONS)
addToggle("AUTO WALK UPGRADE", Color3.fromRGB(0, 150, 255), function(state)
    _G.AutoWalk = state
    task.spawn(function()
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local hum = char:WaitForChild("Humanoid")
        
        while _G.AutoWalk do
            pcall(function()
                -- Cari tombol upgrade terdekat yang terlihat
                local target = nil
                local dist = math.huge
                
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v:IsA("BasePart") and (v.Name:find("Buy") or v.Name:find("Upgrade") or v.Name == "Collect") and v.Transparency ~= 1 then
                        local d = (char.HumanoidRootPart.Position - v.Position).Magnitude
                        if d < dist then
                            dist = d
                            target = v
                        end
                    end
                end
                
                -- Berjalan otomatis ke target
                if target and dist < 100 then
                    hum:MoveTo(target.Position)
                    -- Tunggu sampai sampai atau target hilang
                    repeat task.wait(0.1) until (char.HumanoidRootPart.Position - target.Position).Magnitude < 4 or not _G.AutoWalk
                end
            end)
            task.wait(1)
        end
    end)
end)
