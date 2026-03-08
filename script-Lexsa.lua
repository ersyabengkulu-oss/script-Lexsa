local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Lexsa Multi-Waypoints", "DarkTheme")

-- Tab Khusus Simpan
local TabSet = Window:NewTab("SET (Simpan)")
local SetSection = TabSet:NewSection("Klik untuk Simpan Titik Aman")

-- Tab Khusus Teleport
local TabGo = Window:NewTab("TELE (Pindah)")
local GoSection = TabGo:NewSection("Klik untuk Teleport Balik")

local Positions = {}

-- Fungsi Bikin 5 Slot
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

-- FITUR BUKA TUTUP (Toggle)
local TabSettings = Window:NewTab("TUTUP")
local SettSection = TabSettings:NewSection("Buka/Tutup Menu")
SettSection:NewKeybind("Sembunyikan Menu", "Tekan P atau klik ini", Enum.KeyCode.P, function()
	Library:ToggleLib()
end)

-- Tombol Melayang Otomatis (Buat Mobile)
-- Jika GUI ngalangin, pencet tombol Settings tadi atau tekan P
