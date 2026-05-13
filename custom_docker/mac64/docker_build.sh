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

# rm -fv /osxcross/bin/x86_64-apple-darwin25.1-ranlib
# mv -v /osxcross/bin/arm64-apple-darwin25.1-ranlib /osxcross/bin/x86_64-apple-darwin25.1-ranlib

CROSS_TRIPLE=x86_64-apple-darwin \
    CC="/osxcross/bin/x86_64-apple-darwin25.1-clang" CROSS_PREFIX="/usr/osxcross/bin/x86_64-apple-darwin14-cc-" \
    AR="/osxcross/bin/x86_64-apple-darwin25.1-ar" \
    AS="/osxcross/bin/x86_64-apple-darwin25.1-as" \
    LD="/osxcross/bin/x86_64-apple-darwin25.1-ld" \
    RANLIB="/osxcross/bin/x86_64-apple-darwin25.1-ranlib" \
    ./Configure no-apps no-docs no-dso no-dgram darwin64-x86_64 --prefix=/opt/openssl --openssldir=/usr/local/ssl || exit 1
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

# HINT: it's .dylib on macOS
ls -al /work/lib/*.dylib || exit 1
ls -hal /work/lib/*.dylib || exit 1

ls -al /work/lib/*.a || exit 1
ls -hal /work/lib/*.a || exit 1
