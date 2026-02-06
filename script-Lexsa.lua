-- [[ LEXSA V4 FINAL - ALL FEATURES INTEGRATED ]]

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")

-- 1. NOTIFIER SYSTEM
local function notify(title, msg)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title;
        Text = msg;
        Duration = 3;
    })
end

-- 2. ANTI-AFK SYSTEM
local vu = game:GetService("VirtualUser")
Player.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    notify("System", "Anti-AFK Aktif!")
end)

-- 3. WHITELIST CHECK
local linkWhitelist = "https://raw.githubusercontent.com/ersyabengkulu-oss/script-Lexsa/main/whitelist.txt"
local sW, cW = pcall(function() return game:HttpGet(linkWhitelist) end)

if sW and cW:find(Player.Name) then
    notify("Welcome", "Akses Diterima, Lexsa!")
    
    -- GUI MAIN FRAME
    local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 220, 0, 350)
    Frame.Position = UDim2.new(0.5, -110, 0.2, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.Active = true
    Frame.Draggable = true

    local function createBtn(text, pos, color)
        local btn = Instance.new("TextButton", Frame)
        btn.Size = UDim2.new(0.9, 0, 0, 40)
        btn.Position = pos
        btn.Text = text
        btn.BackgroundColor3 = color
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.SourceSansBold
        return btn
    end

    -- [ FITUR 1: STABLE FARM + REMOTEEVENT ]
    local stableFarm = false
    local FarmBtn = createBtn("STABLE FARM: OFF", UDim2.new(0.05, 0, 0.05, 0), Color3.fromRGB(0, 80, 150))
    FarmBtn.MouseButton1Click:Connect(function()
        stableFarm = not stableFarm
        FarmBtn.Text = stableFarm and "STABLE FARM: ON" or "STABLE FARM: OFF"
        task.spawn(function()
            while stableFarm do
                if Character.Humanoid.Health > 0 then
                    pcall(function()
                        for _, obj in pairs(game.Workspace:GetDescendants()) do
                            if obj.Name:lower():find("bolt") or obj.Name:lower():find("baut") then
                                Root.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                                task.wait(0.5)
                                -- FIX: Menggunakan Remote Event dari SimpleSpy kamu
                                local args = {[1] = 0, [2] = 60}
                                game:GetService("ReplicatedStorage").RemoteEvents.AnalyticsTimeFirstPerson:FireServer(unpack(args))
                                notify("Farm", "Baut Berhasil Diambil!")
                            end
                        end
                    end)
                end
                task.wait(1.5)
            end
        end)
    end)

    -- [ FITUR 2: AUTO DEPOSIT ]
    local autoDepo = false
    local DepoBtn = createBtn("AUTO DEPOSIT: OFF", UDim2.new(0.05, 0, 0.2, 0), Color3.fromRGB(100, 50, 0))
    DepoBtn.MouseButton1Click:Connect(function()
        autoDepo = not autoDepo
        DepoBtn.Text = autoDepo and "AUTO DEPOSIT: ON" or "AUTO DEPOSIT: OFF"
        task.spawn(function()
            while autoDepo do
                pcall(function()
                    for _, t in pairs(game.Workspace:GetDescendants()) do
                        if t.Name:lower():find("deposit") or t.Name:lower():find("chest") then
                            Root.CFrame = t.CFrame + Vector3.new(0, 3, 0)
                            task.wait(0.7)
                            firetouchinterest(Root, t, 0)
                            firetouchinterest(Root, t, 1)
                            notify("Deposit", "Barang Disimpan!")
                        end
                    end
                end)
                task.wait(3)
            end
        end)
    end)

    -- [ FITUR 3: SAFE ZONE ]
    local safeZone = false
    local SafeBtn = createBtn("SAFE ZONE: OFF", UDim2.new(0.05, 0, 0.35, 0), Color3.fromRGB(0, 100, 0))
    SafeBtn.MouseButton1Click:Connect(function()
        safeZone = not safeZone
        SafeBtn.Text = safeZone and "SAFE ZONE: ON" or "SAFE ZONE: OFF"
        task.spawn(function()
            while safeZone do
                if Character.Humanoid.Health < 30 and Character.Humanoid.Health > 0 then
                    Root.CFrame = CFrame.new(0, 100, 0) -- Teleport ke langit (Safe)
                    notify("Security", "Kritis! Kabur ke langit.")
                    task.wait(5)
                end
                task.wait(0.5)
            end
        end)
    end)

    -- TOMBOL CLOSE
    local CloseBtn = createBtn("CLOSE MENU", UDim2.new(0.05, 0, 0.85, 0), Color3.fromRGB(60, 60, 60))
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
else
    notify("Error", "Akun Tidak Terdaftar di Whitelist!")
end
