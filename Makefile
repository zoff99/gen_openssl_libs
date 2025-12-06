
.phony: all

all: native-all

clean:
	echo "clean"

# For cross-compilation, install docker. See also https://github.com/dockcross/dockcross
native-all: linux64
# linux-arm64 win64 mac64 mac-arm64


## ------ Linux ------
linux64:
	./custom_docker/linux64/do.sh build-container
	./custom_docker/linux64/do.sh compile Linux x86_64
