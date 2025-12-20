local G = {}
local sp = require "sendPacket"
function G.decode(r, pyld)
    pyld.name = r:readString()
    pyld.idk = r:readBoolean()
end

function G.process(client, pyld)
    sp.send(client, 24111, 0, pyld.name)
end

return G