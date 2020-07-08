FROM mcr.microsoft.com/dotnet/core/sdk:3.1

# Repo Args
ARG gitUrl

ARG fullnodeContainerDir
ARG configFile

RUN git clone ${gitUrl}  \
    && cd /blockcore/src/Node/Blockcore.Node \
    && dotnet build

RUN touch ${fullnodeContainerDir}/${configFile}

WORKDIR /blockcore/src/Node/Blockcore.Node

ENTRYPOINT exec dotnet run --chain="${eTicker}"
