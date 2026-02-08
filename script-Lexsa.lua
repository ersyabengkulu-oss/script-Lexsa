-- Script Supreme Path Patrol by Gemini for Lexsa
_G.SupremePatrol = true

local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer

-- DAFTAR RUTE LENGKAP KAMU
local RuteSupreme = {
    Vector3.new(-1115, 62, -1195), -- Titik Awal dekat papan (Spawn)
    Vector3.new(-1111, 62, 2465),  -- Hotspot 1 (Secret/Exotic area)
    Vector3.new(-1112, 62, 2802),  -- Hotspot 2 (Exotic area)
    Vector3.new(-1113, 62, 3007),  -- Hotspot 3 (Divine area)
    Vector3.new(-1113, 62, 3229)   -- Hotspot Akhir (Supreme area)
}

spawn(function()
    while _G.SupremePatrol do
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if root then
            for _, pos in pairs(RuteSupreme) do
                -- 1. Jalan/Teleport ke tiap titik rute
                root.CFrame = CFrame.new(pos)
                task.wait(0.7) -- Berhenti sebentar untuk memproses spawn item
                
                -- 2. Cek & Ambil hanya Dragon Cannelloni (Supreme)
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v.Name == "DragonCannelloni" then
                        local itemPos = v:IsA("Model") and v:GetModelCFrame().p or v.CFrame.p
                        -- Jika naga Supreme ada di sekitar titik rute (jarak < 60)
                        if (itemPos - root.Position).Magnitude < 60 then
                            root.CFrame = CFrame.new(itemPos) -- Tabrak naganya
                            Remote:FireServer({[1] = nil})    -- Klaim via Remote
                            task.wait(0.2)
                        end
                    end
                end
            end
        end
        task.wait(1) -- Ulangi rute dari awal
    end
end)
