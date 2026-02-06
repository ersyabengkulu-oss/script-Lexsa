-- Logika Lava Walking yang diperbarui
task.spawn(function()
    while walking do
        for _, v in pairs(game.Workspace:GetDescendants()) do
            -- Kita cek apakah namanya mengandung "lava" ATAU "kill" ATAU warnanya merah
            if v:IsA("BasePart") then
                local name = v.Name:lower()
                if name:find("lava") or name:find("kill") or v.Color == Color3.fromRGB(255, 0, 0) then
                    v.CanTouch = false -- Mematikan deteksi damage
                end
            end
        end
        task.wait(1) -- Scan lebih cepat setiap 1 detik
    end
end)
