
.phony: all

all: native-all

clean:
	echo "clean"
# HINT: would need "sudo" to clean, but thats way too dangerous. so we do NOT clean in this Makefile
	### rm -Rf ./custom_docker/linux64/.build/
	### rm -Rf ./custom_docker/linux64-arm64/.build/

# For cross-compilation, install docker. See also https://github.com/dockcross/dockcross
native-all: linux64 linux-arm64 windows-x64 mac64 mac-arm64


## ------ Linux
linux64:
	./custom_docker/linux64/do.sh build-container
	./custom_docker/linux64/do.sh compile Linux x86_64

## ------ Linux arm64
linux-arm64:
	./custom_docker/linux-arm64/do.sh build-container
	./custom_docker/linux-arm64/do.sh compile Linux aarch64

## ------ Windows x86_64
windows-x64:
	./custom_docker/windows-x64/do.sh build-container
	./custom_docker/windows-x64/do.sh compile Windows x86_64

## ------ macOS x86_64
mac64:
	./custom_docker/macos64/do.sh build-container
	./custom_docker/macos64/do.sh compile Mac x86_64

## ------ macOS arm64
mac-arm64:
	./custom_docker/macos-arm64/do.sh build-container
	./custom_docker/macos-arm64/do.sh compile Mac aarch64
