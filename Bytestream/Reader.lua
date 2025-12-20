local Reader = {}
Reader.__index = Reader

-- exactly like py one bogigigitjrjjjfeiciddkjw
-- TW: retardism

-- and idc abt reader

function Reader.new(data)
    local self = setmetatable({}, Reader)
    self.buffer = data or ""
    self.pos = 1
    return self
end

function Reader:readInt(length)
    length = length or 4
    local fmt = ">".."I"..length
    local val
    val, self.pos = string.unpack(fmt, self.buffer, self.pos)
    return val
end

function Reader:readInt8()
    return self:readInt(1)
end

function Reader:readInt16()
    return self:readInt(2)
end

function Reader:readByte()
    return self:readInt8()
end

function Reader:readBoolean()
    return self:readByte() ~= 0
end

function Reader:readVint()
    local result = 0
    local shift = 0
    while true do
        local b = self:readByte()
        result = result | ((b & 0x7F) << shift)
        if (b & 0x80) == 0 then break end
        shift = shift + 7
    end
    return result
end

function Reader:readString()
    local length = self:readInt()
    if length == 0xFFFFFFFF then
        return nil
    end
    local str = self.buffer:sub(self.pos, self.pos + length - 1)
    self.pos = self.pos + length
    return str
end

function Reader:readBytes()
    local length = self:readInt()
    local data = self.buffer:sub(self.pos, self.pos + length - 1)
    self.pos = self.pos + length
    return data
end

function Reader:readLong()
    local high = self:readInt(4)
    local low = self:readInt(4)
    return high, low
end

function Reader:readLogicLong()
    return self:readVint(), self:readVint()
end

return Reader