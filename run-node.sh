#!/bin/bash
# This file is run as ./run-node.sh TICKER {start | stop}   (run-node.sh EXOS)

cd Docker

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
     echo "Starting Full Node daemon..."
     cp chain-base.conf chain.conf
     docker-compose --env-file ${envFile} build --no-cache
     docker-compose --env-file ${envFile} up -d
     ;;
  stop)
     echo "Stopping Full Node daemon..."
     docker-compose stop
     ;;
  *)
     echo $"Usage: $0 TICKER {start | stop}"
     exit 1
esac
