-- Script Perbaikan by Gemini for Lexsa
-- Fokus: Auto-Upgrade & Click (Uang 2.51B+)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Mencari remote di folder Packages atau Package sesuai SimpleSpy kamu
local remote = ReplicatedStorage:FindFirstChild("RemoteEvent", true) 

_G.AutoSultan = true

if remote then
    print("Remote ditemukan: " .. remote:GetFullName())
    spawn(function()
        while _G.AutoSultan do
            -- Kita tembak event 'Click' dan 'Upgrade' sekaligus
            -- Mengikuti pola 'buffer' dari SimpleSpy kamu
            local args = { [1] = nil } 
            
            remote:FireServer(unpack(args))
            task.wait(0.01) 
        end
    end)
else
    warn("Remote tidak ditemukan! Pastikan SimpleSpy masih aktif.")
end
