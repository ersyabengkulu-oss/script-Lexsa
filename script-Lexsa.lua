-- ==========================================
-- SUPER MINING & EGG HUNTER - LEXSA EDITION
-- ==========================================

local KnitServices = game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.4.7").knit.Services
local MiningRemote = KnitServices.MiningService.RF.HitRock
local EggRemote = KnitServices.EggService.RF.PickUpEgg
local SellRemote = KnitServices.SellingService.RF.SellJewels

_G.Active = true

-- 1. AUTO MINING (Mencari Batu Terdekat)
spawn(function()
    while _G.Active do
        task.wait(0.15) -- Jeda pukul biar aman dari ban
        for _, v in pairs(game.Workspace:GetChildren()) do
            if v:IsA("Model") and v.Name:find("_") then
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local dist = (char.HumanoidRootPart.Position - v:GetModelCFrame().Position).Magnitude
                    if dist < 15 then 
                        MiningRemote:InvokeServer(v.Name)
                    end
                end
            end
        end
    end
end)

-- 2. AUTO PICKUP EGG (Otomatis Ambil Telur Diamond/Mythic)
spawn(function()
    while _G.Active do
        task.wait(0.5)
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v.Name:find("Egg") and v:IsA("BasePart") then
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local dist = (char.HumanoidRootPart.Position - v.Position).Magnitude
                    if dist < 20 then
                        EggRemote:InvokeServer(v.Name)
                    end
                end
            end
        end
    end
end)

-- 3. AUTO SELL (Otomatis Jual Tiap 10 Detik)
spawn(function()
    while _G.Active do
        task.wait(10)
        SellRemote:InvokeServer()
    end
end)

-- 4. ESP TELUR (Agar Telur Kelihatan di Balik Dinding)
local function applyESP(object)
    if not object:FindFirstChild("Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Parent = object
        highlight.FillTransparency = 0.4
        highlight.FillColor = object.Name:find("Diamond") and Color3.new(0, 1, 1) or Color3.new(1, 1, 0)
    end
end

for _, v in pairs(game.Workspace:GetDescendants()) do
    if v.Name:find("Egg") then applyESP(v) end
end

game.Workspace.DescendantAdded:Connect(function(v)
    if v.Name:find("Egg") then task.wait(0.2) applyESP(v) end
end)

print("Semua Fitur Aktif! Selamat menambang, Lexsa.")
