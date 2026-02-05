-- Notifikasi Awal
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Lexsa Script";
    Text = "Fitur Speed & Jump Aktif!";
    Duration = 5;
})

-- Fitur Speed (Kecepatan Lari)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100

-- Fitur Jump (Kekuatan Lompat)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100
