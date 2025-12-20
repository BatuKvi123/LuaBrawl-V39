local PlayerProfile = {}
local Writer = require "Bytestream.Writer"
local cm = require "Logic.ClientManager"

PlayerProfile.packetID = 24113

function PlayerProfile.encode(client)
    local w = Writer.new()
    local player = cm.get(client)
    if not player then print("CLIENT NOT FOUND") end

    w:writeVint(player.lowid)
    w:writeVint(player.lowid)
    w:writeVint(0)
    w:writeVint(0)
    
    w:writeVint(15)
    
    w:writeVint(1)
    w:writeVint(player.TvTW) -- 3v3 wins
    
    w:writeVint(2)
    w:writeVint(player.exp) -- player experience point
    
    w:writeVint(3)
    w:writeVint(player.trophies) -- current trophies
    
    w:writeVint(4)
    w:writeVint(player.trophies) -- highest trophies
    
    w:writeVint(5)
    w:writeVint(1) -- how many brawler
    
    w:writeVint(8)
    w:writeVint(player.SW) -- solo wins
    
    w:writeVint(11)
    w:writeVint(player.DW) -- duo wins
    
    w:writeVint(9)
    w:writeVint(0) -- highest robo rumble passed
    
    w:writeVint(12)
    w:writeVint(0) -- highest boss fight passed
    
    w:writeVint(13)
    w:writeVint(100)
    
    w:writeVint(14)
    w:writeVint(0)
    
    w:writeVint(15)
    w:writeVint(0) -- most challenge wins
    
    w:writeVint(16)
    w:writeVint(0) -- highest rampage passed
    
    w:writeVint(18)
    w:writeVint(0) -- highest solo league
    
    w:writeVint(17)
    w:writeVint(0) -- highest team league
    
    w:writeString(player.name)
    w:writeVint(100)
    
    w:writeVint(28000001) -- thumbnail
    w:writeVint(43000001) -- name color
    w:writeVint(-64)
    
    w:writeVint(0)
    w:writeVint(0)
    
    return w:Rbuffer()
end

return PlayerProfile