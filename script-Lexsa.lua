-- LEXSA NOTIFIER SYSTEM
local function notify(title, msg)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title;
        Text = msg;
        Duration = 3;
    })
end
