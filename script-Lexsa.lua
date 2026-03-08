local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Lexsa Multi-Waypoints", "DarkTheme")

local Tab = Window:NewTab("Waypoints")
local Section = Tab:NewSection("Slot Koordinat (1-5)")

-- Penyimpanan Koordinat
local Positions = {}

-- Fitur Buka/Tutup GUI (Biar gak ngalangin)
-- Tekan tombol 'P' di keyboard atau cari tombol melayang di layar HP
Library:CreateConfigSystem("LexsaConfig")

-- Fungsi bikin 5 Slot Otomatis
for i = 1, 5 do
    Section:NewButton("Set Pos "..i, "Simpan posisi ke slot "..i, function()
        Positions[i] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        Library:Notify("Lexsa Tool", "Slot "..i.." Berhasil Disimpan!", 3)
    end)

    Section:NewButton("Teleport ke Slot "..i, "Balik ke posisi "..i, function()
        if Positions[i] then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Positions[i]
        else
            Library:Notify("Peringatan", "Slot "..i.." masih kosong!", 3)
        end
    end)
    Section:NewLine()
end

-- Tombol buat sembunyiin GUI
local Misc = Window:NewTab("Settings")
local MiscSection = Misc:NewSection("Controls")
MiscSection:NewKeybind("Buka/Tutup Menu", "Pencet tombol ini buat hide GUI", Enum.KeyCode.P, function()
	Library:ToggleLib()
end)
