-- V5.7: CHAOS EXPERIMENT (FLING & LAVA GOD)
addToggle("FLING MODE", Color3.fromRGB(255, 0, 0), function(state)
    _G.Fling = state
    task.spawn(function()
        local player = game.Players.LocalPlayer
        local char = player.Character
        local hrp = char:WaitForChild("HumanoidRootPart")
        
        while _G.Fling do
            -- Eksperimen fisik: Berputar sangat cepat (Velocity Hack)
            local velocity = hrp.Velocity
            hrp.Velocity = Vector3.new(velocity.X, 0, velocity.Z) + Vector3.new(0, 1000, 0)
            task.wait(0.05)
            hrp.Velocity = velocity
            
            -- Menambahkan gaya putar agar pemain lain terpental
            local bv = Instance.new("BodyAngularVelocity")
            bv.AngularVelocity = Vector3.new(0, 999999, 0)
            bv.MaxTorque = Vector3.new(0, math.huge, 0)
            bv.P = 1250
            bv.Parent = hrp
            task.wait(0.1)
            bv:Destroy()
            task.wait()
        end
    end)
end)

-- INTEGRASI NOCLIP UNTUK KABUR KE DINDING AMAN
addToggle("GHOST ESCAPE", Color3.fromRGB(150, 0, 255), function(state)
    _G.Ghost = state
    game:GetService("RunService").Stepped:Connect(function()
        if _G.Ghost then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)
