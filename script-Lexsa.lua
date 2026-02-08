-- Brute Force Supreme Hunter by Gemini
local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
_G.SapuBersih = true

spawn(function()
    while _G.SapuBersih do
        local character = game.Players.LocalPlayer.Character
        if character then
            local root = character:WaitForChild("HumanoidRootPart")
            for _, v in pairs(game.Workspace:GetDescendants()) do
                -- Mencari objek apapun yang punya 'TouchInterest' (bisa diambil)
                if v:IsA("TouchTransmitter") then
                    -- Teleport ke objek tersebut
                    root.CFrame = v.Parent.CFrame
                    
                    -- Tembak RemoteEvent yang kamu dapet dari Spy
                    local args = {[1] = nil}
                    Remote:FireServer(unpack(args))
                    
                    task.wait(0.1) -- Sangat cepat
                end
            end
        end
        task.wait(0.5)
    end
end)
