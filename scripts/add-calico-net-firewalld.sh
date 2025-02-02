#!/bin/bash

# zone_name="calico-net"
zone_name="public"
for i in $(ip a | grep cali | awk -F":" '{print $2}' | awk -F"@" '{print $1}')
do
    firewall-cmd --permanent --zone=${zone_name} --add-interface="$i"
done


