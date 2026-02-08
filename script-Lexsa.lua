-- Script Final Shredder V10 by Gemini for Lexsa
_G.ShredderV10 = true

local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer

-- Koordinat Hotspot Supreme kamu
local Hotspot = Vector3.new(-1113, 62, 3229) 

spawn(function()
    while _G.ShredderV10 do
        local char = lp.Character
        local myRoot = char and char:FindFirstChild("HumanoidRootPart")
        
        if myRoot then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                -- Mengincar Model DragonCannelloni
                if v.Name == "DragonCannelloni" and v:IsA("Model") then
                    -- Langsung target HumanoidRootPart sesuai Dex kamu
                    local targetRoot = v:FindFirstChild("HumanoidRootPart")
                    
                    if targetRoot then
                        -- 1. Tempelkan karakter TEPAT di titik pusat naga
                        myRoot.CFrame = targetRoot.CFrame
                        
                        -- 2. Tembak Remote dengan format Nested Table
                        Remote:FireServer({[1] = {[1] = "DragonCannelloni"}})
                        
                        -- 3. Paksa klik ProximityPrompt yang ada di model
                        for _, p in pairs(v:GetDescendants()) do
                            if p:IsA("ProximityPrompt") then
                                fireproximityprompt(p)
                            end
                        end
                        task.wait(0.1)
                    end
                end
            end
            -- Kembali ke hotspot untuk patroli naga baru
            myRoot.CFrame = CFrame.new(Hotspot)
        end
        task.wait(0.5)
    end
end)
