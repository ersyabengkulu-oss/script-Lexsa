-- V6.4: IY-STYLE INF JUMP (BERHASIL BYPASS)
addToggle("POWER INF JUMP", Color3.fromRGB(0, 255, 255), function(state)
    _G.IYJump = state
    local UserInputService = game:GetService("UserInputService")
    
    -- Menggunakan koneksi langsung ke JumpRequest seperti Infinite Yield
    UserInputService.JumpRequest:Connect(function()
        if _G.IYJump then
            local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState("Jumping")
            end
        end
    end)
end)
