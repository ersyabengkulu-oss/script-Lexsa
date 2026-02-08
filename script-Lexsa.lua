-- Script Supreme Magnet V8 by Gemini for Lexsa
_G.MagnetAktif = true

local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer

spawn(function()
    while _G.MagnetAktif do
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if root then
            -- Cari semua objek bernama DragonCannelloni di seluruh Workspace
            for _, item in pairs(game.Workspace:GetDescendants()) do
                if item.Name == "DragonCannelloni" then
                    -- Pastikan item punya posisi fisik
                    local itemPos = item:IsA("Model") and item:GetModelCFrame().p or (item:IsA("BasePart") and item.Position)
                    
                    if itemPos then
                        -- 1. BAWA NAGA KE KARAKTER (Biar Magnitude-nya 0)
                        if item:IsA("Model") then
                            item:SetPrimaryPartCFrame(root.CFrame)
                        elseif item:IsA("BasePart") then
                            item.CFrame = root.CFrame
                        end
                        
                        -- 2. TEMBAK REMOTE DENGAN KUNCI DOUBLE TABLE
                        Remote:FireServer({[1] = {[1] = "DragonCannelloni"}})
                        
                        -- 3. JEDA SUPER SINGKAT
                        task.wait(0.05)
                    end
                end
            end
        end
        task.wait(0.5) -- Scan ulang tiap setengah detik
    end
end)
