-- FUNGSI ESP PINTER (AUTO-UPDATE)
local b2 = Instance.new("TextButton", f)
b2.Size = UDim2.new(0.9, 0, 0, 40)
b2.Position = UDim2.new(0.05, 0, 0.55, 0)
b2.Text = "AUTO ESP (ON)"
b2.BackgroundColor3 = Color3.fromRGB(0, 100, 0) -- Ijo (Tanda Aktif)

b2.MouseButton1Click:Connect(function()
    _G.AutoESP = true -- Pake Global biar gampang matiin
    b2.Text = "ESP STARTED"
    b2.BackgroundColor3 = Color3.fromRGB(0, 50, 0)

    -- LOGIKA UTAMA: Loop terus-menerus
    task.spawn(function()
        while _G.AutoESP do
            for _, v in pairs(game.Players:GetPlayers()) do
                -- CEK 1: Bukan Kita, Punya Karakter, Belum Ada ESP
                if v ~= p and v.Character and not v.Character:FindFirstChild("LEXSA_ESP") then
                    -- CEK 2: Punya Bagian Tubuh Utama
                    if v.Character:FindFirstChild("HumanoidRootPart") then
                        -- BIKIN ESP (Highlight)
                        local esp = Instance.new("Highlight")
                        esp.Name = "LEXSA_ESP"
                        esp.Parent = v.Character
                        esp.FillColor = Color3.new(1, 0, 0) -- Merah
                        esp.OutlineColor = Color3.new(1, 1, 1) -- Garis Putih
                    end
                end
            end
            task.wait(2) -- Nunggu 2 detik baru scan lagi (biar Poco F3 gak panas)
        end
    end)
end)
