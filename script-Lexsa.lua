-- V6.2: LOW-PROFILE SAFE JUMP (ANTI-KICK)
addToggle("SAFE INF JUMP", Color3.fromRGB(0, 200, 255), function(state)
    _G.SafeJump = state
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.SafeJump then
            local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            
            if hrp and hum then
                -- Status jumping agar animasi terlihat normal
                hum:ChangeState("Jumping")
                -- Dorongan kecil (Y = 35) agar tidak melambung terlalu tinggi
                hrp.Velocity = Vector3.new(hrp.Velocity.X, 35, hrp.Velocity.Z)
            end
        end
    end)
end)
