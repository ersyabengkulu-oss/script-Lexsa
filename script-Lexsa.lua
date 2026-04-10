-- LEXSA SIMPLE TOOLS
local p = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", p.PlayerGui)
sg.Name = "LexsaHub"

local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 150, 0, 180)
f.Position = UDim2.new(0.5, -75, 0.5, -90)
f.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
f.Active = true
f.Draggable = true

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 0, 30)
t.Text = "LEXSA (4663)"
t.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
t.TextColor3 = Color3.new(1, 1, 1)

-- FUNGSI SCAN (CEK DI F9)
local b1 = Instance.new("TextButton", f)
b1.Size = UDim2.new(0.9, 0, 0, 40)
b1.Position = UDim2.new(0.05, 0, 0.25, 0)
b1.Text = "SCAN BUG"
b1.MouseButton1Click:Connect(function()
    print("--- SCANNING ---")
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") then print("Found: " .. v.Name) end
    end
end)

-- FUNGSI ESP
local b2 = Instance.new("TextButton", f)
b2.Size = UDim2.new(0.9, 0, 0, 40)
b2.Position = UDim2.new(0.05, 0, 0.55, 0)
b2.Text = "ESP MUSUH"
b2.MouseButton1Click:Connect(function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= p and v.Character then
            local h = Instance.new("Highlight", v.Character)
            h.FillColor = Color3.new(1, 0, 0)
        end
    end
end)
