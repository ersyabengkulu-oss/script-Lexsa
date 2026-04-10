local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LEXSA ANALYST & COMBAT", "DarkScene")

-- TAB 1: ANALYST (Buat Portofolio Bug Hunter)
local Tab1 = Window:NewTab("Analyst")
local Sec1 = Tab1:NewSection("Bug Hunting Tools")

Sec1:NewButton("Scan Remote Events", "Cek celah keamanan", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            print("Found: " .. v.Name .. " | Path: " .. v:GetFullName())
        end
    end
end)

-- TAB 2: COMBAT (Buat Pamer Fungsi Work)
local Tab2 = Window:NewTab("Combat")
local Sec2 = Tab2:NewSection("Auto Aim & ESP")

Sec2:NewToggle("Enable ESP", "Liat musuh tembus tembok", function(state)
    _G.ESP = state
    while _G.ESP do
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Name ~= game.Players.LocalPlayer.Name and v.Character and not v.Character:FindFirstChild("Highlight") then
                local hl = Instance.new("Highlight", v.Character)
                hl.FillColor = Color3.fromRGB(255, 0, 0)
            end
        end
        wait(1)
        if not _G.ESP then 
            for _, v in pairs(game.Players:GetPlayers()) do
                if v.Character and v.Character:FindFirstChild("Highlight") then v.Character.Highlight:Destroy() end
            end
        end
    end
end)

Sec2:NewButton("Trigger Auto Aim", "Kunci target terdekat", function()
    local target = nil
    local dist = math.huge
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local d = (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then dist = d target = v end
        end
    end
    if target then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.HumanoidRootPart.Position) end
end)
