-- Script Supreme Hunter (Anti-Self Base) by Gemini
_G.SuckSupreme = true

local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local player = game.Players.LocalPlayer

spawn(function()
    while _G.SuckSupreme do
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        
        for _, v in pairs(game.Workspace:GetDescendants()) do
            -- Syarat 1: Namanya DragonCannelloni
            -- Syarat 2: Pastikan naga ini BUKAN bagian dari base milik kamu
            if v.Name == "DragonCannelloni" and not v:IsDescendantOf(game.Workspace:FindFirstChild(player.Name .. "'s Base") or game.Workspace:FindFirstChild("PlayerBases")) then
                
                -- Teleport hanya jika itu naga liar di map
                if v:IsA("BasePart") then
                    root.CFrame = v.CFrame
                elseif v:IsA("Model") then
                    root.CFrame = v:GetModelCFrame()
                end
                
                -- Tembak RemoteEvent klaim
                local args = {[1] = nil}
                Remote:FireServer(unpack(args))
                task.wait(0.3)
            end
        end
        task.wait(1)
    end
end)
