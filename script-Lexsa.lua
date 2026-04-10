local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- GANTI KE DarkTheme
local Window = Library.CreateLib("LEXSA RESEARCH HUB", "DarkTheme")

-- Tab Utama: Informasi
local Tab1 = Window:NewTab("Status")
local Section1 = Tab1:NewSection("Research In Progress")

-- Ganti NewLabel jadi NewButton (karena NewLabel gak exist di Kavo ini)
Section1:NewButton("Current Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, "", function() end)
Section1:NewButton("Dev Status: Beta Testing", "", function() end)

-- Tab Fitur
local Tab2 = Window:NewTab("Tools")
local Section2 = Tab2:NewSection("Detection Tools")

Section2:NewButton("Print Remote Events", "Scanning for bugs...", function()
    print("LEXSA SCANNER: Scanning for active remotes...")
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
local Section3 = Tab3:NewSection("Developer: LEXSA (4663)")
Section3:NewButton("Portfolio: github.com/ersyabengkulu-oss", "", function() end)
