FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive
RUN export DEBIAN_FRONTEND=noninteractive && apt update && apt install -y make yasm wget git \
    coreutils autoconf libtool pkg-config nano

RUN DEBIAN_FRONTEND=noninteractive \
        apt-get install -y --no-install-recommends \
        wine libwine-dev libwine wine64 wine64-tools \
        gcc-mingw-w64-x86-64 \
        gcc-mingw-w64-x86-64 g++-mingw-w64-x86-64 binutils-mingw-w64-x86-64 \
        mingw-w64-tools pkg-config-mingw-w64-x86-64 \
        mingw-w64-x86-64-dev

WORKDIR /work
RUN mkdir -p /source/
COPY openssl.tar.gz /source/openssl.tar.gz
RUN chmod a+r /source/openssl.tar.gz
RUN cd /source/ && tar -xzvf openssl.tar.gz
RUN rm /source/openssl.tar.gz
RUN cd /source/ && mv -v openssl-* openssl
RUN pwd
RUN ls -al /source/openssl/
RUN ls -al /source/
RUN ls -al /work/

RUN id -a;pwd
