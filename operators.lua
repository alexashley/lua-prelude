local sm = setmetatable
local function infix(f)
    local mt = { __sub = function(self, b) return f(self[1], b) end }
    return sm({}, { __sub = function(a, _) return sm({ a }, mt) end })
end

-- pipe (2 -p- dec -p- odd --> true)
p = infix(function(arg, func) return func(arg) end)