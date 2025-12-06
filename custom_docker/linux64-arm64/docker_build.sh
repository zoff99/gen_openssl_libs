#! /bin/bash

id -a
pwd

OS="$1"
ARCH="$2"

echo "OS  : ""$OS"
echo "ARCH: ""$ARCH"

# clean work directory from any previous runs
rm -Rf /work/*

libdir="lib"
./Configure no-apps no-docs no-dso no-dgram linux-aarch64 --prefix=/opt/openssl --openssldir=/usr/local/ssl || exit 1

# HINT: fix to find the C-compiler
# for some reason its looking for:
#     aarch64-unknown-linux-gnu-/usr/xcc/aarch64-unknown-linux-gnu/bin/aarch64-unknown-linux-gnu-gcc
# (shrug)
ln -s / aarch64-unknown-linux-gnu- || exit 1

make -j $(nproc) || exit 1
make install || exit 1

echo "/opt/openssl/include/"
ls -al /opt/openssl/include/ || exit 1

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

ls -al /work/lib/*.a || exit 1
ls -hal /work/lib/*.a || exit 1
