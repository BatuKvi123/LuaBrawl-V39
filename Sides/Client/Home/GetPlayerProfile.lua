local G = {}
local sp = require "sendPacket"
function G.decode(r, pyld)
    pyld.a = r:readVint()
    pyld.plrID = r:readVint()
end

function G.process(client, pyld)
    sp.send(client, 24113, 0)
end

return G