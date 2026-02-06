-- [[ LEXSA V18 - ABSOLUTE SNOW & TREE DESTROYER ]]

local Player = game.Players.LocalPlayer
local Root = Player.Character:WaitForChild("HumanoidRootPart")
local RS = game:GetService("ReplicatedStorage")
local VU = game:GetService("VirtualUser")

-- GUI SEDERHANA
local sg = Instance.new("ScreenGui", Player.PlayerGui)
local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.new(0, 250, 0, 60)
btn.Position = UDim2.new(0.5, -125, 0.15, 0)
btn.Text = "START SNOW HUNTING: OFF"
btn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
btn.TextColor3 = Color3.new(0,0,0)

_G.LexsaFarm = false
btn.MouseButton1Click:Connect(function()
    _G.LexsaFarm = not _G.LexsaFarm
    btn.Text = _G.LexsaFarm and "SNOW HUNTING: ACTIVE" or "START SNOW HUNTING: OFF"
    btn.BackgroundColor3 = _G.LexsaFarm and Color3.new(0, 1, 0) or Color3.fromRGB(0, 255, 255)
    
    task.spawn(function()
        while _G.LexsaFarm do
            pcall(function()
                -- SCAN TARGET BERDASARKAN TEMUAN DEX KAMU
                for _, v in pairs(workspace:GetDescendants()) do
                    if not _G.LexsaFarm then break end
                    
                    local name = v.Name
                    -- TARGET UTAMA: SALJU (ISI PETI), POHON, COAL, DAN BATU
                    if name == "SnowPatch4" or name == "TreeBig3" or name == "Coal" or name == "SnowStoneSmall" then
                        -- Teleport tepat di tengah objek
                        local targetPos = v:GetModelCFrame() or v.CFrame
                        Root.CFrame = targetPos
                        
                        -- SPAM SINYAL REMOTE (Sesuai SimpleSpy Lexsa)
                        for i = 1, 8 do
                            RS.RemoteEvents.AnalyticsTimeFirstPerson:FireServer(0, 60)
                        end
                        
                        -- PAKSA KLIK KAPAK
                        VU:CaptureController()
                        VU:ClickButton1(Vector2.new(0,0))
                        
                        -- Jeda supaya peti sempat muncul
                        task.wait(0.3)
                    end
                end
            end)
            task.wait(0.1) -- Cek target baru dengan cepat
        end
    end)
end)
