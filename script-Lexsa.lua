-- [[ LEXSA V4 FULL STABLE EDITION ]]

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")

-- 1. SISTEM NOTIFIKASI (LOG LOGGER)
local function notify(title, msg)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title;
        Text = msg;
        Duration = 3;
    })
end

-- 2. SISTEM ANTI-AFK
local vu = game:GetService("VirtualUser")
Player.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    notify("System", "Anti-AFK Aktif!")
end)

-- 3. CEK WHITELIST DARI GITHUB
local linkWhitelist = "https://raw.githubusercontent.com/ersyabengkulu-oss/script-Lexsa/main/whitelist.txt"
local sW, cW = pcall(function() return game:HttpGet(linkWhitelist) end)

if sW and cW:find(Player.Name) then
    notify("Welcome", "Akses Diterima, Lexsa!")
    
    -- Membuat GUI Menu
    local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 220, 0, 320)
    Frame.Position = UDim2.new(0.5, -110, 0.2, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.Active = true
    Frame.Draggable = true

    local function createBtn(text, pos, color)
        local btn = Instance.new("TextButton", Frame)
        btn.Size = UDim2.new(0.9, 0, 0, 35)
        btn.Position = pos
        btn.Text = text
        btn.BackgroundColor3 = color
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.SourceSansBold
        return btn
    end

    -- FITUR STABLE FARM
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
                                firetouchinterest(Root, obj, 0)
                                firetouchinterest(Root, obj, 1)
                                notify("Farm", "Baut Berhasil Diambil!")
                            end
                        end
                    end)
                end
                task.wait(1.5)
            end
        end)
    end)

    -- FITUR AUTO DEPOSIT
    local autoDepo = false
    local DepoBtn = createBtn("AUTO DEPOSIT: OFF", UDim2.new(0.05, 0, 0.2, 0), Color3.fromRGB(100, 50, 0))
    DepoBtn.MouseButton1Click:Connect(function()
        autoDepo = not autoDepo
        DepoBtn.Text = autoDepo and "AUTO DEPOSIT: ON" or "AUTO DEPOSIT: OFF"
        task.spawn(function()
            while autoDepo do
                pcall(function()
                    for _, t in pairs(game.Workspace:GetDescendants()) do
                        if t.Name:lower():find("deposit") then
                            Root.CFrame = t.CFrame + Vector3.new(0, 3, 0)
                            task.wait(0.5)
                            firetouchinterest(Root, t, 0)
                            firetouchinterest(Root, t, 1)
                            notify("Deposit", "Barang Berhasil Disimpan!")
                        end
                    end
                end)
                task.wait(3)
            end
        end)
    end)

    -- TOMBOL CLOSE
    local CloseBtn = createBtn("CLOSE MENU", UDim2.new(0.05, 0, 0.85, 0), Color3.fromRGB(50, 50, 50))
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
else
    notify("Error", "Akun Tidak Terdaftar!")
end
