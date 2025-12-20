local OwnHomeData = {}
local Writer = require "Bytestream.Writer"
local cm = require "Logic.ClientManager"
local dbm = require "Data.DBM"

OwnHomeData.packetID = 24101

function OwnHomeData.encode(client)
    local w = Writer.new()
    local player = cm.get(client)
    if not player then print("CLIENT NOT FOUND") end

    w:writeVint(0);
   w:writeVint(0);
   w:writeVint(player.trophies);
   w:writeVint(player.trophies);
   w:writeVint(player.trophies);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(1);
   w:writeVint(1);
   w:writeVint(28);
   w:writeVint(0);
   w:writeVint(43);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(1);
   w:writeBoolean(false);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(5);
   w:writeVint(1);
   w:writeVint(1);
   w:writeVint(1);
   w:writeVint(1);
   w:writeVint(1);
   w:writeByte(4);
   w:writeVint(2);
   w:writeVint(2);
   w:writeVint(2);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeBoolean(false);
   w:writeVint(9999);
   w:writeVint(-64);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(16);
   w:writeVint(math.random(0, 52)); -- selected character
   w:writeString("TR");
   w:writeString("LuaBrawl V39"); -- promo code
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(1);
   w:writeVint(8);
   w:writeVint(0);
   w:writeVint(1);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeBoolean(true);
   w:writeVint(0);
   w:writeBoolean(true);
   w:writeVint(0);
   w:writeBoolean(false);
   w:writeInt(0);
   w:writeVint(0);
   w:writeVint(22);
   w:writeVint(1);
   w:writeVint(2);
   w:writeVint(3);
   w:writeVint(4);
   w:writeVint(5);
   w:writeVint(6);
   w:writeVint(7);
   w:writeVint(8);
   w:writeVint(9);
   w:writeVint(10);
   w:writeVint(11);
   w:writeVint(12);
   w:writeVint(13);
   w:writeVint(14);
   w:writeVint(15);
   w:writeVint(16);
   w:writeVint(17);
   w:writeVint(20);
   w:writeVint(21);
   w:writeVint(22);
   w:writeVint(23);
   w:writeVint(24);
   w:writeVint(1);
   w:writeVint(1);
   w:writeVint(1);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(15);
   w:writeVint(0);
   w:writeVint(-64);
   w:writeVint(2);
   w:writeString();
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeBoolean(false);
   w:writeVint(0);
   w:writeBoolean(false);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(-64);
   w:writeBoolean(false);
   w:writeVint(0);
   w:writeVint(8);
   w:writeVint(25);
   w:writeVint(40);
   w:writeVint(80);
   w:writeVint(145);
   w:writeVint(295);
   w:writeVint(485);
   w:writeVint(805);
   w:writeVint(1255);
   w:writeVint(4);
   w:writeVint(20);
   w:writeVint(50);
   w:writeVint(140);
   w:writeVint(280);
   w:writeVint(4);
   w:writeVint(150);
   w:writeVint(400);
   w:writeVint(1200);
   w:writeVint(2600);
   w:writeBoolean(false);
   w:writeVint(0);
   w:writeVint(13);
   w:writeLongInt(1,41000029);
   w:writeLongInt(61,36270);
   w:writeLongInt(29,10);
   w:writeLongInt(50,0);
   w:writeLongInt(14,0);
   w:writeLongInt(31,0);
   w:writeLongInt(79,149999);
   w:writeLongInt(80,160000);
   w:writeLongInt(28,4);
   w:writeLongInt(74,1);
   w:writeLongInt(78,1);
   w:writeLongInt(17,4);
   w:writeLongInt(10046,1);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeInt(0);
   w:writeInt(0);
   w:writeVint(1);
   w:writeVint(81);
   w:writeInt(1);
   w:writeBoolean(false);
   w:writeInt(0);
   w:writeString("LuaBrawl V39 by batu\nhttps://github.com/BatuKvi123/LuaBrawl-V39");
   w:writeVint(0);
   w:writeVint(-64);
   w:writeBoolean(false);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(player.lowid);
   w:writeVint(player.lowid);
   w:writeVint(player.lowid);
   w:writeVint(player.lowid);
   w:writeVint(player.lowid);
   w:writeVint(player.lowid);
   w:writeString(player.name);
   
   -- name enter (register)
   if player.registered == 1 then
       w:writeBoolean(true);
   else
       w:writeBoolean(false);
   end

   w:writeVint(1);
   w:writeString();
   w:writeVint(15);
   w:writeVint(1);
   w:writeVint(23);
   w:writeVint(1); -- 0 = need match to show up the shop, brawlers and things / 1 = show up everything
   w:writeVint(1);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(player.gems);
   w:writeVint(player.gems);
   w:writeVint(player.exp);
   w:writeVint(100);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(0);
   w:writeVint(2);
   w:writeVint(0);

    return w:Rbuffer()
end

return OwnHomeData
