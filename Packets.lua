local Packets = {}

-- add all the packets here

Packets.list = {
    [10101] = {n="LoginMessage", p=""},
    [20104] = {n="LoginOkMessage", p="Sides.Server.Login.LoginOK"},
    [24101] = {n="OwnHomeDataMessage", p="Sides.Server.Home.OwnHomeData"},
    [10110] = {n="AnalyticsEventEvent", p="Sides.Client.AnalyticsEventMessage"},
    [14366] = {n="PlayerStatusEvent", p="Sides.Client.PlayerStatusMessage"},
    [20103] = {n="LoginFailedMessage", p="Sides.Server.Login.LoginFailedMessage"},
    [23457] = {n="LobbyInfoMessage", p="Sides.Server.Home.LobbyInfoMessage"},
    [24113] = {n="PlayerProfileMessage", p="Sides.Server.Home.PlayerProfileMessage"},
    [14113] = {n="GetPlayerProfile", p="Sides.Client.Home.GetPlayerProfile"},
    [14109] = {n="GoHomeMessage", p="Sides.Client.Home.GoHome"},
    [10108] = {n="KeepAliveMessage", p="Sides.Client.KeepAlive"},
    [24111] = {n="ChangeNameMessage", p="Sides.Server.Home.ChangeNameMessage"}, --might add special action for 24111 id soon
    [10212] = {n="SetName", p="Sides.Client.Home.SetName"}
}

function Packets.GetName(packetid)
    local p=Packets.list[packetid]
    if p then return p.n else return "NOT FOUND" end
end

return Packets