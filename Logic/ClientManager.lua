local ClientManager = {}

ClientManager.clients = {}

function ClientManager.add(client)
    ClientManager.clients[client] = {
        buffer = "",
        explen = 0,
        joined = false,
        player = nil
    }
    --print("added")
end


function ClientManager.remove(client)
    ClientManager.clients[client] = nil
    --print("removed")
end

function ClientManager.get(client)
    return ClientManager.clients[client].player
end

function ClientManager.getcli(client)
    return ClientManager.clients[client]
end

return ClientManager