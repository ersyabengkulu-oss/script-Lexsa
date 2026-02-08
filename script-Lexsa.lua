-- Script Teleport Rarity Teratas by Gemini for Lexsa
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Daftar prioritas rarity yang ingin dikejar
local targets = {"Divine", "Supreme", "Radioactive", "Lava"}

for _, rarity in ipairs(targets) do
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        -- Mencari objek yang mengandung nama rarity di atas
        if obj:IsA("BasePart") and (obj.Name:find(rarity) or (obj.Parent and obj.Parent.Name:find(rarity))) then
            print("Target ditemukan: " .. obj.Name)
            rootPart.CFrame = obj.CFrame + Vector3.new(0, 3, 0) -- Teleport sedikit di atas objek
            wait(0.5) -- Jeda agar game sempat mendeteksi sentuhan
        end
    end
end
