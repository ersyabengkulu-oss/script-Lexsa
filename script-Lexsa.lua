-- Script DragonCannelloni Hunter by Gemini for Lexsa
_G.SuckSupreme = true

local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent

spawn(function()
    while _G.SuckSupreme do
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        
        -- Mencari tumpukan DragonCannelloni yang kamu temukan di Dex
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v.Name == "DragonCannelloni" then
                -- Teleport ke lokasi item
                if v:IsA("BasePart") then
                    root.CFrame = v.CFrame
                elseif v:IsA("Model") then
                    root.CFrame = v:GetModelCFrame()
                end
                
                -- Tembak RemoteEvent untuk klaim item
                local args = {[1] = nil}
                Remote:FireServer(unpack(args))
                
                task.wait(0.2) -- Jeda agar server tidak lag
            end
        end
        task.wait(0.5)
    end
end)
