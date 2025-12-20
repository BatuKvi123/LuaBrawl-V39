return function(len)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local t = {}
    for i = 1, len do
        local r = math.random(#chars)
        t[i] = chars:sub(r, r)
    end
    return table.concat(t)
end
