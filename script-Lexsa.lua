-- Script Dragon Tamer V9 by Gemini for Lexsa
_G.TamerV9 = true

local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer

-- Gunakan koordinat hotspot Supreme yang kamu temukan
local Hotspot = Vector3.new(-1111, 62, 3232) 

spawn(function()
    while _G.TamerV9 do
        local char = lp.Character
        local myRoot = char and char:FindFirstChild("HumanoidRootPart")
        
        if myRoot then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                -- Mencari Model DragonCannelloni sesuai Dex kamu
                if v.Name == "DragonCannelloni" and v:IsA("Model") then
                    local targetPart = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChildWhichIsA("BasePart")
                    
                    if targetPart then
                        -- 1. Tempelkan karakter TEPAT ke pusat model naga
                        myRoot.CFrame = targetPart.CFrame
                        
                        -- 2. Tembak Remote dengan NESTED TABLE terbaru
                        Remote:FireServer({[1] = {[1] = "DragonCannelloni"}})
                        
                        -- 3. Paksa Trigger ProximityPrompt di dalam model
                        for _, prompt in pairs(v:GetDescendants()) do
                            if prompt:IsA("ProximityPrompt") then
                                fireproximityprompt(prompt)
                            end
                        end
                        task.wait(0.2)
                    end
                end
            end
            -- Kembali ke hotspot untuk patroli
            myRoot.CFrame = CFrame.new(Hotspot)
        end
        task.wait(0.5)
    end
end)
