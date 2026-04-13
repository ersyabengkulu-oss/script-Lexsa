-- LEXSA (4663) - PROTOCOL HUB v2
local p = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", p.PlayerGui)
sg.Name = "LexsaProtocol"

local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 180, 0, 200) -- Ukuran ditambah buat tombol delete
f.Position = UDim2.new(0.5, -90, 0.4, 0)
f.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
f.Active = true
f.Draggable = true

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 0, 30)
t.Text = "LEXSA PROTOCOL"
t.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
t.TextColor3 = Color3.new(1, 1, 1)

-- 1. SWP (Scanning Watch Protocol)
local b1 = Instance.new("TextButton", f)
b1.Size = UDim2.new(0.9, 0, 0, 35)
b1.Position = UDim2.new(0.05, 0, 0.2, 0)
b1.Text = "ACTIVATE SWP"
b1.MouseButton1Click:Connect(function()
    print("--- [SWP] SCANNING (Max 50 Slots) ---")
    local found = 0
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") and found < 50 then 
            found = found + 1
            print("Slot ["..found.."]: " .. v.Name) 
        end
    end
end)

-- 2. DELETE SWP LOG (Fitur Baru)
local b_del = Instance.new("TextButton", f)
b_del.Size = UDim2.new(0.9, 0, 0, 35)
b_del.Position = UDim2.new(0.05, 0, 0.4, 0)
b_del.Text = "DELETE SWP LOG"
b_del.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
b_del.TextColor3 = Color3.new(1, 1, 1)
b_del.MouseButton1Click:Connect(function()
    for i = 1, 50 do print(" ") end -- Cara cepat "bersihin" console di Roblox
    print("--- [SWP] LOG CLEARED ---")
end)

-- 3. WP (Wall Protocol) - ESP
local b2 = Instance.new("TextButton", f)
b2.Size = UDim2.new(0.9, 0, 0, 35)
b2.Position = UDim2.new(0.05, 0, 0.7, 0)
b2.Text = "ACTIVATE WP"
b2.MouseButton1Click:Connect(function()
    b2.Text = "WP ACTIVE"
    b2.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    task.spawn(function()
        while true do
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= p and v.Character and not v.Character:FindFirstChild("WP_Highlight") then
                    local h = Instance.new("Highlight", v.Character)
                    h.Name = "WP_Highlight"
                    h.FillColor = Color3.fromRGB(255, 0, 0)
                end
            end
            task.wait(2)
        end
    end)
end)
