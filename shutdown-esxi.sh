#!/bin/bash
#

esxi_host="192.168.0.231"
esxi_ips="192.168.0.231 192.168.0.101"
esxi_passwd="Changeme34#$"

for ip in `echo $esxi_ips`
do

    for ln in `cat /home/jomoon/.ssh/known_hosts | grep -n $ip | cut -d : -f 1`
    do
        sed -ie "$ln"d /home/jomoon/.ssh/known_hosts
    done

    sshpass -p "$esxi_passwd" ssh -o StrictHostKeyChecking=no root@$esxi_host "poweroff; halt"

done

