local ipairs = ipairs
local pairs = pairs
local jsonlua = require "JSON"
local setmetatable = setmetatable

-- arrays

local array_metatable = {}

array_metatable.__index = array_metatable
function array_metatable:map(func)
    return Array.of(map(self, func))
end

function array_metatable:filter(func)
    return Array.of(filter(self, func))
end

function array_metatable:reduce(func, initial)
    return reduce(self, func, initial)
end

Array = {}
function Array.of(...)
    local args = {...}

    if (type(args[1]) == 'table' and #args == 1) then
        return setmetatable(args[1], array_metatable)
    end

    return setmetatable(args, array_metatable)
end

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

Object = {}

function Object.keys(list)
    local table = {}
    local idx = 1
    for k in pairs(list) do
        table[idx] = k
        idx = idx + 1
    end

    return table
end

function Object.values(list)
    local table = {}
    local idx = 1
    for _, v in pairs(list) do
        table[idx] = v
        idx = idx + 1
    end

    return table
end

function Object.entries(list)
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
