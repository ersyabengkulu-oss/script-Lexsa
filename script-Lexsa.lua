-- V6.6: IY-LOGIC CLONE (PHYSICS BYPASS)
addToggle("LEXSA INF JUMP", Color3.fromRGB(0, 255, 255), function(state)
    _G.IYCloneJump = state
    local UserInputService = game:GetService("UserInputService")
    
    UserInputService.JumpRequest:Connect(function()
        if _G.IYCloneJump then
            pcall(function()
                local lp = game.Players.LocalPlayer
                local char = lp.Character
                local hum = char:FindFirstChildOfClass("Humanoid")
                local hrp = char:FindFirstChild("HumanoidRootPart")
                
                -- Teknik Rahasia IY: Memaksa status jumping berulang kali
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                
                -- Memberikan dorongan fisik (Velocity) langsung ke badan 
                -- Ini cara paling susah diblokir karena menggunakan fisika dasar Roblox
                hrp.Velocity = Vector3.new(hrp.Velocity.X, 45, hrp.Velocity.Z)
            end)
        end
    end)
end)
