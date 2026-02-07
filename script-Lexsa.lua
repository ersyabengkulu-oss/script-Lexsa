-- Script X-Ray My Mining Brainrot
local transparencyLevel = 0.5 -- Semakin besar (max 1), semakin transparan

for _, v in pairs(game.Workspace:GetDescendants()) do
    -- Mencari objek yang menghalangi pandangan (Batu/Dinding)
    if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
        -- Jika namanya mengandung pola batu atau material dinding
        if v.Name:find("_") or v.Material == Enum.Material.Slate or v.Material == Enum.Material.Rock then
            v.LocalTransparencyModifier = transparencyLevel
        end
    end
end

print("X-Ray Aktif! Sekarang dinding gua harusnya terlihat transparan.")
