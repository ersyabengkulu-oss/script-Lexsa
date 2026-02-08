-- Script Supreme Force Grabber by Gemini
_G.ForceGrab = true

local lp = game.Players.LocalPlayer

spawn(function()
    while _G.ForceGrab do
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if root then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                -- Hanya cari DragonCannelloni
                if v.Name == "DragonCannelloni" then
                    local targetPos = v:IsA("Model") and v:GetModelCFrame().p or v.Position
                    
                    -- 1. Samperin naganya (jarak dekat)
                    if (targetPos - root.Position).Magnitude < 100 then
                        root.CFrame = CFrame.new(targetPos)
                        task.wait(0.2)
                        
                        -- 2. CARA PAMUNGKAS: Paksa trigger tombol "Pick up"
                        -- Mencari ProximityPrompt (tombol interaksi) di dalam objek naga
                        for _, prompt in pairs(v:GetDescendants()) do
                            if prompt:IsA("ProximityPrompt") then
                                fireproximityprompt(prompt) -- Fungsi sakti untuk simulasi klik
                            end
                        end
                        
                        -- 3. Tetap tembak Remote sebagai cadangan
                        game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent:FireServer({[1] = {}})
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)
