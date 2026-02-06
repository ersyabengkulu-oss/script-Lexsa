-- LEXSA 99 NIGHTS V4: ANTI-AFK & PRO STABLE
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")

-- 1. SISTEM ANTI-AFK (Otomatis Aktif)
local vu = game:GetService("VirtualUser")
Player.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    print("Lexsa Anti-AFK: Mencegah Diskonek!")
end)

-- 2. CEK WHITELIST
local linkWhitelist = "https://raw.githubusercontent.com/ersyabengkulu-oss/script-Lexsa/main/whitelist.txt"
local sW, cW = pcall(function() return game:HttpGet(linkWhitelist) end)

if sW and cW:find(Player.Name) then
    local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 220, 0, 250)
    Frame.Position = UDim2.new(0.5, -110, 0.3, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Frame.Active = true
    Frame.Draggable = true

    local function createBtn(text, pos, color)
        local btn = Instance.new("TextButton", Frame)
        btn.Size = UDim2.new(0.9, 0, 0, 40)
        btn.Position = pos
        btn.Text = text
        btn.BackgroundColor3 = color
        btn.TextColor3 = Color3.new(1, 1, 1)
        return btn
    end

    -- FITUR STABLE FARM (Baut & Kayu)
    local autoFarm = false
    local FarmBtn = createBtn("STABLE FARM: OFF", UDim2.new(0.05, 0, 0.1, 0), Color3.fromRGB(0, 80, 150))
    FarmBtn.MouseButton1Click:Connect(function()
        autoFarm = not autoFarm
        FarmBtn.Text = autoFarm and "STABLE FARM: ON" or "STABLE FARM: OFF"
        task.spawn(function()
            while autoFarm do
                -- Cek apakah masih hidup sebelum teleport
                if Character:FindFirstChild("Humanoid") and Character.Humanoid.Health > 0 then
                    pcall(function()
                        for _, item in pairs(game.Workspace:GetDescendants()) do
                            if item.Name:lower():find("bolt") or item.Name:lower():find("baut") then
                                Root.CFrame = item.CFrame + Vector3.new(0, 3, 0)
                                task.wait(0.5)
                                firetouchinterest(Root, item, 0)
                                firetouchinterest(Root, item, 1)
                            end
                        end
                    end)
                end
                task.wait(2)
            end
        end)
    end)

    -- FITUR FULL BRIGHT (Agar Malam Tetap Terang)
    local BrightBtn = createBtn("FULL BRIGHT", UDim2.new(0.05, 0, 0.35, 0), Color3.fromRGB(150, 150, 0))
    BrightBtn.MouseButton1Click:Connect(function()
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 12
    end)

    -- TOMBOL HIDE
    local HideBtn = createBtn("CLOSE MENU", UDim2.new(0.05, 0, 0.75, 0), Color3.fromRGB(50, 50, 50))
    HideBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
end
