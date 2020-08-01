#!/bin/bash
if free | awk '/^Swap:/ {exit !$2}'; then
    echo "Swap already set"
else
    fallocate -l 4G /swapfile 
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile   none    swap    sw    0   0' >> /etc/fstab
    sysctl vm.swappiness=10
    echo 'vm.swappiness=10' >> /etc/sysctl.conf
    echo "Swap setup OK"
fi
