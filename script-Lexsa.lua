-- FIX AUTO COLLECT & UPGRADE (V5.3)
addToggle("AUTO BASE UPGRADE", Color3.fromRGB(0, 200, 100), function(state)
    _G.AutoBase = state
    task.spawn(function()
        while _G.AutoBase do
            pcall(function()
                -- 1. DETEKSI KOIN/CASH SECARA AGRESIF
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    -- Mencari objek yang memberikan Cash/Money (Biasanya punya TouchTransmitter)
                    if v:IsA("TouchTransmitter") and (v.Parent.Name:find("Cash") or v.Parent.Name:find("Giver") or v.Parent.Name:find("Collect")) then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
                    end
                end

                -- 2. AUTO UPGRADE SEMUA TOMBOL DI BASE
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    -- Fokus pada tombol yang memiliki harga ($) atau kata 'Buy'/'Upgrade'
                    if v:IsA("BasePart") and v.Transparency ~= 1 then 
                        if v.Name:find("Buy") or v.Name:find("Upgrade") or v:FindFirstChild("Price") or v:FindFirstChild("Cost") then
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
                        end
                    end
                end
            end)
            task.wait(0.5) -- Jeda dipercepat agar lebih instan
        end
    end)
end)
