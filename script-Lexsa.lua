-- Script V17 Tora-Style Mimic by Gemini for Lexsa
local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer

_G.AutoPick = true

spawn(function()
    while _G.AutoPick do
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if root then
            -- Kita cari di Workspace secara luas tapi dengan filter ketat
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "DragonCannelloni" and v:IsA("Model") then
                    -- Pastikan ini naga yang ada tombol "Pick up"-nya
                    local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if prompt and prompt.ActionText == "Pick up" then
                        local targetPos = v:GetModelCFrame().p
                        
                        -- Teleport tipis-tipis biar nggak dikira exploit kasar
                        root.CFrame = CFrame.new(targetPos)
                        task.wait(0.1)
                        
                        -- Tembak remote dengan format Nested Table sesuai log kamu
                        Remote:FireServer({[1] = {[1] = "DragonCannelloni"}})
                        
                        -- Trigger tombol E secara virtual
                        fireproximityprompt(prompt)
                        task.wait(0.2)
                    end
                end
            end
        end
        task.wait(1) -- Istirahat sebentar biar nggak lag
    end
end)
