FROM mcr.microsoft.com/dotnet/core/sdk:3.1

# Repo Args
ARG gitUrl
ARG repoTag

ARG fullnodeContainerDir
ARG configFile

RUN git clone ${gitUrl} --branch ${repoTag} --single-branch  \
    && cd /blockcore/src/Node/Blockcore.Node \
    && dotnet build

WORKDIR /blockcore/src/Node/Blockcore.Node

ENTRYPOINT exec dotnet run --chain="${eTicker}"
