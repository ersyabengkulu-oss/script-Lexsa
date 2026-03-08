local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
-- Bikin Window dengan posisi di tengah layar
local Window = Library.CreateLib("Lexsa Multi-Waypoints", "DarkTheme")

-- Tab khusus buat simpan koordinat
local TabSet = Window:NewTab("SET POSISI")
local SetSection = TabSet:NewSection("Pencet buat simpan titik aman")

-- Tab khusus buat pindah tempat
local TabGo = Window:NewTab("TELEPORT")
local GoSection = TabGo:NewSection("Pencet buat balik ke titik tadi")

local Positions = {}

-- Bikin 5 Slot otomatis biar rapi
for i = 1, 5 do
    SetSection:NewButton("Simpan Titik Slot "..i, "Tandai tempat ini", function()
        Positions[i] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        Library:Notify("Lexsa Info", "Slot "..i.." Berhasil Disimpan!", 2)
    end)

    GoSection:NewButton("Balik ke Slot "..i, "Teleport sekarang", function()
        if Positions[i] then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Positions[i]
        else
            Library:Notify("Gagal", "Simpan posisi dulu di tab SET!", 2)
        end
    end)
end

-- Tab buat buka tutup GUI
local TabTutup = Window:NewTab("TUTUP")
local TutupSection = TabTutup:NewSection("Klik 'Sembunyikan' buat hide menu")
TutupSection:NewKeybind("Sembunyikan Menu", "Pencet P atau klik toggle", Enum.KeyCode.P, function()
    Library:ToggleLib()
end)
