-- [[ LEXSA V11 - TREASURE KING & AUTO BURN ]]

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")

-- 1. SISTEM NOTIFIKASI
local function notify(t, m)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = t, Text = m, Duration = 2})
end

-- 2. WHITELIST
local linkW = "https://raw.githubusercontent.com/ersyabengkulu-oss/script-Lexsa/main/whitelist.txt"
local sW, cW = pcall(function() return game:HttpGet(linkW) end)

if sW and cW:find(Player.Name) then
    notify("Lexsa V11", "Berburu Kapak di Peti!")

    -- GUI MENU MODEREN
    local sg = Instance.new("ScreenGui", Player.PlayerGui)
    local fr = Instance.new("Frame", sg)
    fr.Size = UDim2.new(0, 220, 0, 180)
    fr.Position = UDim2.new(0.5, -110, 0.4, 0)
    fr.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    fr.Active, fr.Draggable = true, true

    local btn = Instance.new("TextButton", fr)
    btn.Size = UDim2.new(0.9, 0, 0, 60)
    btn.Position = UDim2.new(0.05, 0, 0.15, 0)
    btn.Text = "AUTO PETI & WOOD: OFF"
    btn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
    btn.Font = Enum.Font.SourceSansBold

    -- 3. LOGIKA AUTO HUNTING
    _G.Hunt = false
    btn.MouseButton1Click:Connect(function()
        _G.Hunt = not _G.Hunt
        btn.Text = _G.Hunt and "HUNTING: ON" or "HUNTING: OFF"
        btn.BackgroundColor3 = _G.Hunt and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(255, 170, 0)
        
        task.spawn(function()
            while _G.Hunt do
                pcall(function()
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Model") or v:IsA("BasePart") then
                            local n = v.Name:lower()
                            -- PRIORITAS UTAMA: PETI (TEMPAT KAPAK GG)
                            if n:find("chest") or n:find("peti") or n:find("treasure") then
                                Root.CFrame = v:GetModelCFrame() or v.CFrame
                                task.wait(0.5)
                                firetouchinterest(Root, v, 0)
                                firetouchinterest(Root, v, 1)
                                notify("Harta", "Membuka Peti!")
                                task.wait(1)
                            -- PRIORITAS KEDUA: TEBANG POHON TURBO
                            elseif n:find("tree") or n:find("wood") then
                                Root.CFrame = v:GetModelCFrame() or v.CFrame
                                -- Spam Sinyal SimpleSpy Lexsa
                                for i = 1, 3 do
                                    game:GetService("ReplicatedStorage").RemoteEvents.AnalyticsTimeFirstPerson:FireServer(0, 60)
                                end
                                game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                            end
                        end
                    end
                end)
                task.wait(0.2)
            end
        end)
    end)
else
    notify("Error", "Whitelist Gagal!")
end
