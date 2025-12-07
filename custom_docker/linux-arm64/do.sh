#! /bin/bash

_HOME2_=$(dirname "$0")
export _HOME2_
_HOME_=$(cd "$_HOME2_" || exit;pwd)
export _HOME_
echo "$_HOME_"
cd "$_HOME_" || exit

build_dir=".build/"
container_name="openssl_libs_lin_arm64"

if [ "$1""x" == "build-container""x" ]; then
    cp ../../000_deps/openssl.tar.gz . && docker build --progress=plain -f Dockerfile -t "$container_name" .
elif [ "$1""x" == "test""x" ]; then
    cp -av ../../tests/*.c "$build_dir"
    test1="cmac_test"
    test2="des_crypt_test"
    CC="/usr/xcc/aarch64-unknown-linux-gnu/bin/aarch64-unknown-linux-gnu-gcc"
    docker run \
        -v "$(pwd)""/""$build_dir":/work -i "$container_name" \
        bash -c 'id -a; pwd; cd /work && '"$CC"' '"$test1"'.c -Wno-deprecated-declarations -g -O3 -I/work/include /work/lib/libcrypto.a -pthread -o '"$test1"' && echo "======" && echo "======" && ls -al '"$test1"' && file '"$test1"
    docker run \
        -v "$(pwd)""/""$build_dir":/work -i "$container_name" \
        bash -c 'id -a; pwd; cd /work && '"$CC"' '"$test2"'.c -Wno-deprecated-declarations -g -O3 -I/work/include /work/lib/libcrypto.a -pthread -o '"$test2"' && echo "======" && echo "======" && ls -al '"$test2"' && file '"$test2"

    echo "======"
    echo "======"
    echo "running test 1"
    "$(pwd)""/""$build_dir"/"$test1" || exit
    echo "======"
    echo "======"
    echo "running test 2"
    "$(pwd)""/""$build_dir"/"$test2" || exit
    echo "======"
    echo "======"
    echo "tests done"
    echo "======"
    echo "======"
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
