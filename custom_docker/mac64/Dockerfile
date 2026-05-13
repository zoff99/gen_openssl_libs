FROM crazymax/osxcross:latest-ubuntu AS osxcross-source
FROM ubuntu:24.04
ARG DEBIAN_FRONTEND=noninteractive

# Install basic compiler dependencies needed by the toolchain
RUN apt-get update && apt-get install -y \
    clang \
    llvm \
    libxml2 \
    patch \
    && rm -rf /var/lib/apt/lists/*

# Copy the entire toolchain directly from the scratch image into your environment
COPY --from=osxcross-source /osxcross /osxcross

# Add the macOS compilers to your system PATH
ENV PATH="/osxcross/bin:$PATH"


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
