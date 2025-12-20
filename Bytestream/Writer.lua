local Writer = {}
Writer.__index = Writer

-- tw: retardism
-- i added zlib since i followed bsds loginokmsg this time
-- i also tried to make it same as bsds funcs (well i tried(??))

local zlib = require("zlib")

function Writer.new()
    return setmetatable({ buffer = {} }, Writer)
end

function Writer:Rbuffer()
    return table.concat(self.buffer)
end

local function byte(b)
    return string.char(b & 0xFF)
end

function Writer:writeByte(v)
    self.buffer[#self.buffer + 1] = byte(v)
end

function Writer:writeBoolean(v)
    self:writeByte(v and 1 or 0)
end

function Writer:writeShort(v)
    self:writeByte(v >> 8)
    self:writeByte(v)
end

function Writer:writeInt(v)
    self:writeByte(v >> 24)
    self:writeByte(v >> 16)
    self:writeByte(v >> 8)
    self:writeByte(v)
end

function Writer:writeLongLong(v)
    self:writeInt(v >> 32)
    self:writeInt(v)
end

function Writer:writeVint(value)
    local sign = value < 0
    if sign then value = -value end

    local temp = value & 0x3F
    value = value >> 6

    if sign then temp = temp | 0x40 end
    if value ~= 0 then temp = temp | 0x80 end
    self:writeByte(temp)

    while value ~= 0 do
        temp = value & 0x7F
        value = value >> 7
        if value ~= 0 then temp = temp | 0x80 end
        self:writeByte(temp)
    end
end

function Writer:writeString(str)
    if not str then
        self:writeInt(-1)
        return
    end
    self:writeInt(#str)
    self.buffer[#self.buffer + 1] = str
end

function Writer:writeBytes(bytes)
    if not bytes or #bytes == 0 then
        self:writeInt(-1)
        return
    end
    self:writeInt(#bytes)
    for i = 1, #bytes do
        self:writeByte(bytes:byte(i))
    end
end

function Writer:writeLongInt(value1, value2)
    self:writeInt(value1)
    self:writeInt(value2)
end

function Writer:write_string_reference(str)
    if not str then
        self:writeVint(-1)
        return
    end
    self:writeVint(#str)
    self.buffer[#self.buffer + 1] = str
end

function Writer:write_data_reference(data)
    if not data or #data == 0 then
        self:writeVint(-1)
        return
    end
    self:writeVint(#data)
    for i = 1, #data do
        self:writeByte(data:byte(i))
    end
end

function Writer:writeIntLE(data, length)
    length = length or 4
    for i = 0, length - 1 do
        self:writeByte((data >> (8 * i)) & 0xFF)
    end
end

function Writer:writeCompressedString(data)
    local compressed = zlib.compress(data)
    self:writeInt(#compressed + 4)
    self:writeIntLE(#data)
    self.buffer[#self.buffer + 1] = compressed
end

return Writer