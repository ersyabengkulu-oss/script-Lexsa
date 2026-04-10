-- LEXSA (4663) PROJECT - RESEARCH ONLY
-- Purpose: Game Analysis & Bug Testing

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LEXSA RESEARCH HUB", "DarkScene")

-- Tab Utama: Informasi
local Tab1 = Window:NewTab("Status")
local Section1 = Tab1:NewSection("Research In Progress")

Section1:NewLabel("Current Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
Section1:NewLabel("Dev Status: Beta Testing")

-- Tab Fitur (Bukti Logika Work)
local Tab2 = Window:NewTab("Tools")
local Section2 = Tab2:NewSection("Detection Tools")

Section2:NewButton("Print Remote Events", "Scanning for bugs...", function()
    print("LEXSA SCANNER: Scanning for active remotes...")
    -- Di sini lo pamer lo paham RemoteEvent
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            print("Found Remote: " .. v.Name)
        end
    end
end)

Section2:NewSlider("Walkspeed Test", "Testing Character Physics", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

-- Tab Credit
local Tab3 = Window:NewTab("Credits")
Tab3:NewSection("Developer: LEXSA (4663)")
Tab3:NewSection("Portfolio: github.com/ersyabengkulu-oss")
