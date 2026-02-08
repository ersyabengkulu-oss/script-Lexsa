-- Script DragonCannelloni Hunter (Anti-Base) by Gemini
_G.SuckSupreme = true

local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local player = game.Players.LocalPlayer

spawn(function()
    while _G.SuckSupreme do
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        
        for _, v in pairs(game.Workspace:GetDescendants()) do
            -- Filter 1: Nama harus DragonCannelloni
            -- Filter 2: Pastikan BUKAN bagian dari base kamu (mengecek nama folder induknya)
            if v.Name == "DragonCannelloni" and not v:IsDescendantOf(game.Workspace:FindFirstChild(player.Name .. "'s Base") or game.Workspace) then
                
                -- Tambahan: Abaikan jika item berada di folder 'PlayerBases' atau sejenisnya
                if not v.Parent.Name:find("Base") and not v.Parent.Parent.Name:find("Base") then
                    if v:IsA("BasePart") then
                        root.CFrame = v.CFrame
                    elseif v:IsA("Model") then
                        root.CFrame = v:GetModelCFrame()
                    end
                    
                    local args = {[1] = nil}
                    Remote:FireServer(unpack(args))
                    task.wait(0.3)
                end
            end
        end
        task.wait(1)
    end
end)
