-- Script Supreme God Mode by Gemini for Lexsa
_G.GodCollect = true

local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer

local Rute = {
    Vector3.new(-1115, 62, -1195),
    Vector3.new(-1111, 62, 2465), 
    Vector3.new(-1112, 62, 2802),
    Vector3.new(-1113, 62, 3007),
    Vector3.new(-1113, 62, 3229)
}

spawn(function()
    while _G.GodCollect do
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if root then
            for _, pos in pairs(Rute) do
                root.CFrame = CFrame.new(pos)
                task.wait(0.3)
                
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v.Name == "DragonCannelloni" then
                        local itemPos = v:IsA("Model") and v:GetModelCFrame().p or v.Position
                        
                        if (itemPos - root.Position).Magnitude < 80 then
                            -- 1. GESEKAN FISIK: Maju mundur dikit biar TouchInterest ke-trigger
                            root.CFrame = CFrame.new(itemPos) * CFrame.new(0, 0, 1)
                            task.wait(0.05)
                            root.CFrame = CFrame.new(itemPos)
                            
                            -- 2. BOMBARDIR REMOTE (Dua jenis argumen sekaligus!)
                            -- Tipe A: Nested Table
                            Remote:FireServer({[1] = "DragonCannelloni"}) 
                            
                            -- Tipe B: String Langsung
                            Remote:FireServer("DragonCannelloni")
                            
                            -- 3. Trigger ProximityPrompt secara paksa
                            for _, p in pairs(v:GetDescendants()) do
                                if p:IsA("ProximityPrompt") then fireproximityprompt(p) end
                            end
                            task.wait(0.1)
                        end
                    end
                end
            end
        end
        task.wait(0.4)
    end
end)
