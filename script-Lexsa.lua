-- Script Auto Sell Anti-Ribet
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Fungsi mencari Remote secara otomatis
local function findRemote(name)
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v.Name == name and v:IsA("RemoteFunction") then
            return v
        end
    end
end

local sellRemote = findRemote("SellJewels")

if sellRemote then
    print("Remote Jual Ketemu! Mencoba menjual...")
    spawn(function()
        while task.wait(5) do
            sellRemote:InvokeServer()
        end
    end)
else
    print("Remote Jual tidak ditemukan di ReplicatedStorage!")
end
