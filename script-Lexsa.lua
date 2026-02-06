-- [[ LEXSA V7 - ADAPTIVE MAP EXPANSION ]]

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")

-- Fungsi deteksi objek di seluruh Map
local function findTarget()
    for _, v in pairs(workspace:GetDescendants()) do 
        -- Menggunakan GetDescendants agar mencari sampai ke dalam folder terdalam
        if v:IsA("Model") or v:IsA("BasePart") then
            local n = v.Name:lower()
            -- Mencari Pohon, Kayu, atau Baut di area mana pun
            if n:find("tree") or n:find("wood") or n:find("bolt") or n:find("baut") then
                return v
            end
        end
    end
    return nil
end

-- WHITELIST & GUI (Sama seperti sebelumnya agar stabil)
local linkW = "https://raw.githubusercontent.com/ersyabengkulu-oss/script-Lexsa/main/whitelist.txt"
local sW, cW = pcall(function() return game:HttpGet(linkW) end)

if sW and cW:find(Player.Name) then
    local sg = Instance.new("ScreenGui", Player.PlayerGui)
    local fr = Instance.new("Frame", sg)
    fr.Size = UDim2.new(0, 220, 0, 150)
    fr.Position = UDim2.new(0.5, -110, 0.4, 0)
    fr.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    fr.Active, fr.Draggable = true, true

    local b = Instance.new("TextButton", fr)
    b.Size = UDim2.new(0.9, 0, 0, 50)
    b.Position = UDim2.new(0.05, 0, 0.1, 0)
    b.Text = "AUTO EXPAND FARM: OFF"
    b.BackgroundColor3 = Color3.fromRGB(0, 100, 200)

    _G.Active = false
    b.MouseButton1Click:Connect(function()
        _G.Active = not _G.Active
        b.Text = _G.Active and "AUTO EXPAND FARM: ON" or "AUTO EXPAND FARM: OFF"
        
        task.spawn(function()
            while _G.Active do
                local target = findTarget()
                if target then
                    -- Teleport ke objek
                    local pos = target:GetModelCFrame() or target.CFrame
                    Root.CFrame = pos + Vector3.new(0, 2, 0)
                    task.wait(0.5)
                    -- Sinyal SimpleSpy agar item masuk tas
                    game:GetService("ReplicatedStorage").RemoteEvents.AnalyticsTimeFirstPerson:FireServer(0, 60)
                end
                task.wait(1)
            end
        end)
    end)
else
    print("Whitelist Gagal")
end
