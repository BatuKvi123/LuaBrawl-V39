local LoginOK = {}
local writer = require "Bytestream.Writer"
local cm = require "Logic.ClientManager"

LoginOK.packetID = 20104

function LoginOK.encode(client)
    local w = writer.new()
    local player = cm.get(client)
    if not player then print("lgnokmsg CLIENT NOT FOUND") end
    w:writeInt(player.lowid)
    w:writeInt(player.lowid)
    w:writeInt(player.lowid)
    w:writeInt(player.lowid)
    w:writeString(player.token) -- token
    w:writeString("")
    w:writeString("")
    w:writeInt(39)
    w:writeInt(110)
    w:writeInt(1)
    w:writeString("dev")
    w:writeInt(0)
    w:writeInt(0)
    w:writeInt(0)
    w:writeString("")
    w:writeString("")
    w:writeString("")
    w:writeInt(0)
    w:writeString("")
    w:writeString("TR")
    w:writeString("")
    w:writeInt(2)
    w:writeString("")
    w:writeInt(2)
    w:writeString("https://game-assets.brawlstarsgame.com")
    w:writeString("http://a678dbc1c015a893c9fd-4e8cc3b1ad3a3c940c504815caefa967.r87.cf2.rackcdn.com")
    w:writeInt(2)
    w:writeString("https://event-assets.brawlstars.com")
    w:writeString("https://24b999e6da07674e22b0-8209975788a0f2469e68e84405ae4fcf.ssl.cf2.rackcdn.com/event-assets")
    w:writeVint(0)
    w:writeCompressedString("")
    w:writeBoolean(true)
    w:writeString("")
    w:writeString("")
    w:writeString("")
    w:writeString("https://play.google.com/store/apps/details?id=com.supercell.brawlstars")
    w:writeString("")
    w:writeBoolean(false)
    return w:Rbuffer()
end

return LoginOK