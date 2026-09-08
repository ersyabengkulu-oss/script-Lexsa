-- ============================================
-- TES GUI KHUSUS ARCEUS X (CORE GUI)
-- ============================================
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Cek parent GUI yang didukung Arceus X
local parentTarget = nil
if gethui then
    parentTarget = gethui()
elseif CoreGui then
    parentTarget = CoreGui
else
    parentTarget = Player:WaitForChild("PlayerGui")
end

-- Hapus UI lama jika ada
if parentTarget:FindFirstChild("TestLexsaUI") then
    parentTarget.TestLexsaUI:Destroy()
end

-- Buat ScreenGui
local sg = Instance.new("ScreenGui")
sg.Name = "TestLexsaUI"
sg.ResetOnSpawn = false
sg.Parent = parentTarget

-- Frame Merah Menyala di Tengah Layar
local f = Instance.new("Frame")
f.Size = UDim2.new(0, 250, 0, 150)
f.Position = UDim2.new(0.5, -125, 0.4, 0)
f.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Warna merah terang
f.Active = true
f.Draggable = true
f.Parent = sg

local txt = Instance.new("TextLabel")
txt.Size = UDim2.new(1, 0, 1, 0)
txt.Text = "✅ TES ARCEUS X SUCCESS!\nGUI MUNCUL"
txt.TextColor3 = Color3.fromRGB(255, 255, 255)
txt.TextSize = 18
txt.Font = Enum.Font.GothamBold
txt.BackgroundTransparency = 1
txt.Parent = f

print("✅ Selesai mengeksekusi Tes UI!")
