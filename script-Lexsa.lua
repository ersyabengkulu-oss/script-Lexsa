-- [[ LEXSA BUG RESEARCH - FIXED PATH ]]

local args = {
    [1] = "Business",
    [2] = "\232\158\141\229\144\136_\229\174\160\231\137\169", -- ID Tanaman kamu
    [3] = 60 -- Kita coba naikkan ke 60 untuk tes validasi
}

-- Menggunakan jalur lengkap sesuai hierarki folder di SimpleSpy
game:GetService("ReplicatedStorage").RemoteEvent.ServerRemoteEvent:FireServer(unpack(args))
