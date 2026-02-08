-- Script Supreme Sniper by Gemini for Lexsa
_G.SniperAktif = true

local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer

local RuteLengkap = {
    Vector3.new(-1115, 62, -1195),
    Vector3.new(-1111, 62, 2465), 
    Vector3.new(-1112, 62, 2802),
    Vector3.new(-1113, 62, 3007),
    Vector3.new(-1113, 62, 3229)
}

spawn(function()
    while _G.SniperAktif do
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if root then
            for _, titik in pairs(RuteLengkap) do
                -- Langsung cek apakah ada naga di sekitar titik ini SEBELUM teleport
                local nagaDitemukan = false
                for _, obj in pairs(game.Workspace:GetDescendants()) do
                    if obj.Name == "DragonCannelloni" then
                        local objPos = obj:IsA("Model") and obj:GetModelCFrame().p or obj.Position
                        if (objPos - titik).Magnitude < 50 then
                            -- Oke ada naga! Baru kita samperin
                            root.CFrame = CFrame.new(objPos)
                            Remote:FireServer({[1] = nil})
                            task.wait(0.2)
                            nagaDitemukan = true
                        end
                    end
                end
                
                -- Kalau tidak ada naga, lari ke titik rute berikutnya buat jaga-jaga
                if not nagaDitemukan then
                    root.CFrame = CFrame.new(titik)
                    task.wait(0.3)
                end
            end
        end
        task.wait(0.5)
    end
end)
