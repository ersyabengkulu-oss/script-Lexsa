-- Lexsa Universal Waypoints (Anti-Fail)
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 130, 0, 260)
Frame.Position = UDim2.new(0.85, 0, 0.3, 0) -- Di kanan biar gak ganggu
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Active = true
Frame.Draggable = true

local UIList = Instance.new("UIListLayout", Frame)
UIList.Padding = UDim.new(0, 5)

local Waypoints = {}

for i = 1, 5 do
    local Set = Instance.new("TextButton", Frame)
    Set.Size = UDim2.new(1, 0, 0, 22)
    Set.Text = "SET SLOT " .. i
    Set.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    Set.TextColor3 = Color3.new(1, 1, 1)

    local Go = Instance.new("TextButton", Frame)
    Go.Size = UDim2.new(1, 0, 0, 22)
    Go.Text = "GO SLOT " .. i
    Go.BackgroundColor3 = Color3.fromRGB(0, 0, 100)
    Go.TextColor3 = Color3.new(1, 1, 1)

    Set.MouseButton1Click:Connect(function()
        local p = game.Players.LocalPlayer.Character
        -- Cek RootPart atau Head (buat game yang ganti nama body)
        local root = p:FindFirstChild("HumanoidRootPart") or p:FindFirstChild("Head")
        if root then
            Waypoints[i] = root.CFrame
            Set.Text = "OK!"
            task.wait(0.5)
            Set.Text = "SET SLOT " .. i
        end
    end)

    Go.MouseButton1Click:Connect(function()
        local p = game.Players.LocalPlayer.Character
        local root = p:FindFirstChild("HumanoidRootPart") or p:FindFirstChild("Head")
        if Waypoints[i] and root then
            -- Pakai CFrame biar lebih kuat nembus anti-cheat
            root.CFrame = Waypoints[i]
            -- Sedikit trik: Velocity dinolin biar gak mental pas mendarat
            root.Velocity = Vector3.new(0,0,0)
        end
    end)
end
