FROM ubuntu:20.04

LABEL version = "1.0" description = "Dockerfile for building a leap eos with history_plugin"

ENV WORK_PATH /usr/local

RUN apt update && apt upgrade -y && DEBIAN_FRONTEND=noninteractive \
        apt install -y              \
        tzdata                      \
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

RUN cd $WORK_PATH && git clone https://github.com/bijianing97/leap.git \
        && cd leap && git checkout history_plugin_add &&               \
        git submodule update --init --recursive                          \
        && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release ..\
        && make -j$(nproc) package 

ARG snapshot_url=https://snapshots-cdn.eossweden.org/main/2.0/snapshot-262010746.bin.tar.gz

RUN apt install -y wget

RUN wget ${snapshot_url} -O $WORK_PATH/snapshot.bin.tar.gz
 
RUN tar -zxvf $WORK_PATH/snapshot.bin.tar.gz -O > $WORK_PATH/snapshot.bin  

RUN  cd $WORK_PATH && cp $WORK_PATH/leap/build/programs/nodeos/nodeos $WORK_PATH  \
&& mkdir $WORK_PATH/eosio                           

ADD  ./start.sh /usr/local/start.sh
ADD  ./config.ini /usr/local/config.ini
RUN chmod a+x /usr/local/start.sh


# P2P port
EXPOSE 9876

# RPC port
EXPOSE 8888

RUN bash /usr/local/start.sh
