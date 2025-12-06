#! /bin/bash

id -a
pwd

OS="$1"
ARCH="$2"

echo "OS  : ""$OS"
echo "ARCH: ""$ARCH"

# clean work directory from any previous runs
rm -Rf /work/*

./Configure no-apps no-docs no-dso no-dgram --prefix=/opt/openssl --openssldir=/usr/local/ssl || exit 1
make -j $(nproc) || exit 1
make install || exit 1

echo "/opt/openssl/include/"
ls -al /opt/openssl/include/ || exit 1

echo "/opt/openssl/lib64/"
ls -al /opt/openssl/lib64/ || exit 1

echo "/opt/openssl/lib64/pkgconfig/"
ls -al /opt/openssl/lib64/pkgconfig/

mkdir -p /work/
cd /work/ && cp -av /opt/openssl/lib64/ . || exit 1
mv -v /work/lib64 /work/lib || exit 1

cd /work/ && cp -av /opt/openssl/include/ . || exit 1

ls -al /work/lib/*.a || exit 1
ls -hal /work/lib/*.a || exit 1
