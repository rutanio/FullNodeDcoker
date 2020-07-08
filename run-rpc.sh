#!/bin/bash
# This file is run as ./run-dns.sh TICKER {start | stop}   (run-node.sh EXOS)


cd Docker

rpcSetup(){
    userpass=`cat /etc/electrumx-*.conf | grep DAEMON_URL | cut -d "@" -f1 | cut -d "/" -f3` 
    user="$(echo $userpass | cut -d: -f1)"
    pass="$(echo $userpass | cut -d: -f2)"

    if [ -n "$pass" ]
    then      
        echo "" >> chain.conf
        echo "server=1" >> chain.conf
        echo "rpcuser=${user}" >> chain.conf
        echo "rpcpassword=${pass}" >> chain.conf
        echo "rpccontenttype=application/json" >> chain.conf
        echo "txindex=1" >> chain.conf 
    else
        echo "No user or password on the ElectrumX configuration file"
    fi
}

case ${1,,} in 
  exos)
     envFile=openexo.env
     ;;
  ruta)
     envFile=rutanio.env
     ;;
  *)
     echo $"Usage: $0 TICKER {start | stop}"
     exit 1
esac


case ${2,,} in 
  start)
     echo "Starting Node daemon for ElectrumX..."
     cp chain-base.conf chain.conf
     rpcSetup
     docker-compose --env-file ${envFile} up -d
     ;;
  stop)
     echo "Stopping Node daemon for ElectrumX..."
     docker-compose stop
     ;;
  *)
     echo $"Usage: $0 TICKER {start | stop}"
     exit 1
esac
