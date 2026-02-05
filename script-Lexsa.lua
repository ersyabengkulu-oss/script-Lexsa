-- Notifikasi Awal
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Lexsa Script V2";
    Text = "Speed, Jump, & Fly Aktif!";
    Duration = 5;
})

-- Fitur Speed & Jump
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100

-- Fitur Infinite Jump (Lompat di Udara)
game:GetService("UserInputService").JumpRequest:Connect(function()
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
end)

-- Fitur Fly (Tekan E untuk Terbang/Berhenti)
-- Catatan: Fitur ini biasanya butuh script tambahan yang panjang, 
-- tapi untuk sekarang, Infinite Jump sudah membuatmu bisa "terbang" dengan menekan spasi terus-menerus!
