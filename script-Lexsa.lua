-- [[ LEXSA V17 - SNOW & TREASURE SPECIALIST ]]

local Player = game.Players.LocalPlayer
local Root = Player.Character:WaitForChild("HumanoidRootPart")

-- GUI
local sg = Instance.new("ScreenGui", Player.PlayerGui)
local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.new(0, 250, 0, 60)
btn.Position = UDim2.new(0.5, -125, 0.1, 0)
btn.Text = "AUTO SNOW & TREASURE: OFF"
btn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) -- Warna Biru Salju
btn.TextColor3 = Color3.new(1,1,1)

_G.SnowFarm = false
btn.MouseButton1Click:Connect(function()
    _G.SnowFarm = not _G.SnowFarm
    btn.Text = _G.SnowFarm and "SNOW HUNTING: ON" or "AUTO SNOW: OFF"
    btn.BackgroundColor3 = _G.SnowFarm and Color3.new(0, 1, 1) or Color3.fromRGB(0, 100, 200)
    
    task.spawn(function()
        while _G.SnowFarm do
            pcall(function()
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if not _G.SnowFarm then break end
                    
                    local n = v.Name
                    -- PRIORITAS: SALJU (KARENA ADA PETI), BATU, DAN POHON
                    if n == "SnowPatch4" or n == "SnowStoneSmall" or n == "TreeBig3" or n == "Coal" then
                        Root.CFrame = v:GetModelCFrame() or v.CFrame
                        
                        -- Sinyal Turbo Lexsa
                        for i = 1, 5 do
                            game:GetService("ReplicatedStorage").RemoteEvents.AnalyticsTimeFirstPerson:FireServer(0, 60)
                        end
                        
                        -- Klik Hancurkan
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
                        task.wait(0.4) -- Jeda sedikit biar petinya sempat kebuka
                        game:GetService("VirtualUser"):Button1Up(Vector2.new(0,0))
                        
                        -- Fitur Tambahan: Berhenti sebentar kalau nemu SnowPatch biar lootingnya aman
                        if n == "SnowPatch4" then task.wait(0.5) end
                    end
                end
            end)
            task.wait(0.5)
        end
    end)
end)
