-- [[ LEXSA V10 - TREASURE & TURBO FARM ]]

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")

-- 1. NOTIFIER
local function notify(t, m)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = t, Text = m, Duration = 2})
end

-- 2. WHITELIST
local linkW = "https://raw.githubusercontent.com/ersyabengkulu-oss/script-Lexsa/main/whitelist.txt"
local sW, cW = pcall(function() return game:HttpGet(linkW) end)

if sW and cW:find(Player.Name) then
    notify("Lexsa V10", "Berburu Kapak di Chest!")

    -- GUI MENU
    local sg = Instance.new("ScreenGui", Player.PlayerGui)
    local fr = Instance.new("Frame", sg)
    fr.Size = UDim2.new(0, 220, 0, 150)
    fr.Position = UDim2.new(0.5, -110, 0.4, 0)
    fr.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    fr.Active, fr.Draggable = true, true

    local btn = Instance.new("TextButton", fr)
    btn.Size = UDim2.new(0.9, 0, 0, 60)
    btn.Position = UDim2.new(0.05, 0, 0.2, 0)
    btn.Text = "AUTO CHEST & WOOD: OFF"
    btn.BackgroundColor3 = Color3.fromRGB(150, 100, 0) -- Warna Emas
    btn.TextColor3 = Color3.new(1, 1, 1)

    -- 3. LOGIKA BERBURU
    _G.Hunt = false
    btn.MouseButton1Click:Connect(function()
        _G.Hunt = not _G.Hunt
        btn.Text = _G.Hunt and "HUNTING: ON" or "HUNTING: OFF"
        
        task.spawn(function()
            while _G.Hunt do
                pcall(function()
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Model") or v:IsA("BasePart") then
                            local n = v.Name:lower()
                            -- PRIORITAS 1: AMBIL PETI (CHEST)
                            if n:find("chest") or n:find("peti") or n:find("treasure") then
                                Root.CFrame = v:GetModelCFrame() or v.CFrame
                                task.wait(0.5)
                                firetouchinterest(Root, v, 0)
                                firetouchinterest(Root, v, 1)
                                notify("Harta", "Membuka Peti!")
                            -- PRIORITAS 2: TEBANG POHON
                            elseif n:find("tree") or n:find("wood") then
                                Root.CFrame = v:GetModelCFrame() or v.CFrame
                                -- Sinyal Turbo dari SimpleSpy Lexsa
                                game:GetService("ReplicatedStorage").RemoteEvents.AnalyticsTimeFirstPerson:FireServer(0, 60)
                                game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                            end
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
    end)
else
    notify("Error", "Whitelist Gagal!")
end
