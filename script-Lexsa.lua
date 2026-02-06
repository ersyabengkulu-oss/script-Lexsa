local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- FUNGSI CEK WHITELIST DARI GITHUB
local function isWhitelisted()
    local success, content = pcall(function()
        return game:HttpGet("LINK_RAW_WHITELIST_TXT_KAMU") -- Ganti dengan link raw whitelist.txt
    end)
    if success and content:find(Player.Name) then
        return true
    end
    return false
end

-- LOGIKA PEMBAGIAN AKSES
if isWhitelisted() then
    print("Akses Whitelist Diterima! Halo Bos Lexsa.")
    -- Masukkan fungsi menu LAVA WALKING kamu di sini
else
    print("User Biasa. Menampilkan Key System...")
    -- Tampilkan KeyGui (Sistem Key Linkvertise) yang kita buat tadi
end
