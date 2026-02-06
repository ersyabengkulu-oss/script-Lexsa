-- Script Auto-VIP Bypass (Learning Mode)
local waitTime = 60 -- Kita set 60 detik agar aman dari deteksi spam

while true do
    local args = {
        [1] = {
            ["Name"] = "VIP",
            ["Type"] = "Gamepas"
        }
    }

    -- Mengirim perintah ke server sesuai log SimpleSpy-mu
    game:GetService("ReplicatedStorage").Shared.Network.RemoteEvent:FireServer(unpack(args))
    
    print("Perintah VIP terkirim! Menunggu 1 menit...")
    task.wait(waitTime) 
end
