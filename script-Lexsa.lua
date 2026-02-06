-- SCRIPT VERSI DIRECT PATH (LEXSA SPECIAL)
local KnitPath = game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.4.7").knit.Services

-- 1. Fungsi Auto Sell (Paling Mudah Dites)
spawn(function()
    while task.wait(5) do
        -- Jalur persis dari screenshot kamu
        KnitPath.SellingService.RF.SellJewels:InvokeServer()
        print("Mencoba Menjual...")
    end
end)

-- 2. Fungsi Auto Mine (Deteksi Jarak)
spawn(function()
    while task.wait(0.3) do
        for _, v in pairs(game.Workspace:GetChildren()) do
            -- Mencari batu dengan pola nama ID dari log kamu (misal: 10_58_5...)
            if v:IsA("Model") and v.Name:find("_") then
                local lp = game.Players.LocalPlayer
                if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (lp.Character.HumanoidRootPart.Position - v:GetModelCFrame().Position).Magnitude
                    if dist < 15 then
                        KnitPath.MiningService.RF.HitRock:InvokeServer(v.Name)
                    end
                end
            end
        end
    end
end)
