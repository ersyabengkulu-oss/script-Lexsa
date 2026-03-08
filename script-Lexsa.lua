local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Dit Waypoint Tool", "DarkTheme")

local Tab = Window:NewTab("Waypoints")
local Section = Tab:NewSection("Slot Koordinat")

-- Variabel buat nyimpen lokasi
local Pos1, Pos2, Pos3 = nil, nil, nil

-- SLOT 1
Section:NewButton("Set Pos 1 (Celah)", "Simpan titik aman saat ini", function()
    Pos1 = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    print("Slot 1 Tersimpan!")
end)

Section:NewButton("Go To 1", "Teleport balik ke Slot 1", function()
    if Pos1 then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos1
    else
        warn("Slot 1 Kosong!")
    end
end)

Section:NewLine()

-- SLOT 2
Section:NewButton("Set Pos 2", "Simpan titik kedua", function()
    Pos2 = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    print("Slot 2 Tersimpan!")
end)

Section:NewButton("Go To 2", "Teleport balik ke Slot 2", function()
    if Pos2 then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos2
    end
end)

Section:NewSection("Extra")
Section:NewButton("Refresh Character", "Reset karakter kalau stuck", function()
    game.Players.LocalPlayer.Character:BreakJoints()
end)
