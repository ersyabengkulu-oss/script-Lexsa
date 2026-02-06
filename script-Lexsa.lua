-- [[ LEXSA V12 - LIGHTWEIGHT CHEST HUNTER ]]

local Player = game.Players.LocalPlayer
local Root = Player.Character:WaitForChild("HumanoidRootPart")

-- 1. GUI RINGAN
local sg = Instance.new("ScreenGui", Player.PlayerGui)
local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.new(0, 200, 0, 50)
btn.Position = UDim2.new(0.5, -100, 0.1, 0)
btn.Text = "START HUNTING (LIGHT)"
btn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)

_G.Running = false
btn.MouseButton1Click:Connect(function()
    _G.Running = not _G.Running
    btn.Text = _G.Running and "HUNTING: ACTIVE" or "HUNTING: IDLE"
    btn.BackgroundColor3 = _G.Running and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
    
    task.spawn(function()
        while _G.Running do
            pcall(function()
                -- Hanya mencari di Workspace (tidak masuk ke folder dalam) agar tidak lag
                for _, v in pairs(game.Workspace:GetChildren()) do
                    local name = v.Name:lower()
                    
                    -- Deteksi Peti atau Pohon
                    if name:find("chest") or name:find("peti") or name:find("tree") then
                        -- Teleport Jarak Dekat
                        Root.CFrame = v:GetModelCFrame() or v.CFrame
                        task.wait(0.5)
                        
                        -- KIRIM SINYAL MANUAL (Pastikan ini sesuai dengan SimpleSpy kamu)
                        local args = {[1] = 0, [2] = 60}
                        game:GetService("ReplicatedStorage").RemoteEvents.AnalyticsTimeFirstPerson:FireServer(unpack(args))
                        
                        -- Klik Kapak
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
                        task.wait(0.1)
                        game:GetService("VirtualUser"):Button1Up(Vector2.new(0,0))
                    end
                end
            end)
            task.wait(1) -- Jeda lebih lama agar HP tidak panas
        end
    end)
end)
