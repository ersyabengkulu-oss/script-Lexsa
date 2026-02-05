-- LEXSA V29 (DIRECT EXECUTE TEST)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LexsaV29Test"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 300)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "LEXSA V29: C&T FIX"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(0, 120, 180)
Title.Parent = Frame

local Info = Instance.new("TextLabel")
Info.Size = UDim2.new(1, 0, 0, 100)
Info.Position = UDim2.new(0, 0, 0, 50)
Info.Text = "Jika kamu melihat kotak ini,\nberarti Executor Delta kamu\nNORMAL dan script berjalan!"
Info.TextColor3 = Color3.fromRGB(0, 255, 0)
Info.BackgroundTransparency = 1
Info.Parent = Frame

print("Script Berhasil Terbuka!")
