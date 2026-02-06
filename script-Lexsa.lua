-- LEXSA 99 NIGHTS CORE V3: MEGA FEATURES
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")

-- 1. WHITELIST SYSTEM
local linkWhitelist = "https://raw.githubusercontent.com/ersyabengkulu-oss/script-Lexsa/main/whitelist.txt"
local sW, cW = pcall(function() return game:HttpGet(linkWhitelist) end)

if sW and cW:find(Player.Name) then
    local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 220, 0, 300)
    Frame.Position = UDim2.new(0.5, -110, 0.3, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.Active = true
    Frame.Draggable = true

    -- [FUNGSI BANTUAN]
    local function createBtn(text, pos, color)
        local btn = Instance.new("TextButton", Frame)
        btn.Size = UDim2.new(0.9, 0, 0, 35)
        btn.Position = pos
        btn.Text = text
        btn.BackgroundColor3 = color
        btn.TextColor3 = Color3.new(1, 1, 1)
        return btn
    end

    -- 1. GOD MODE (Menghapus Hitbox Player dari Hantu)
    local GodBtn = createBtn("GOD MODE: OFF", UDim2.new(0.05, 0, 0.05, 0), Color3.fromRGB(100, 0, 100))
    local godActive = false
    GodBtn.MouseButton1Click:Connect(function()
        godActive = not godActive
        GodBtn.Text = godActive and "GOD MODE: ON" or "GOD MODE: OFF"
        if godActive then
            -- Menghilangkan deteksi sentuhan hantu
            Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        end
    end)

    -- 2. KILL AURA (Menyerang Hewan/Hantu otomatis di sekitar)
    local KillBtn = createBtn("KILL AURA: OFF", UDim2.new(0.05, 0, 0.2, 0), Color3.fromRGB(150, 0, 0))
    local killActive = false
    KillBtn.MouseButton1Click:Connect(function()
        killActive = not killActive
        KillBtn.Text = killActive and "KILL AURA: ON" or "KILL AURA: OFF"
        task.spawn(function()
            while killActive do
                for _, v in pairs(game.Workspace:GetChildren()) do
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Name ~= Player.Name then
                        local dist = (Root.Position - v.PrimaryPart.Position).Magnitude
                        if dist < 15 then
                            -- Panggil Remote Attack (Gunakan SimpleSpy untuk ganti nama 'Attack')
                            pcall(function() game:GetService("ReplicatedStorage").Events.Attack:FireServer(v) end)
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    end)

    -- 3. AUTO CAMPFIRE & BAUT (Ambil & Masukkan otomatis)
    local CampBtn = createBtn("AUTO CAMPFIRE: OFF", UDim2.new(0.05, 0, 0.35, 0), Color3.fromRGB(200, 100, 0))
    local campActive = false
    CampBtn.MouseButton1Click:Connect(function()
        campActive = not campActive
        CampBtn.Text = campActive and "AUTO CAMP: ON" or "AUTO CAMP: OFF"
        task.spawn(function()
            while campActive do
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v.Name:lower():find("bolt") or v.Name:lower():find("baut") or v.Name:lower():find("wood") then
                        if v:IsA("BasePart") then
                            Root.CFrame = v.CFrame -- Teleport ambil barang
                            task.wait(0.5)
                        end
                    end
                end
                task.wait(2)
            end
        end)
    end)

    -- 4. AUTO CHOP TREE (Tebang Pohon Otomatis)
    local TreeBtn = createBtn("AUTO CHOP: OFF", UDim2.new(0.05, 0, 0.5, 0), Color3.fromRGB(0, 100, 0))
    local treeActive = false
    TreeBtn.MouseButton1Click:Connect(function()
        treeActive = not treeActive
        TreeBtn.Text = treeActive and "AUTO CHOP: ON" or "AUTO CHOP: OFF"
        task.spawn(function()
            while treeActive do
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v.Name:lower():find("tree") and v:IsA("Model") then
                        -- Simulasikan tebang pohon
                        pcall(function() game:GetService("ReplicatedStorage").Events.Chop:FireServer(v) end)
                    end
                end
                task.wait(1)
            end
        end)
    end)
end
