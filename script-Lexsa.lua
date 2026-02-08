-- Script Final Dragon Vacuum by Gemini for Lexsa
_G.AutoCollect = true

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
    while _G.AutoCollect do
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if root then
            for _, pos in pairs(Rute) do
                root.CFrame = CFrame.new(pos)
                task.wait(0.3)
                
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    -- Fokus HANYA ke DragonCannelloni
                    if v.Name == "DragonCannelloni" then
                        local itemPos = v:IsA("Model") and v:GetModelCFrame().p or v.Position
                        
                        if (itemPos - root.Position).Magnitude < 70 then
                            -- 1. Tempelkan karakter TEPAT di item agar tombol Pick up muncul
                            root.CFrame = CFrame.new(itemPos)
                            
                            -- 2. Tembak SEMUA variasi Remote dari log kamu
                            Remote:FireServer("DragonCannelloni") -- Argumen String
                            Remote:FireServer({[1] = "DragonCannelloni"}) -- Argumen Table
                            
                            -- 3. Paksa klik ProximityPrompt (jika ada)
                            for _, p in pairs(v:GetDescendants()) do
                                if p:IsA("ProximityPrompt") then fireproximityprompt(p) end
                            end
                            
                            task.wait(0.1)
                        end
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)
