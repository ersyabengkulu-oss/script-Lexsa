-- Super X-Ray Lexsa Edition
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
        -- Menghapus tekstur dan membuat dinding benar-benar tembus pandang
        if v.Material == Enum.Material.Slate or v.Material == Enum.Material.Rock or v.Name:find("Wall") then
            v.Transparency = 0.8 -- Bisa kamu ubah ke 1 kalau mau hilang total
            v.CanCollide = true -- Tetap bisa diinjak tapi tembus pandang
        end
    end
end
