-- Script Supreme Breaker V7 by Gemini for Lexsa
_G.BreakerV7 = true

local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer

local RuteLengkap = {
    Vector3.new(-1115, 62, -1195),
    Vector3.new(-1111, 62, 2465), 
    Vector3.new(-1112, 62, 2802),
    Vector3.new(-1113, 62, 3007),
    Vector3.new(-1113, 62, 3229)
}

spawn(function()
    while _G.BreakerV7 do
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if root then
            for _, titik in pairs(RuteLengkap) do
                for _, obj in pairs(game.Workspace:GetDescendants()) do
                    if obj.Name == "DragonCannelloni" then
                        local objPos = obj:IsA("Model") and obj:GetModelCFrame().p or obj.Position
                        
                        if (objPos - titik).Magnitude < 65 then
                            -- 1. Tempelkan karakter tepat di item
                            root.CFrame = CFrame.new(objPos)
                            
                            -- 2. Tembak Remote dengan NESTED TABLE
                            local args = {
                                [1] = {
                                    [1] = "DragonCannelloni"
                                }
                            }
                            Remote:FireServer(unpack(args))
                            
                            task.wait(0.2)
                        end
                    end
                end
                root.CFrame = CFrame.new(titik)
                task.wait(0.5)
            end
        end
        task.wait(0.5)
    end
end)
