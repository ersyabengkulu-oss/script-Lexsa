local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Lexsa Multi-Waypoints", "DarkTheme")

local Tab = Window:NewTab("Waypoints")
local Section = Tab:NewSection("Slot Koordinat (1-5)")

-- Penyimpanan Koordinat
local Positions = {}

-- Fungsi buat bikin tombol otomatis biar gak panjang kodingannya
local function CreateWaypoint(slotName, slotIndex)
    Section:NewButton("Set Pos "..slotIndex.." ("..slotName..")", "Simpan posisi ke slot "..slotIndex, function()
        Positions[slotIndex] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        Library:Notify("Lexsa Tool", "Slot "..slotIndex.." Berhasil Disimpan!", 3)
    end)

    Section:NewButton("Teleport ke Slot "..slotIndex, "Balik ke posisi "..slotIndex, function()
        if Positions[slotIndex] then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Positions[slotIndex]
        else
            Library:Notify("Peringatan", "Slot "..slotIndex.." belum diisi, Dit!", 3)
        end
    end)
    Section:NewLine()
end

-- Bikin 5 Slot Otomatis
for i = 1, 5 do
    CreateWaypoint("Slot "..i, i)
end

Section:NewSection("Sobat Ronda Menu")
Section:NewButton("Anti-AFK", "Biar gak ke-kick pas farm", function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
    Library:Notify("Lexsa Tool", "Anti-AFK Aktif!", 3)
end)
