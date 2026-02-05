-- LEXSA MENU V28: ULTRA FAST TAME
-- (Lebih aman daripada Dupe yang berisiko Banned)

-- ... (Bagian UI tetap sama seperti V27) ...

addToggle("ULTRA TAME", Color3.fromRGB(0, 255, 150), function(state)
    _G.UltraTame = state
    task.spawn(function()
        while _G.UltraTame do
            pcall(function()
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    -- Mencari monster terdekat
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                        local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude
                        if dist < 15 then
                            -- Menjalankan perintah TAME (Sesuaikan dengan tombol di game, misal 'E')
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
                            task.wait(0.05)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
                        end
                    end
                end
            end)
            task.wait(0.1)
        end
    end)
end)

-- ... (Sisanya tetap menggunakan fitur V27) ...
