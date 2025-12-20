local Login = {}
local cm = require "Logic.ClientManager"
local dbm = require "Data.DBM"
local sp = require "sendPacket"
function wait(s)os.execute("sleep "..s)end

function Login.decode(r, pyld)
    pyld.HighID = r:readInt()
    pyld.LowID = r:readInt()
    pyld.Token = r:readString()
    pyld.maj = r:readInt()
    pyld.minor = r:readInt()
    pyld.build = r:readInt()
    pyld.fingprint = r:readString()
end

function Login.process(client, pyld)
    local acc
    local cli = cm.getcli(client)
    if not cli then print("lgnmsg CLIENT NOT FOUND") return end
    
    -- creating acc
    if pyld.Token and pyld.Token ~= "" then
        acc = dbm.loadacc(pyld.Token)
    end
    
    if not acc then
        acc = dbm.createacc()
    end
    
    cli.player = acc
    
    sp.send(client, 20104, 0)
    sp.send(client, 24101, 0)
    wait(2)
    sp.send(client, 23457, 0)
end

return Login