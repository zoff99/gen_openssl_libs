FROM dockcross/linux-arm64:latest
################
################
# Fix EOL Bullseye repos for gotson/crossbuild:latest
RUN sed -i 's|deb.debian.org/debian|archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/bullseye-updates/d' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until
ARG DEBIAN_FRONTEND=noninteractive
RUN export DEBIAN_FRONTEND=noninteractive && apt update && apt install -y make yasm wget git \
    coreutils autoconf libtool pkg-config nano
################
################
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
