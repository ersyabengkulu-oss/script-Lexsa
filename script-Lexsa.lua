-- 1. PENGATURAN AWAL
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- GANTI LINK DI BAWAH INI DENGAN LINK RAW KAMU!
local linkWhitelist = "ISI_LINK_RAW_WHITELIST_TXT_KAMU" 
local linkKey = "ISI_LINK_RAW_KEY_TXT_KAMU"
local linkIklan = "https://link-linkvertise-kamu.com" 

-- 2. FUNGSI MENU UTAMA (LAVA WALKING)
local function startMainScript()
    -- Copy kode menu LEXSA LAVA CORE kamu yang sudah berhasil tadi ke sini
    -- Pastikan bagian 'Parent' mengarah ke PlayerGui
    print("Menjalankan Menu Utama...") 
end

-- 3. CEK WHITELIST
local isVip = false
local successW, contentW = pcall(function() return game:HttpGet(linkWhitelist) end)
if successW and contentW:find(Player.Name) then
    isVip = true
end

if isVip then
    startMainScript() -- Langsung buka kalau dia VIP
else
    -- 4. TAMPILKAN KEY SYSTEM (Jika Bukan VIP)
    local KeyGui = Instance.new("ScreenGui", PlayerGui)
    -- ... (Masukkan semua kode KeyGui yang ada tombol CHECK dan GET KEY tadi)
    
    -- Contoh Logika Tombol CHECK:
    -- CheckBtn.MouseButton1Click:Connect(function()
    --    local successK, currentKey = pcall(function() return game:HttpGet(linkKey) end)
    --    if successK and KeyInput.Text == currentKey:gsub("%s+", "") then
    --        KeyGui:Destroy()
    --        startMainScript()
    --    end
    -- end)
end
