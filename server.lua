-- variables
local socket=require("socket"); local ClientManager=require "Logic.ClientManager"; local reader=require("Bytestream.Reader"); local Packets=require("Packets"); local sendPacket=require("sendPacket"); local clientpackets=require("ClientPackets"); local sql=require("lsqlite3")

-- init
local server = assert(socket.bind("*", 9339)); server:settimeout(0)

print("LuaBrawl V39 - by batu")
print("server started on ip 0.0.0.0 / port 9339")

-- MISC
local function playercount()
    local c = 0
    for _ in pairs(ClientManager.clients) do c = c + 1 end
    return c
end

-- database creation (for getting rid of not found thingy)
local conn = sql.open("Data/players.db")
conn:exec([[CREATE TABLE IF NOT EXISTS plrs(
    lowid INT,
    token TEXT,
    name TEXT,
    trophies INT,
    gold INT,
    gems INT,
    TvTW INT,
    SW INT,
    DW INT,
    exp INT,
    registered BOOL
)]])

-- main
while true do
    local client = server:accept()
    if client then
        client:settimeout(0)
        ClientManager.add(client)
    end

    for client, state in pairs(ClientManager.clients) do
        local chunk, err, partial = client:receive(4096)
        local data = chunk or partial

        if err == "closed" then
            local ip, port = client:getpeername()
            print("client disconnected: "..ip..":"..port)
            ClientManager.remove(client)
            client:close()
        elseif data and #data > 0 then
            state.buffer = state.buffer .. data

            while #state.buffer >= 7 do
                local b1, b2 = state.buffer:byte(1, 2)
                local packetid = (b1 << 8) | b2

                local l1, l2, l3 = state.buffer:byte(3, 5)
                local length = (l1 << 16) | (l2 << 8) | l3

                local v1, v2 = state.buffer:byte(6, 7)
                local version = (v1 << 8) | v2

                if #state.buffer < 7 + length then
                    break
                end

                local payload = state.buffer:sub(8, 7 + length)
                state.buffer = state.buffer:sub(8 + length)

                local name = Packets.GetName(packetid)
                if name ~= "NOT FOUND" then
                    local ip, port = client:getpeername()
                    print("[CLIENT] ["..ip..":"..port.."] received "..packetid.." ("..name..")")
                else
                    local ip, port = client:getpeername()
                    print("["..ip..":"..port.."]: PACKET ID "..packetid.." IS NOT HANDLED")
                end

                if packetid == 10101 and not state.joined then
                    state.joined = true
                    local ip, port = client:getpeername()
                    print(ip..":"..port.." joined")
                    print("Player count: "..playercount())
                end

                local path = clientpackets.GetPath(packetid)
                if path and path ~= "PATH NOT FOUND" then
                    package.loaded[path] = nil
                    local cPacket = require(path)
                    local r = reader.new(payload)
                    local pyld = { version = version }
                    cPacket.decode(r, pyld)
                    cPacket.process(client, pyld)
                end
            end
        end
    end

    socket.sleep(0.005)
end