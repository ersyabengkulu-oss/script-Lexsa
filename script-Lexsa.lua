-- LEXSA (4663) INTERNAL ANALYST TOOLS
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 250)
Frame.Position = UDim2.new(0.5, -100, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "LEXSA HUB (4663)"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- FUNGSI: SCAN BUG
local Btn1 = Instance.new("TextButton", Frame)
Btn1.Size = UDim2.new(0.9, 0, 0, 40)
Btn1.Position = UDim2.new(0.05, 0, 0.2, 0)
Btn1.Text = "SCAN REMOTES (F9)"
Btn1.MouseButton1Click:Connect(function()
    print("--- SCANNING ---")
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") then print("Remote: " .. v.Name) end
    end
end)

-- FUNGSI: ESP (HIGHLIGHT)
local Btn2 = Instance.new("TextButton", Frame)
Btn2.Size = UDim2.new(0.9, 0, 0, 40)
Btn2.Position = UDim2.new(0.05, 0, 0.4, 0)
Btn2.Text = "ENABLE ESP"
Btn2.MouseButton1Click:Connect(function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then
            local h = Instance.new("Highlight", v.Character)
            h.FillColor = Color3.new(1, 0, 0)
        end
    end
end)

-- FUNGSI: AUTO AIM (LOCK CAMERA)
local Btn3 = Instance.new("TextButton", Frame)
Btn3.Size = UDim2.new(0.9, 0, 0, 40)
Btn3.Position = UDim2.new(0.05, 0, 0.6, 0)
Btn3.Text = "AUTO AIM (LOCK)"
Btn3.MouseButton1Click:Connect(function()
    local target = nil
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then target = v break end
    end
    if target then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.HumanoidRootPart.Position) end
end)
