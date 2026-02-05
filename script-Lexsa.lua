-- V5.5: THE GHOST WALKER (TELEPORT AUTO-BUY)
addToggle("AUTO BASE UPGRADE", Color3.fromRGB(200, 0, 0), function(state)
    _G.GhostWalk = state
    task.spawn(function()
        local char = game.Players.LocalPlayer.Character
        local hrp = char:WaitForChild("HumanoidRootPart")
        
        while _G.GhostWalk do
            pcall(function()
                -- Cari semua tombol di sekitar base
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v:IsA("BasePart") and v.Transparency ~= 1 then
                        if v.Name:find("Buy") or v.Name:find("Upgrade") or v.Name == "Collect" then
                            -- Teleport sekejap ke tombol buat "paksa" sentuhan
                            local oldPos = hrp.CFrame
                            hrp.CFrame = v.CFrame
                            task.wait(0.05) -- Berkedip 0.05 detik
                            hrp.CFrame = oldPos
                        end
                    end
                end
            end)
            task.wait(1)
        end
    end)
end)
