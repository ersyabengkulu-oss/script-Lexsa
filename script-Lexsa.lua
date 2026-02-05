-- LEXSA V8.0: FULL SEQUENCE BYPASS
local Net = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net

local function InstantCatch()
    pcall(function()
        -- 1. Mulai (Power 100)
        Net["RF/ChargeFishingRod"]:InvokeServer(100)
        task.wait(0.1)
        
        -- 2. Trigger Game (Penting!)
        Net["RF/RequestFishingMinigame"]:InvokeServer()
        task.wait(0.1)
        
        -- 3. Langsung Menang
        Net["RF/CatchFishCompleted"]:InvokeServer()
        print("LEXSA: Sequence Berhasil Terkirim!")
    end)
end

-- Jalankan saat tombol ditekan
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    while catching do
        InstantCatch()
        task.wait(0.5) -- Jangan terlalu cepat biar gak DC
    end
end)
