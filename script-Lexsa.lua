-- Script Supreme Only Station by Gemini for Lexsa
_G.SupremeOnly = true

local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer
local TargetPos = Vector3.new(-1111, 62, 3232) 

spawn(function()
    while _G.SupremeOnly do
        local char = lp.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            -- Tetap kunci posisi di koordinat harta karun
            char.HumanoidRootPart.CFrame = CFrame.new(TargetPos)
            
            -- Scan area sekitar koordinat untuk mencari DragonCannelloni saja
            for _, v in pairs(game.Workspace:GetDescendants()) do
                -- Filter ketat: Hanya ambil yang namanya DragonCannelloni
                if v.Name == "DragonCannelloni" then
                    -- Cek jarak antara item dengan kamu (biar nggak narik dari base)
                    local dist = (v:GetModelCFrame().p - TargetPos).Magnitude
                    if dist < 50 then 
                        local args = {[1] = nil}
                        Remote:FireServer(unpack(args))
                    end
                end
            end
        end
        task.wait(0.2) -- Kecepatan tinggi untuk menyaring item yang spawn
    end
end)

print("Target Terkunci: Hanya DragonCannelloni (Supreme)!")
