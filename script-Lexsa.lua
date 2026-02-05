-- V5.8: SILENT FLING (BIAR GAK CURIGA)
addToggle("SILENT KICK", Color3.fromRGB(50, 50, 50), function(state)
    _G.SilentFling = state
    task.spawn(function()
        while _G.SilentFling do
            pcall(function()
                local player = game.Players.LocalPlayer
                local char = player.Character
                local hrp = char.HumanoidRootPart
                
                -- Cari pemain terdekat dalam jarak 5 meter
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local targetHRP = v.Character.HumanoidRootPart
                        local dist = (hrp.Position - targetHRP.Position).Magnitude
                        
                        if dist < 7 then -- Jarak tendangan
                            -- Berikan gaya dorong instan tanpa memutar badan kita
                            local velocity = Instance.new("BodyVelocity")
                            velocity.Velocity = (targetHRP.Position - hrp.Position).Unit * 150 + Vector3.new(0, 50, 0)
                            velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                            velocity.Parent = targetHRP
                            task.wait(0.1)
                            velocity:Destroy()
                        end
                    end
                end
            end)
            task.wait(0.1)
        end
    end)
end)
