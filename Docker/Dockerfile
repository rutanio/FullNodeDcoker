FROM mcr.microsoft.com/dotnet/core/sdk:3.1

# Repo Args
ARG gitUrl
ARG chain

# Ports Args
ARG defaultPort
ARG rpcPort
ARG apiPort
ARG signalPort

ARG fullnodeContainerDir
ARG configFile

RUN git clone ${gitUrl}  \
    && cd /blockcore/src/Networks/${chain}/${chain}.Node \
	&& dotnet build

COPY chain.conf ${fullnodeContainerDir}/${configFile}

WORKDIR /blockcore/src/Networks/${chain}/${chain}.Node

EXPOSE ${defaultPort} ${rpcPort} ${apiPort} ${signalPort}

CMD ["dotnet", "run"]
