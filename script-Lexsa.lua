-- V6.3: INVISIBLE LADDER (THE ULTIMATE BYPASS)
addToggle("SAFE INF JUMP", Color3.fromRGB(0, 200, 255), function(state)
    _G.GhostLadder = state
    local player = game.Players.LocalPlayer
    
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.GhostLadder then
            pcall(function()
                local char = player.Character
                local hrp = char.HumanoidRootPart
                
                -- Membuat pijakan sementara di bawah kaki
                local part = Instance.new("Part")
                part.Size = Vector3.new(4, 0.5, 4)
                part.CFrame = hrp.CFrame * CFrame.new(0, -3.2, 0)
                part.Transparency = 1 -- Tidak terlihat
                part.Anchored = true
                part.Parent = game.Workspace
                
                -- Hapus pijakan setelah 0.2 detik biar gak numpuk
                game:GetService("Debris"):AddItem(part, 0.2)
                char.Humanoid:ChangeState("Jumping")
            end)
        end
    end)
end)
