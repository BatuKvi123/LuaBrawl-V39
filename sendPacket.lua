local sendPacket = {}
local packets = require "Packets"
function sendPacket.send(client, packetId, version, ...)
    version = version or 0

    local info = packets.list[packetId]
    if not info then return end

    package.loaded[info.p] = nil
    local packet = require(info.p)

    local pyld = packet.encode(client, ...) or ""
    local length = #pyld
    
    -- thanks to c++ v39 for this
    local header = string.char((packetId >> 8) & 0xFF,packetId & 0xFF,(length >> 16) & 0xFF,(length >> 8) & 0xFF,length & 0xFF,(version >> 8) & 0xFF,version & 0xFF)
    
    client:send(header .. pyld)

    local ip, port = client:getpeername()
    print("[SERVER] ["..ip..":"..port.."] sent packet "..packetId.." ("..packets.GetName(packetId)..")")
end

return sendPacket