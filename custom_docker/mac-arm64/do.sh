#! /bin/bash

_HOME2_=$(dirname "$0")
export _HOME2_
_HOME_=$(cd "$_HOME2_" || exit;pwd)
export _HOME_
echo "$_HOME_"
cd "$_HOME_" || exit

build_dir=".build/"
container_name="openssl_libs_mac_arm64"

if [ "$1""x" == "build-container""x" ]; then
    cp ../../000_deps/openssl.tar.gz . && docker build --progress=plain -f Dockerfile -t "$container_name" .
else
    os_="$2"
    arch_="$3"
    mkdir -p "$build_dir"
    cp -v docker_build.sh "$build_dir"
    docker run \
        --env OS="$os_" \
        --env ARCH="$arch_" \
        -v "$(pwd)""/""$build_dir":/work -i "$container_name" \
        bash -c 'id -a; pwd; cd /source/openssl/ && /work/docker_build.sh "$OS" "$ARCH"'
fi
