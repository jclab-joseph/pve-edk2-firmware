FROM debian:bullseye-slim as builder

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y \
    bash curl wget gnupg2 git \
    build-essential debhelper make dh-exec \
    lintian bc gcc-aarch64-linux-gnu iasl nasm python3 python3-distutils uuid-dev \
    python

RUN mkdir -p /work/src
ADD [".", "/work/src/"]

RUN cd /work/src && \
    make

FROM scratch
COPY --from=builder [ "/work/src/pve-edk2-firmware_*.*", "/" ]

