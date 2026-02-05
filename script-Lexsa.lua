-- LEXSA V5.2: TYCOON GOD (AUTO ALL)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

ScreenGui.Name = "LexsaV52"
ScreenGui.Parent = game:GetService("CoreGui")

OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
OpenBtn.Text = "GOD"
OpenBtn.Visible = false
OpenBtn.Draggable = true

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 240, 0, 400)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 0, 45)
TextLabel.Text = "LEXSA V5.2: TYCOON"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

ScrollFrame.Parent = Frame
ScrollFrame.Size = UDim2.new(1, -10, 1, -110)
ScrollFrame.Position = UDim2.new(0, 5, 0, 50)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

UIListLayout.Parent = ScrollFrame
UIListLayout.Padding = UDim.new(0, 5)

local function addToggle(name, color, func)
    local active = false
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollFrame
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Text = name .. ": OFF"
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = active and name .. ": ON" or name .. ": OFF"
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 200, 0) or color
        func(active)
    end)
end

-- 1. AUTO REBIRTH
addToggle("AUTO REBIRTH", Color3.fromRGB(255, 0, 100), function(state)
    _G.Rebirth = state
    task.spawn(function()
        while _G.Rebirth do
            -- Mengirim perintah Rebirth ke server (biasanya lewat RemoteEvent)
            pcall(function()
                game:GetService("ReplicatedStorage").Events.Rebirth:FireServer() 
            end)
            task.wait(5)
        end
    end)
end)

-- 2. AUTO UPGRADE & COLLECT BASE
addToggle("AUTO BASE UPGRADE", Color3.fromRGB(0, 200, 100), function(state)
    _G.AutoBase = state
    task.spawn(function()
        while _G.AutoBase do
            pcall(function()
                -- 1. Ambil Uang di Base (Cari tombol 'Collect' atau 'Money')
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v.Name == "Collect" or v.Name == "Giver" then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
                    end
                end
                -- 2. Upgrade Semua (Cari tombol 'Buy' atau 'Upgrade')
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if (v.Name:find("Buy") or v.Name:find("Upgrade")) and v:IsA("BasePart") then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
                    end
                end
            end)
            task.wait(1)
        end
    end)
end)

-- 3. FITUR LAVA GOD (YANG SUDAH JALAN)
addToggle("LAVA WALKING", Color3.fromRGB(255, 100, 0), function(state)
    _G.LavaWalk = state
    task.spawn(function()
        while _G.LavaWalk do
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name:lower():find("lava") and v:IsA("BasePart") then
                    v.CanCollide = true
                    if v:FindFirstChild("TouchInterest") then v.TouchInterest:Destroy() end
                end
            end
            task.wait(1)
        end
    end)
end)

MinimizeBtn.Parent = Frame
MinimizeBtn.Size = UDim2.new(1, -20, 0, 35)
MinimizeBtn.Position = UDim2.new(0, 10, 1, -45)
MinimizeBtn.Text = "Sembunyikan"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeBtn.MouseButton1Click:Connect(function() Frame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() Frame.Visible = true OpenBtn.Visible = false end)
