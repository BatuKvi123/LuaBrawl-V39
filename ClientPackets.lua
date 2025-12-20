local ClientPackets = {}

-- put client packets here

ClientPackets.list = {
    [10110] = "Sides.Client.AnalyticsEventMessage",
    [14366] = "Sides.Client.PlayerStatusMessage",
    [10101] = "Sides.Client.Login.LoginMessage",
    [14113] = "Sides.Client.Home.GetPlayerProfile",
    [14109] = "Sides.Client.Home.GoHome",
    [10108] = "Sides.Client.KeepAlive",
    [10212] = "Sides.Client.Home.SetName"
}

function ClientPackets.GetPath(packet)
    return ClientPackets.list[packet] or "PATH NOT FOUND"
end

return ClientPackets