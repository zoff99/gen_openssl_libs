#! /bin/bash

id -a
pwd

OS="$1"
ARCH="$2"

echo "OS  : ""$OS"
echo "ARCH: ""$ARCH"

# clean work directory from any previous runs
rm -Rf /work/*

libdir="lib64"

./Configure mingw64 --cross-compile-prefix=x86_64-w64-mingw32- \
    no-apps no-docs no-dso no-dgram --prefix=/opt/openssl --openssldir=/usr/local/ssl || exit 1
make -j $(nproc) || exit 1
make install || exit 1

echo "/opt/openssl/include/"
ls -al /opt/openssl/include/ || exit 1

echo "/opt/openssl/bin/"
ls -al /opt/openssl/bin/ || exit 1

echo "/opt/openssl/""$libdir""/"
ls -al /opt/openssl/"$libdir"/ || exit 1

echo "/opt/openssl/"$libdir"/pkgconfig/"
ls -al /opt/openssl/"$libdir"/pkgconfig/

mkdir -p /work/
cd /work/ && cp -av /opt/openssl/"$libdir"/ . || exit 1
if [ "$libdir""x" != "lib""x" ]; then
    mv -v /work/"$libdir" /work/lib || exit 1
fi

cd /work/ && cp -av /opt/openssl/include/ . || exit 1

# HINT: libcrypto-3-x64.dll and libssl-3-x64.dll are in the "bin/" directory (for some reason)
cd /work/ && cp -av /opt/openssl/bin/*dll* ./lib/ || exit 1

ls -al /work/lib/*.dll || exit 1
ls -hal /work/lib/*.dll || exit 1

ls -al /work/lib/*.a || exit 1
ls -hal /work/lib/*.a || exit 1
