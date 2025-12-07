#! /bin/bash

_HOME2_=$(dirname "$0")
export _HOME2_
_HOME_=$(cd "$_HOME2_" || exit;pwd)
export _HOME_
echo "$_HOME_"
cd "$_HOME_" || exit

build_dir=".build/"
container_name="openssl_libs_win_x86_64"

if [ "$1""x" == "build-container""x" ]; then
    cp ../../000_deps/openssl.tar.gz . && docker build --progress=plain -f Dockerfile -t "$container_name" .
elif [ "$1""x" == "test""x" ]; then
    cp -av ../../tests/*.c "$build_dir"
    test1="cmac_test"
    test2="des_crypt_test"
    CC="x86_64-w64-mingw32-gcc"
    docker run \
        -v "$(pwd)""/""$build_dir":/work -i "$container_name" \
        bash -c 'id -a; pwd; cd /work && '"$CC"' '"$test1"'.c -Wno-deprecated-declarations -g -O3 -I/work/include /work/lib/libcrypto.a -l:libiphlpapi.a -Wl,-Bstatic -lcrypt32 -Wl,-Bstatic -lws2_32 -o '"$test1"' && echo "======" && echo "======" && ls -al '"$test1"'.exe && file '"$test1"'.exe'
    docker run \
        -v "$(pwd)""/""$build_dir":/work -i "$container_name" \
        bash -c 'id -a; pwd; cd /work && '"$CC"' '"$test2"'.c -Wno-deprecated-declarations -g -O3 -I/work/include /work/lib/libcrypto.a -l:libiphlpapi.a -Wl,-Bstatic -lcrypt32 -Wl,-Bstatic -lws2_32 -o '"$test2"' && echo "======" && echo "======" && ls -al '"$test2"'.exe && file '"$test2"'.exe'

    echo "======"
    echo "======"
    echo "running test 1"
    wine "$(pwd)""/""$build_dir"/"$test1"'.exe' || exit 1
    echo "======"
    echo "======"
    echo "running test 2"
    wine "$(pwd)""/""$build_dir"/"$test2"'.exe' || exit 1
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
