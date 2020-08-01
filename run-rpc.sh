#!/bin/bash
# This file is run as ./run-dns.sh TICKER {start | stop}   (run-node.sh EXOS)


cd Docker

rpcSetup(){
    user=`cat ${envFile} | grep rpcUser | cut -d '=' -f2`
    pass=`cat ${envFile} | grep rpcPassword | cut -d '=' -f2`

    if [ -n "$pass" ]
    then      
        echo "" >> chain.conf
        echo "server=1" >> chain.conf
        echo "rpcuser=${user}" >> chain.conf
        echo "rpcpassword=${pass}" >> chain.conf
        echo "rpccontenttype=application/json" >> chain.conf
        echo "txindex=1" >> chain.conf 
    else
        echo "You must set a rpc user and password to start this node"
    fi
}

stopElectrumXService(){
   if pgrep electrumx
      then
      pkill electrumx
   else
      echo "ElectrumX is not running!"
   fi
}

stopElectrumXService
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
     echo "Starting Node daemon..."
     cp chain-base.conf chain.conf
     rpcSetup

     docker-compose -f docker-compose.yml -f docker-compose.electrumx.yml --env-file ${envFile} build
     docker-compose -f docker-compose.yml -f docker-compose.electrumx.yml --env-file ${envFile} up -d

     ;;
  stop)
     echo "Stopping Node daemon..."
     docker-compose -f docker-compose.yml -f docker-compose.electrumx.yml stop
     ;;
  *)
     echo $"Usage: $0 TICKER {start | stop}"
     exit 1
esac
