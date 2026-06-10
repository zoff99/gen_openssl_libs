FROM multiarch/crossbuild
ARG DEBIAN_FRONTEND=noninteractive
# HINT: this docker container is too old, sadly no more package updates
RUN export DEBIAN_FRONTEND=noninteractive && apt update && apt install -y make yasm wget git \
    coreutils autoconf libtool pkg-config nano || echo "NO ERR"

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
