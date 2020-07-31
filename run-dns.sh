#!/bin/bash
# This file is run as ./run-dns.sh TICKER {start | stop}   (run-node.sh EXOS)


cd Docker

dnsSetup(){
    ipHost=`curl -s ifconfig.me`

    if [ `which jq` == 1 ]; then 
       sudo apt install -y jq
    fi

    findDNS=`jq 'has("'"$ipHost"'")' dnslist.json`

    if [ $findDNS == "true" ]
    then      
        hostname=`jq ."\"$ipHost"\".hostname dnslist.json`
        nameserver=`jq .\"$ipHost\".nameserver dnslist.json`
        echo "" >> chain.conf
        echo "dnsfullnode=1" >> chain.conf
        echo "dnshostname=${hostname//"\""}" >> chain.conf
        echo "dnsnameserver=${nameserver//"\""}" >> chain.conf
        echo "dnsmailbox=admin@fluidchains.com" >> chain.conf
    else
        echo "No DNS Server found"
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
     echo "Starting DNS Node daemon..."
     cp chain-base.conf chain.conf
     dnsSetup
     docker-compose --env-file ${envFile} build
     docker-compose --env-file ${envFile} up -d
     ;;
  stop)
     echo "Stopping DNS Node daemon..."
     docker-compose stop
     ;;
  *)
     echo $"Usage: $0 TICKER {start | stop}"
     exit 1
esac
