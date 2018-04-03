# lua-prelude

A small set of useful functions for the Lua REPL.

## installation

The prelude depends on `json-lua` and `penlight` being in the `LUA_PATH`. You can run `make deps` to install them into the local Luarocks tree.

Then, simply load it into the interpreter: `lua -i prelude.lua`.

## samples

Filter a JSON array:

`pretty(filter(JSON.parse('{"a": [1,2,3]}').a, odd))`

