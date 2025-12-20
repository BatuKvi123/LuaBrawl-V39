local LobbyInfo = {}
local Writer = require "Bytestream.Writer"
local cm = require "Logic.ClientManager"

LobbyInfo.packetID = 23457

function LobbyInfo.encode(client)
    local w = Writer.new()
    local player = cm.get(client)
    if not player then print("CLIENT NOT FOUND") end

    w:writeVint(1)
    w:writeString("LuaBrawl V39\nby batu\nYour lowid: "..player.lowid.."\nhttps://github.com/BatuKvi123/LuaBrawl-V39\n"..string.rep("^",30).. " STAR MY REPO PLS!"..string.rep("\n", 80))
    w:writeVint(0)
    
    return w:Rbuffer()
end

return LobbyInfo