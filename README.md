# Install Docker and Docker-compose

Run install-docker.sh

# Build FullNode

This build is used to run a FullNode

Edit the .env file (Docker/.env):
```
# GitHub repository. Use: https://github.com/block-core/blockcore 
gitUrl= https://github.com/block-core/blockcore

# Chain name on Blockcore networks. OpenExo, Rutanio
chain=

# Mandatory to open container firewall ports
defaultPort=       
rpcPort=         
apiPort=          
signalPort=       

# Storage configuration
# Dir configuration should be used complete path including chain and Network to avoid use same file in different chain
fullnodeHostDir=
fullnodeContainerDir=
configFile=
```

Edit the chain.conf file if require (Docker/chain.conf)

Build docker-compose
```
cd Docker
docker-compose build
```

# Build DNS FullNode

This build is used to run a FullNode with DNS feature activated
Edit the .env file (Docker/.env):
```
# GitHub repository. Use: https://github.com/block-core/blockcore 
gitUrl= https://github.com/block-core/blockcore

# Chain name on Blockcore networks. OpenExo, Rutanio
chain=

# Mandatory to open container firewall ports
defaultPort=       
rpcPort=         
apiPort=          
signalPort=       

# Storage configuration
# Dir configuration should be used complete path including chain and Network to avoid use same file in different chain
fullnodeHostDir=
fullnodeContainerDir=
configFile=
```

Edit the chain.conf file if require(Docker/chain.conf)

Make sure enable the dns flag (dnsfullnode=1) and complete dns parameters

```
####DNS Settings####
#The DNS listen port. Defaults to 53
dnslistenport=53
#Enables running the DNS Seed service as a full node.
dnsfullnode=1
#The number of seconds since a peer last connected before being blacklisted from the DNS nodes. Defaults to 1800.
#dnspeerblacklistthresholdinseconds=1800
#The host name for the node when running as a DNS Seed service.
dnshostname=hostname.here.com
#The DNS Seed Service nameserver.
#dnsnameserver=nameserver.here.com
#The e-mail address used as the administrative point of contact for the domain.
dnsmailbox=mailbox@domain.com
```


# Run the docker-compose

Run docker-compose container in detach mode (Run containers in the background)
```
docker-compose up -d
```
