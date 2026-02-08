-- Script Supreme Collector V6 by Gemini for Lexsa
_G.FinalCollector = true

local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer

local RutePatroli = {
    Vector3.new(-1115, 62, -1195),
    Vector3.new(-1111, 62, 2465), 
    Vector3.new(-1112, 62, 2802),
    Vector3.new(-1113, 62, 3007),
    Vector3.new(-1113, 62, 3229)
}

spawn(function()
    while _G.FinalCollector do
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if root then
            for _, pos in pairs(RutePatroli) do
                root.CFrame = CFrame.new(pos)
                task.wait(0.4)
                
                -- Mencari objek DragonCannelloni secara mendalam
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v.Name == "DragonCannelloni" then
                        -- Ambil posisi objek (baik Model atau Part)
                        local targetPos = v:IsA("Model") and v:GetModelCFrame().p or (v:IsA("BasePart") and v.Position)
                        
                        if targetPos and (targetPos - root.Position).Magnitude < 70 then
                            -- 1. Pindah TEPAT ke posisi item
                            root.CFrame = CFrame.new(targetPos)
                            
                            -- 2. Kirim sinyal ambil (Sesuai log SimpleSpy paling baru)
                            -- Kita coba kirim String dan Tabel sekaligus jika salah satu gagal
                            Remote:FireServer("DragonCannelloni") 
                            task.wait(0.1)
                            Remote:FireServer({[1] = "DragonCannelloni"})
                            
                            -- 3. Hapus item secara lokal (Biar tidak nge-lag/stuck di layar)
                            -- v:Destroy() -- Opsional: Hilangkan ini jika ingin melihat itemnya hilang secara server
                            
                            task.wait(0.2)
                        end
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)
