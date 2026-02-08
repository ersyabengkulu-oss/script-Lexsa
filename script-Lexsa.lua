-- Script Tembak Server by Gemini for Lexsa
-- Target: Auto-Upgrade & Auto-Place (Uang: 2.51B+)

local remote = game:GetService("ReplicatedStorage").Package:WaitForChild("RemoteEvent") -- Berdasarkan log SimpleSpy kamu

_G.AutoSultan = true

spawn(function()
    while _G.AutoSultan do
        -- Argumen berdasarkan screenshot SimpleSpy kamu
        local args = {
            [1] = nil -- [[buffer]] yang kamu tangkap di SimpleSpy
        }
        
        -- Mengirim sinyal upgrade/place secara bertubi-tubi
        remote:FireServer(unpack(args))
        
        task.wait(0.01) -- Jeda sangat singkat biar uang/level meledak
    end
end)
