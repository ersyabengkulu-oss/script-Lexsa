-- [[ LEXSA AUTO REBIRTH PROOF ]]

_G.AutoRebirth = true -- Ubah ke false untuk berhenti

spawn(function()
    while _G.AutoRebirth do
        local args = {
            [1] = "Rebirth" -- Perintah dari SimpleSpy kamu
        }
        
        -- Jalur RemoteEvent yang sudah kita perbaiki
        game:GetService("ReplicatedStorage").RemoteEvent.ServerRemoteEvent:FireServer(unpack(args))
        
        print("Mencoba Rebirth Otomatis...")
        task.wait(2) -- Jeda agar tidak langsung ditendang server
    end
end)
