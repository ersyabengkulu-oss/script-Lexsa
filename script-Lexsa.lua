-- V5.6: WALL BREAKER & ESCAPE
addToggle("NOCLIP WALL", Color3.fromRGB(150, 0, 255), function(state)
    _G.Noclip = state
    game:GetService("RunService").Stepped:Connect(function()
        if _G.Noclip then
            pcall(function()
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end)
        end
    end)
end)

addToggle("AUTO WALL ESCAPE", Color3.fromRGB(0, 255, 100), function(state)
    _G.WallEscape = state
    task.spawn(function()
        while _G.WallEscape do
            pcall(function()
                -- Cek jika lava mulai naik (biasanya ada objek 'Lava' yang posisinya naik)
                local lava = game.Workspace:FindFirstChild("Lava", true)
                if lava and lava.Position.Y > -10 then 
                    -- Teleport ke koordinat aman di balik dinding yang kamu temukan
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-45, 10, 50) -- Koordinat area hijau
                end
            end)
            task.wait(2)
        end
    end)
end)
