all="deps"
.PHONY=all

deps:
	luarocks install --local penlight
	luarocks install --local json-lua
	echo "Finished $@"