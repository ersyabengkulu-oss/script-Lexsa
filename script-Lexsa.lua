local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- 1. TAMPILAN JENDELA KEY
local KeyGui = Instance.new("ScreenGui", PlayerGui)
local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0, 250, 0, 150)
KeyFrame.Position = UDim2.new(0.5, -125, 0.4, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KeyFrame.Active = true
KeyFrame.Draggable = true

local Label = Instance.new("TextLabel", KeyFrame)
Label.Size = UDim2.new(1, 0, 0, 40)
Label.Text = "LEXSA LAVA CORE: KEY"
Label.BackgroundColor3 = Color3.fromRGB(200, 50, 0)
Label.TextColor3 = Color3.new(1, 1, 1)

-- 2. TEMPAT KETIK KEY
local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(0.8, 0, 0, 30)
KeyInput.Position = UDim2.new(0.1, 0, 0.4, 0)
KeyInput.PlaceholderText = "Enter Key Here..."
KeyInput.Text = ""

-- 3. TOMBOL GET KEY (LINKVERTISE)
local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.Size = UDim2.new(0.35, 0, 0, 30)
GetKeyBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
GetKeyBtn.Text = "GET KEY"
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://link-kamu-disini.com") -- Otomatis salin link iklan
    print("Link Key Berhasil Disalin!")
end)

-- 4. TOMBOL CHECK KEY
local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.Size = UDim2.new(0.35, 0, 0, 30)
CheckBtn.Position = UDim2.new(0.55, 0, 0.7, 0)
CheckBtn.Text = "CHECK"
CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)

CheckBtn.MouseButton1Click:Connect(function()
    -- Ambil Key dari Raw GitHub kamu
    local success, currentKey = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/ersyabengkulu-oss/script-Lexsa/main/key.txt")
    end)

    if success and KeyInput.Text == currentKey:gsub("%s+", "") then
        print("Key Benar!")
        KeyGui:Destroy() -- Tutup jendela Key
        -- JALANKAN SCRIPT UTAMA DISINI
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "WRONG KEY!"
    end
end)
