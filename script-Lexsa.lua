-- Script Targeted Folder Hunter by Gemini
local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
_G.TargetFarm = true

-- Fungsi untuk ambil item
function collect(v)
    if v:IsA("BasePart") or v:IsA("Model") then
        local pos = v:IsA("Model") and v:GetModelCFrame() or v.CFrame
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
        
        -- Tembak RemoteEvent yang kamu temukan di SimpleSpy
        local args = {[1] = nil}
        Remote:FireServer(unpack(args))
        task.wait(0.2)
    end
end

spawn(function()
    while _G.TargetFarm do
        -- Cek folder Workspace secara mendalam
        for _, folder in pairs(game.Workspace:GetChildren()) do
            -- Kita cari folder yang kemungkinan besar tempat spawn item
            if folder.Name:find("Drops") or folder.Name:find("Item") or folder.Name:find("Brainrot") then
                for _, item in pairs(folder:GetChildren()) do
                    if item.Name:lower():find("supreme") then
                        collect(item)
                    end
                end
            end
        end
        task.wait(1)
    end
end)
