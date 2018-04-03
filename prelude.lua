local ipairs = ipairs
local pairs = pairs
local jsonlua = require "JSON"

-- arrays

function map(list, func)
    local table = {}
    local idx = 1
    for _, value in ipairs(list) do
        table[idx] = func(value)
        idx = idx + 1
    end

    return table
end

function filter(list, predicate)
    local table = {}
    local idx = 1
    for _, v in ipairs(list) do
        if predicate(v) then
            table[idx] = v
            idx = idx + 1
        end
    end

    return table
end

function reduce(list, func, initial)
    local acc = initial

    for _, v in ipairs(list) do
        acc = func(acc, v)
    end

    return acc
end

-- tables

function keys(list)
    local table = {}
    local idx = 1
    for k in pairs(list) do
        table[idx] = k
        idx = idx + 1
    end

    return table
end

function values(list)
    local table = {}
    local idx = 1
    for _, v in pairs(list) do
        table[idx] = v
        idx = idx + 1
    end

    return table
end

function entries(list)
    local table = {}
    local idx = 1
    for k, v in pairs(list) do
        table[idx] = { k, v }
        idx = idx + 1
    end

    return table
end

function pretty(table)
    print(require 'pl.pretty'.write(table))
end

-- JSON

JSON = {}

function JSON.parse(json)
    return jsonlua:decode(json)
end

function JSON.stringify(table)
    return jsonlua:encode(table)
end

-- os

function exit()
    os.exit()
end

-- math

function sum(a, b)
    return a + b
end

function inc(i)
    return i + 1
end

function dec(i)
    return i - 1
end

function even(i)
    return i % 2 == 0
end

function odd(i)
    return not even(i)
end

function id(x)
    return x
end

-- operators

local sm = setmetatable
local function infix(f)
    local mt = { __sub = function(self, b) return f(self[1], b) end }
    return sm({}, { __sub = function(a, _) return sm({ a }, mt) end })
end

-- pipe (2 -p- dec -p- odd --> true)
p = infix(function(arg, func) return func(arg) end)
