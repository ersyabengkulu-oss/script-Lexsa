-- Lexsa Script (Waypoint + Auto Brainrot Fix)
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("LexsaFinal") then CoreGui.LexsaFinal:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "LexsaFinal"

-- 1. Tombol LX (Toggle)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleBtn.Position = UDim2.new(0, 15, 0.45, 0)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Text = "LX"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Draggable = true
ToggleBtn.Active = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

-- 2. Menu Utama
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -75, 0.5, -125)
MainFrame.Size = UDim2.new(0, 150, 0, 250)
MainFrame.Visible = false
Instance.new("UICorner", MainFrame)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, -10, 1, -20)
Scroll.Position = UDim2.new(0, 5, 0, 10)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
local UIList = Instance.new("UIListLayout", Scroll)
UIList.Padding = UDim.new(0, 5)

-- --- FITUR AUTO UPGRADE (HASIL SPY) ---
local _upgrade = false
local AutoUp = Instance.new("TextButton", Scroll)
AutoUp.Size = UDim2.new(1, 0, 0, 30)
AutoUp.Text = "Auto Upgrade: OFF"
AutoUp.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AutoUp.TextColor3 = Color3.new(1, 1, 1)

AutoUp.MouseButton1Click:Connect(function()
    _upgrade = not _upgrade
    AutoUp.Text = "Auto Upgrade: "..(_upgrade and "ON" or "OFF")
    AutoUp.BackgroundColor3 = _upgrade and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
    task.spawn(function()
        while _upgrade do
            -- Kode dari SimpleSpy kamu
            local args = {[1] = nil}
            game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent:FireServer(unpack(args))
            task.wait(0.5)
        end
    end)
end)

-- --- FITUR AUTO COLLECT (MANUAL SEARCH) ---
local _collect = false
local AutoCol = Instance.new("TextButton", Scroll)
AutoCol.Size = UDim2.new(1, 0, 0, 30)
AutoCol.Text = "Auto Collect: OFF"
AutoCol.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AutoCol.TextColor3 = Color3.new(1, 1, 1)

AutoCol.MouseButton1Click:Connect(function()
    _collect = not _collect
    AutoCol.Text = "Auto Collect: "..(_collect and "ON" or "OFF")
    AutoCol.BackgroundColor3 = _collect and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
    task.spawn(function()
        while _collect do
            -- Kita cari koin di sekitar karakter
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("TouchTransmitter") then
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
                end
            end
            task.wait(1)
        end
    end)
end)

-- --- WAYPOINT ---
local Waypoints = {}
for i = 1, 3 do
    local Container = Instance.new("Frame", Scroll)
    Container.Size = UDim2.new(1, 0, 0, 35)
    Container.BackgroundTransparency = 1
    local Set = Instance.new("TextButton", Container)
    Set.Size = UDim2.new(0.48, 0, 1, 0)
    Set.Text = "SET "..i
    Set.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    local Go = Instance.new("TextButton", Container)
    Go.Size = UDim2.new(0.48, 0, 1, 0)
    Go.Position = UDim2.new(0.52, 0, 0, 0)
    Go.Text = "GO "..i
    Go.BackgroundColor3 = Color3.fromRGB(0, 0, 100)
    
    Set.MouseButton1Click:Connect(function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then Waypoints[i] = hrp.CFrame end
    end)
    Go.MouseButton1Click:Connect(function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if Waypoints[i] and hrp then hrp.CFrame = Waypoints[i] end
    end)
end
