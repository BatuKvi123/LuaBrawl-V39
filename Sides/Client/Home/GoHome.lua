local G = {}
local sp = require "sendPacket"
function wait(s)os.execute("sleep "..s)end
function G.decode(r, pyld)
end

function G.process(client, pyld)
    sp.send(client, 24101, 0)
    wait(2)
    sp.send(client, 23457, 0)
end

return G