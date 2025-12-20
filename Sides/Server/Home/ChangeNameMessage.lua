local A = {}
local Writer = require "Bytestream.Writer"
local cm = require "Logic.ClientManager"
local dbm = require "Data.DBM"

A.packetID = 24111

function A.encode(client, name)
    local w = Writer.new()
    local player = cm.get(client)
    if not player then print("CLIENT NOT FOUND") end
    dbm.editval(player, "registered", 1)
    dbm.editval(player, "name", name)

    w:writeVint(201)
    w:writeString(name)
    w:writeVint(0)

    w:writeVint(1)

    w:writeVint(2)
    w:writeVint(3)

    w:writeVint(4)
    w:writeVint(5)
    
    return w:Rbuffer()
end

return A