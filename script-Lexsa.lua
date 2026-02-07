-- ESP KHUSUS DIAMOND EGG (Visual Only - Paling Aman)
local function buatSinar(obj)
    if not obj:FindFirstChild("SinarLexsa") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "SinarLexsa"
        highlight.Parent = obj
        highlight.FillColor = Color3.new(0, 1, 1) -- Warna Cyan Diamond
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.new(1, 1, 1)
    end
end

-- Scan cari telur Diamond di dalam gua
for _, v in pairs(game.Workspace:GetDescendants()) do
    if v.Name:find("Egg") or v.Name:find("Diamond") then
        buatSinar(v)
    end
end
