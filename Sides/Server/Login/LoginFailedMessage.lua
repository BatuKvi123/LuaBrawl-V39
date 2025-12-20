-- [broken]

local LoginFailed = {}
local writer = require "Bytestream.Writer"

LoginFailed.packetID = 20103

function LoginFailed.encode()
    local w = writer.new()
        w:writeInt(1)
        w:writeString()
        w:writeString()
        w:writeString()
        w:writeString()
        w:writeString("LUA BRAWL V39 - by batu")
        w:writeInt(0)
        w:writeBoolean(false)
        w:writeBytes("")
        w:writeInt(0)
        w:writeInt(0)
        w:writeInt(0)
        w:writeString()
        w:writeInt(0)
        w:writeByte(3)
        w:write_string_reference()
        w:writeVint(0)
        w:write_string_reference()
        w:writeBoolean(false)
    
    return w:Rbuffer()
end

return LoginFailed