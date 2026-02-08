-- Script Supreme Sniper V4 (Table Arg Fix) by Gemini
_G.SniperV4 = true

local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer

-- Rute lengkap yang kamu temukan (Spawn sampai Hotspot)
local RuteLengkap = {
    Vector3.new(-1115, 62, -1195), -- Titik Spawn
    Vector3.new(-1111, 62, 2465),  -- Mix Area 1
    Vector3.new(-1112, 62, 2802),  -- Mix Area 2
    Vector3.new(-1113, 62, 3007),  -- Mix Area 3
    Vector3.new(-1113, 62, 3229)   -- Supreme Area
}

spawn(function()
    while _G.SniperV4 do
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if root then
            for _, titik in pairs(RuteLengkap) do
                -- Scanning naga DragonCannelloni di tiap titik rute
                for _, obj in pairs(game.Workspace:GetDescendants()) do
                    if obj.Name == "DragonCannelloni" then
                        local objPos = obj:IsA("Model") and obj:GetModelCFrame().p or obj.Position
                        
                        -- Jika jarak naga dekat dengan titik rute
                        if (objPos - titik).Magnitude < 60 then
                            -- 1. Tempelkan karakter ke naga (Penting buat trigger Pick up!)
                            root.CFrame = CFrame.new(objPos)
                            
                            -- 2. Tembak Remote dengan ARGUMEN BARU {}
                            local args = { [1] = {} }
                            Remote:FireServer(unpack(args))
                            
                            task.wait(0.2) -- Jeda biar server nggak curiga
                        end
                    end
                end
                
                -- Pindah ke titik rute berikutnya
                root.CFrame = CFrame.new(titik)
                task.wait(0.4)
            end
        end
        task.wait(0.5)
    end
end)
