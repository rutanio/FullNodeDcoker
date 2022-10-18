FROM ubuntu:20.04
LABEL maintainer="Sergio Quintero <sergio.quintero@fluidchains.com>"
# based on work by lukechilds, https://github.com/lukechilds/docker-electrumx/

ARG dbDirectory
ENV _VERSION=1.15.3

RUN apt-get update && \
    apt-get -y install python3.8 python3-pip librocksdb-dev libsnappy-dev libbz2-dev libz-dev liblz4-dev wget

RUN wget -q -O electrumx.tar.gz https://github.com/FluidChains/electrumx-fluidchains/archive/${_VERSION}.tar.gz
RUN tar -xzf electrumx.tar.gz

COPY ./bin /usr/local/bin
WORKDIR /electrumx-fluidchains-${_VERSION}

RUN cd /electrumx* && pip3 install .[rocksdb]
RUN ulimit -n 1048576

VOLUME ${dbDirectory}

ENV ALLOW_ROOT 1
ENV DB_DIRECTORY ${dbDirectory}
ENV SERVICES=tcp://:50001,ssl://:50002,wss://:50004,rpc://0.0.0.0:8000
ENV SSL_CERTFILE ${DB_DIRECTORY}/electrumx.crt
ENV SSL_KEYFILE ${DB_DIRECTORY}/electrumx.key
ENV DB_ENGINE=rocksdb
ENV MAX_SEND=10000000
ENV CACHE_MB=2000
ENV MAX_SESSIONS=100000
ENV COST_SOFT_LIMIT=0
ENV COST_HARD_LIMIT=0

WORKDIR ${dbDirectory}

EXPOSE 50001 50002 50004 8000

CMD ["init"]
