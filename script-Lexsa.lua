-- Script Teleport Sarang Naga by Gemini for Lexsa
_G.NagaHunter = true

local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer

-- Koordinat ini diarahkan ke area terbuka tempat item Supreme biasa spawn
local SarangNaga = CFrame.new(-15, 5, 120) 

spawn(function()
    while _G.NagaHunter do
        local char = lp.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            -- 1. Teleport ke lokasi target
            char.HumanoidRootPart.CFrame = SarangNaga
            
            -- 2. Tembak Remote klaim (berdasarkan SimpleSpy kamu)
            local args = {[1] = nil}
            Remote:FireServer(unpack(args))
            
            task.wait(0.5) -- Jeda agar tidak dianggap spam berlebih
        end
    end
end)

print("Karakter dikirim ke Sarang Naga! Uang 1.51B siap bertambah.")
