FROM ubuntu:latest

# Install llvm Build Dependencies

## Enable Package Sources
RUN grep -P "^deb" /etc/apt/sources.list | \
    sed 's/^deb/deb-src /g' >> /etc/apt/sources.list

## Install Dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates gnupg \
           build-essential python wget subversion unzip git && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir ~/.gnupg && echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf

## Install ninja Build System
RUN wget -q "https://github.com/ninja-build/ninja/releases/download/v1.9.0/ninja-linux.zip" && \
    echo "1b1235f2b0b4df55ac6d80bbe681ea3639c9d2c505c7ff2159a3daf63d196305  ninja-linux.zip" \
        | sha256sum -c && \
    unzip ninja-linux.zip -d /usr/local/bin && \
    rm ninja-linux.zip

## Install cmake
RUN gpg --recv-keys EC8FEF3A7BFB4EDA
RUN mkdir /tmp/cmake-install && cd /tmp/cmake-install && \
    wget -q "https://cmake.org/files/v3.15/cmake-3.15.2-SHA-256.txt.asc" && \
    wget -q "https://cmake.org/files/v3.15/cmake-3.15.2-SHA-256.txt" && \
    gpg --verify cmake-3.15.2-SHA-256.txt.asc cmake-3.15.2-SHA-256.txt && \
    wget -q "https://cmake.org/files/v3.15/cmake-3.15.2-Linux-x86_64.tar.gz" && \
    ( grep "cmake-3.15.2-Linux-x86_64.tar.gz" cmake-3.15.2-SHA-256.txt | \
      sha256sum -c - ) && \
    tar xzf cmake-3.15.2-Linux-x86_64.tar.gz -C /usr/local --strip-components=1 && \
    cd / && rm -rf /tmp/cmake-install

## Download llvm and clang Source Code
RUN gpg --recv-keys 86419D8A
RUN mkdir -p /tmp/clang-build && cd /tmp/clang-build && \
    wget -q "https://github.com/llvm/llvm-project/releases/download/llvmorg-8.0.1/llvm-8.0.1.src.tar.xz.sig" && \
    wget -q "https://github.com/llvm/llvm-project/releases/download/llvmorg-8.0.1/llvm-8.0.1.src.tar.xz" && \
    gpg --verify llvm-8.0.1.src.tar.xz.sig llvm-8.0.1.src.tar.xz && \
    mkdir llvm && tar xf llvm-8.0.1.src.tar.xz -C llvm --strip-components=1 && \
    wget -q "https://github.com/llvm/llvm-project/releases/download/llvmorg-8.0.1/cfe-8.0.1.src.tar.xz.sig" && \
    wget -q "https://github.com/llvm/llvm-project/releases/download/llvmorg-8.0.1/cfe-8.0.1.src.tar.xz" && \
    gpg --verify cfe-8.0.1.src.tar.xz.sig cfe-8.0.1.src.tar.xz && \
    mkdir clang && tar xf cfe-8.0.1.src.tar.xz -C clang --strip-components=1 && \
    rm cfe-8.0.1.src.tar.xz.sig cfe-8.0.1.src.tar.xz llvm-8.0.1.src.tar.xz.sig llvm-8.0.1.src.tar.xz

COPY install.sh /tmp/
RUN /tmp/install.sh && rm /tmp/install.sh
