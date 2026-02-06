-- [[ LEXSA V8 - SPEED & TURBO CLICK EDITION ]]

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")
local Hum = Character:WaitForChild("Humanoid")

-- 1. NOTIFIER & SPEED HACK
local function notify(t, m)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = t, Text = m, Duration = 2})
end

-- FITUR SPEED HACK (Lari Kencang)
Hum.WalkSpeed = 50 -- Standar adalah 16, jadi ini sangat kencang!

-- 2. WHITELIST CHECK
local linkW = "https://raw.githubusercontent.com/ersyabengkulu-oss/script-Lexsa/main/whitelist.txt"
local sW, cW = pcall(function() return game:HttpGet(linkW) end)

if sW and cW:find(Player.Name) then
    notify("Lexsa V8", "Speed Hack & Auto-Click Aktif!")

    -- GUI MENU
    local sg = Instance.new("ScreenGui", Player.PlayerGui)
    local fr = Instance.new("Frame", sg)
    fr.Size = UDim2.new(0, 220, 0, 250)
    fr.Position = UDim2.new(0.5, -110, 0.3, 0)
    fr.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    fr.Active, fr.Draggable = true, true

    local function createBtn(text, pos, color, func)
        local b = Instance.new("TextButton", fr)
        b.Size = UDim2.new(0.9, 0, 0, 45)
        b.Position = pos
        b.Text, b.BackgroundColor3 = text, color
        b.TextColor3 = Color3.new(1,1,1)
        b.Font = Enum.Font.SourceSansBold
        b.MouseButton1Click:Connect(func)
        return b
    end

    -- [ FITUR UTAMA: AUTO EXPAND FARM + TURBO CLICK ]
    _G.Active = false
    local farmBtn = createBtn("ULTIMATE FARM: OFF", UDim2.new(0.05,0,0.1,0), Color3.fromRGB(0, 120, 255), function()
        _G.Active = not _G.Active
        notify("Farm", _G.Active and "Mencari Target..." or "Berhenti")
    end)

    task.spawn(function()
        while true do
            if _G.Active then
                pcall(function()
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Model") or v:IsA("BasePart") then
                            local n = v.Name:lower()
                            -- Deteksi Pohon, Kayu, Baut
                            if n:find("tree") or n:find("wood") or n:find("bolt") then
                                Root.CFrame = v:GetModelCFrame() or v.CFrame
                                task.wait(0.3)
                                
                                -- 1. Sinyal Remote SimpleSpy
                                game:GetService("ReplicatedStorage").RemoteEvents.AnalyticsTimeFirstPerson:FireServer(0, 60)
                                
                                -- 2. Turbo Click Kapak (Virtual User)
                                local vu = game:GetService("VirtualUser")
                                vu:CaptureController()
                                vu:ClickButton1(Vector2.new(0,0))
                            end
                        end
                    end
                end)
            end
            task.wait(0.5)
        end
    end)

    -- TOMBOL SPEED TOGGLE
    createBtn("SET NORMAL SPEED", UDim2.new(0.05,0,0.4,0), Color3.fromRGB(100, 100, 100), function()
        Hum.WalkSpeed = 16
        notify("Speed", "Kembali Normal")
    end)

    createBtn("CLOSE MENU", UDim2.new(0.05,0,0.75,0), Color3.fromRGB(50, 0, 0), function() sg:Destroy() end)
else
    notify("Error", "Akses Ditolak!")
end
