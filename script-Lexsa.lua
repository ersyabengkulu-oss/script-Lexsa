-- V5.4: REMOTE SNIPER FIX
addToggle("AUTO BASE UPGRADE", Color3.fromRGB(0, 200, 100), function(state)
    _G.AutoBase = state
    task.spawn(function()
        while _G.AutoBase do
            pcall(function()
                -- 1. Ambil Uang (Coba semua metode: Touch & Remote)
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v.Name == "Collect" or v.Name:find("Giver") then
                        if v:IsA("TouchTransmitter") then
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
                        end
                        -- Coba tembak remote jika ada
                        local remote = v.Parent:FindFirstChildOfClass("RemoteEvent")
                        if remote then remote:FireServer() end
                    end
                end

                -- 2. Upgrade (Cari folder 'Buttons' atau 'Purchases')
                local tycoon = game.Workspace:FindFirstChild("Tycoons") or game.Workspace:FindFirstChild("Bases")
                if tycoon then
                    for _, btn in pairs(tycoon:GetDescendants()) do
                        if btn.Name == "Button" or btn:FindFirstChild("Price") then
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, btn, 0)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, btn, 1)
                        end
                    end
                end
            end)
            task.wait(0.3)
        end
    end)
end)
