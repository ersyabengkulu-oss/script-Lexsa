-- LEXSA V7.6: THE MIRROR MODE
pcall(function()
    local RS = game:GetService("ReplicatedStorage")
    -- Kita ambil remotenya langsung dari memory
    local catch = RS:FindFirstChild("CatchFishComplete", true)
    
    -- Kita paksa kirim sinyal 'Selesai' berkali-kali
    for i = 1, 5 do
        task.spawn(function()
            catch:InvokeServer(true)
        end)
    end
end)
