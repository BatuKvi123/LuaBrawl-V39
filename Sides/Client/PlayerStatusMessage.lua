local PlayerStatus = {}

function PlayerStatus.decode(r, pyld)
    pyld.plrping = r:readVint()
end

function PlayerStatus.process(client, pyld)
    print("status of "..client:getpeername()..": "..pyld.plrping)
end

return PlayerStatus