local DBM = {}

local sql = require("lsqlite3")
local gstr = require("Other.GStr")

DBM.conn = nil

function DBM.open()
    if DBM.conn then
        return DBM.conn
    end

    DBM.conn = sql.open("Data/players.db")

    DBM.conn:exec([[
        CREATE TABLE IF NOT EXISTS plrs (
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
        );
    ]])

    return DBM.conn
end

function DBM.close()
    if DBM.conn then
        DBM.conn:close()
        DBM.conn = nil
    end
end

function DBM.getnewid()
    DBM.open()
    for r in DBM.conn:nrows("SELECT MAX(lowid) AS m FROM plrs") do
        return (r.m or 0) + 1
    end
    return 1
end

local function tokenexists(token)
    DBM.open()
    local prep = DBM.conn:prepare("SELECT 1 FROM plrs WHERE token = ?")
    prep:bind_values(token)
    local exists = (prep:step() == sql.ROW)
    prep:finalize()
    return exists
end

function DBM.createacc()
    DBM.open()

    local token
    repeat
        token = gstr(30)
    until not tokenexists(token)

    local lowid = DBM.getnewid()
    local name = "LuaPlayer"

    local prep = DBM.conn:prepare([[
        INSERT INTO plrs (lowid, token, name, trophies, gold, gems, TvTW, SW, DW, exp, registered)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ]])

    prep:bind_values(
        lowid,
        token,
        name,
        0,
        100,
        500,
        0,
        0,
        0,
        0,
        false
    )

    prep:step()
    prep:finalize()

    return {
        lowid = lowid,
        token = token,
        name = name,
        trophies = 0,
        gold = 100,
        gems = 500,
        TvTW = 0,
        SW = 0,
        DW = 0,
        exp = 0,
        registered = false
    }
end

function DBM.loadacc(token)
    DBM.open()

    local prep = DBM.conn:prepare(
        "SELECT * FROM plrs WHERE token = ?"
    )
    prep:bind_values(token)

    local acc = nil
    if prep:step() == sql.ROW then
        acc = {
            lowid = prep:get_value(0),
            token = prep:get_value(1),
            name = prep:get_value(2),
            trophies = prep:get_value(3),
            gold = prep:get_value(4),
            gems = prep:get_value(5),
            TvTW = prep:get_value(6),
            SW = prep:get_value(7),
            DW = prep:get_value(8),
            exp = prep:get_value(9),
            registered = prep:get_value(10)
        }
    end

    prep:finalize()
    return acc
end

function DBM.saveacc(p)
    DBM.open()

    local prep = DBM.conn:prepare([[
        UPDATE plrs SET
            name = ?,
            trophies = ?,
            gold = ?,
            gems = ?,
            TvTW = ?,
            SW = ?,
            DW = ?,
            exp = ?,
            registered = ?
        WHERE lowid = ?
    ]])

    prep:bind_values(
        p.name,
        p.trophies,
        p.gold,
        p.gems,
        p.TvTW,
        p.SW,
        p.DW,
        p.exp,
        p.registered,
        p.lowid
    )

    prep:step()
    prep:finalize()
end

function DBM.editval(player, column, value)
    DBM.open()

    local allowed = {
        name = true,
        trophies = true,
        gold = true,
        gems = true,
        TvTW = true,
        SW = true,
        DW = true,
        exp = true,
        registered = true
    }

    if not allowed[column] then
        return "not allowed column"
    end

    player[column] = value

    local prep = DBM.conn:prepare(
        "UPDATE plrs SET "..column.." = ? WHERE lowid = ?"
    )

    prep:bind_values(value, player.lowid)
    prep:step()
    prep:finalize()

    return true
end

-- ik i can user player.column but i did this for registered column [UNUSED]
function DBM.returnval(player, column)
    DBM.open()

    local prep = DBM.conn:prepare(
        "SELECT "..column.." FROM plrs WHERE token = ?"
    )
    prep:bind_values(player.lowid)

    local val = nil
    if prep:step() == sql.ROW then
        val = prep:get_value(0)
    end

    prep:finalize()
    return val
end


return DBM