FROM ubuntu:20.04
MAINTAINER MandedwithHistoryPlugin

ENV WORK_PATH /usr/local

RUN apt update && apt upgrade -y && apt install -y \
        build-essential             \
        cmake                       \
        curl                        \
        git                         \
        libboost-all-dev            \
        libcurl4-openssl-dev        \
        libgmp-dev                  \
        libssl-dev                  \
        libusb-1.0-0-dev            \
        llvm-11-dev                 \
        pkg-config

RUN cd $WORK_PATH && git clone https://github.com/bijianing97/mandel.git \
        && cd mandel && git checkout history_plugin_add &&               \
        git submodule update --init --recursive                          \
        && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release ..\
        && make -j$(nproc) package 

// P2P port
EXPOSE 9876

// RPC port
EXPOSE 8888