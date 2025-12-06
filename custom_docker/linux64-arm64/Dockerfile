FROM dockcross/linux-arm64:latest
ARG DEBIAN_FRONTEND=noninteractive
RUN export DEBIAN_FRONTEND=noninteractive && apt update && apt install -y make yasm wget git \
    coreutils autoconf libtool pkg-config nano

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
