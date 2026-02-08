-- Script Supreme Magnet by Gemini for Lexsa
_G.MagnetAktif = true

local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer

print("Memulai Magnet Supreme...")

spawn(function()
    while _G.MagnetAktif do
        pcall(function()
            -- Scan semua objek yang ada di game
            for _, item in pairs(game.Workspace:GetDescendants()) do
                -- Nama harus persis seperti di Dex kamu
                if item.Name == "DragonCannelloni" then
                    local char = lp.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        -- Teleport langsung ke koordinat naga
                        char.HumanoidRootPart.CFrame = item:GetModelCFrame() or item.CFrame
                        
                        -- Tembak RemoteEvent yang kamu tangkap di SimpleSpy
                        local args = {[1] = nil}
                        Remote:FireServer(unpack(args))
                        
                        task.wait(0.3) -- Jeda klaim
                    end
                end
            end
        end)
        task.wait(1)
    end
end)
