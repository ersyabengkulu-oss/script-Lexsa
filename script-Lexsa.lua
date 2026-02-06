-- [[ LEXSA V5 ULTIMATE - AUTO FARM & WOOD CUTTER ]]

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
    Frame.Size = UDim2.new(0, 220, 0, 400) -- Ukuran lebih panjang untuk fitur baru
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

    -- [ FITUR 1: AUTO WOOD & FARM ]
    local autoFarm = false
    local FarmBtn = createBtn("AUTO FARM & WOOD: OFF", UDim2.new(0.05, 0, 0.05, 0), Color3.fromRGB(0, 80, 150))
    FarmBtn.MouseButton1Click:Connect(function()
        autoFarm = not autoFarm
        FarmBtn.Text = autoFarm and "AUTO FARM & WOOD: ON" or "AUTO FARM & WOOD: OFF"
        task.spawn(function()
            while autoFarm do
                pcall(function()
                    for _, obj in pairs(game.Workspace:GetDescendants()) do
                        -- Mencari Pohon, Kayu, atau Baut
                        if obj.Name:lower():find("tree") or obj.Name:lower():find("wood") or obj.Name:lower():find("bolt") then
                            Root.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                            task.wait(0.5)
                            
                            -- Kirim Sinyal RemoteEvent dari SimpleSpy Lexsa
                            local args = {[1] = 0, [2] = 60}
                            game:GetService("ReplicatedStorage").RemoteEvents.AnalyticsTimeFirstPerson:FireServer(unpack(args))
                            
                            notify("Action", "Memproses: " .. obj.Name)
                        end
                    end
                end)
                task.wait(1)
            end
        end)
    end)

    -- [ FITUR 2: AUTO DEPOSIT / BURN ]
    local autoBurn = false
    local BurnBtn = createBtn("AUTO DEPOSIT/BURN: OFF", UDim2.new(0.05, 0, 0.15, 0), Color3.fromRGB(150, 50, 0))
    BurnBtn.MouseButton1Click:Connect(function()
        autoBurn = not autoBurn
        BurnBtn.Text = autoBurn and "AUTO BURN: ON" or "AUTO BURN: OFF"
        task.spawn(function()
            while autoBurn do
                pcall(function()
                    for _, target in pairs(game.Workspace:GetDescendants()) do
                        -- Mencari Api atau Tempat Simpan
                        if target.Name:lower():find("fire") or target.Name:lower():find("api") or target.Name:lower():find("deposit") then
                            Root.CFrame = target.CFrame + Vector3.new(0, 3, 0)
                            task.wait(0.8)
                            firetouchinterest(Root, target, 0)
                            firetouchinterest(Root, target, 1)
                        end
                    end
                end)
                task.wait(2)
            end
        end)
    end)

    -- [ FITUR 3: SAFE ZONE ]
    local safeZone = false
    local SafeBtn = createBtn("SAFE ZONE: OFF", UDim2.new(0.05, 0, 0.25, 0), Color3.fromRGB(0, 100, 0))
    SafeBtn.MouseButton1Click:Connect(function()
        safeZone = not safeZone
        SafeBtn.Text = safeZone and "SAFE ZONE: ON" or "SAFE ZONE: OFF"
        task.spawn(function()
            while safeZone do
                if Character.Humanoid.Health < 35 then
                    Root.CFrame = CFrame.new(0, 150, 0) -- Teleport ke tempat aman
                    notify("Security", "Darah Rendah! Kabur.")
                    task.wait(5)
                end
                task.wait(0.5)
            end
        end)
    end)

    -- TOMBOL CLOSE
    local CloseBtn = createBtn("CLOSE MENU", UDim2.new(0.05, 0, 0.88, 0), Color3.fromRGB(60, 60, 60))
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
else
    notify("Error", "Akun Tidak Terdaftar!")
end
