-- Script Auto Click Button (Lebih Aman)
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

spawn(function()
    while task.wait(5) do
        -- Mencari tombol Sell di layar berdasarkan screenshot kamu
        for _, v in pairs(playerGui:GetDescendants()) do
            if v:IsA("TextButton") and v.Text:find("Sell") then
                -- Simulasi klik tombol
                v.Size = UDim2.new(1.1, 0, 1.1, 0) -- Animasi sedikit biar natural
                task.wait(0.1)
                v.Size = UDim2.new(1, 0, 1, 0)
                
                -- Panggil fungsi klik aslinya
                for _, connection in pairs(getconnections(v.MouseButton1Click)) do
                    connection:Fire()
                end
            end
        end
    end
end)
