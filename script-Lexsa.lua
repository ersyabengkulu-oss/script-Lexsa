-- Script Supreme Hunter by Gemini for Lexsa
_G.OnlySupreme = true

spawn(function()
    while _G.OnlySupreme do
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        
        -- Scan map buat cari Supreme
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name:find("Supreme") then
                -- Teleport langsung ke lokasi Supreme
                root.CFrame = v.CFrame
                task.wait(0.3) -- Jeda dikit biar masuk ke inventory
            end
        end
        task.wait(0.5) -- Scan ulang tiap setengah detik
    end
end)

-- Auto Clicker tetap jalan biar uang nambah terus
spawn(function()
    while _G.OnlySupreme do
        game:GetService("ReplicatedStorage").Events.ClickEvent:FireServer()
        task.wait(0.01)
    end
end)
