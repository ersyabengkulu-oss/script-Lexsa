-- Script Supreme Aggressive Grabber by Gemini
_G.GrabberAktif = true

local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer
local TargetPos = Vector3.new(-1111, 62, 3232) 

spawn(function()
    while _G.GrabberAktif do
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if root then
            -- Cari naga di sekitar
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "DragonCannelloni" then
                    local itemPos = v:IsA("Model") and v:GetModelCFrame().p or v.CFrame.p
                    
                    -- Jika naga ada di samping (jarak kurang dari 50)
                    if (itemPos - root.Position).Magnitude < 50 then
                        -- Paksa karakter menempel ke naga (biar ke-trigger Pick up)
                        root.CFrame = CFrame.new(itemPos)
                        
                        -- Tembak Remote klaim (Sesuai log SimpleSpy kamu)
                        local args = {[1] = nil}
                        Remote:FireServer(unpack(args))
                        task.wait(0.1)
                    end
                end
            end
            
            -- Balik ke titik stand-by jika tidak ada naga
            root.CFrame = CFrame.new(TargetPos)
        end
        task.wait(0.2)
    end
end)
