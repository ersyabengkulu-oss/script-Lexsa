local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Lexsa Multi-Waypoints", "DarkTheme")

-- Tab Simpan
local TabSet = Window:NewTab("SET (Simpan)")
local SetSection = TabSet:NewSection("Klik untuk Simpan Posisi")

-- Tab Pindah
local TabGo = Window:NewTab("TELE (Pindah)")
local GoSection = TabGo:NewSection("Klik untuk Teleport")

local Positions = {}

-- Bikin 5 Slot
for i = 1, 5 do
    SetSection:NewButton("Amankan Slot "..i, "Simpan koordinat sekarang", function()
        Positions[i] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        Library:Notify("Lexsa", "Slot "..i.." Berhasil Disimpan!", 2)
    end)

    GoSection:NewButton("Balik ke Slot "..i, "Pindah ke titik "..i, function()
        if Positions[i] then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Positions[i]
        else
            Library:Notify("Gagal", "Isi dulu slot "..i.." di Tab SET!", 2)
        end
    end)
end

-- FITUR TUTUP/BUKA (Toggle)
local TabTutup = Window:NewTab("TUTUP")
local TutupSection = TabTutup:NewSection("Pengaturan Menu")

TutupSection:NewKeybind("Buka/Tutup Menu", "Pencet P untuk sembunyiin", Enum.KeyCode.P, function()
	Library:ToggleLib()
end)

-- Biar gak cape nulis, ini otomatis bikin tombol melayang di HP
-- Jadi kalau menu ditutup, ada tombol kecil buat buka lagi
