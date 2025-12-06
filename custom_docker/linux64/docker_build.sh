#! /bin/bash

id -a
pwd

./Configure no-apps no-docs no-dso no-dgram --prefix=/opt/openssl --openssldir=/usr/local/ssl || exit 1
make -j $(nproc) || exit 1
make install || exit 1

echo "/opt/openssl/include/"
ls -al /opt/openssl/include/

echo "/opt/openssl/lib64/"
ls -al /opt/openssl/lib64/

echo "/opt/openssl/lib64/pkgconfig/"
ls -al /opt/openssl/lib64/pkgconfig/
