#!/bin/bash
#

lab_host="192.168.2.101"
lab_ips="192.168.2.101"
lab_passwd="changeme"


for ip in `echo $lab_ips`
do
    for ln in `cat /home/jomoon/.ssh/known_hosts | grep -n $ip | cut -d : -f 1`
    do
        sed -ie "$ln"d /home/jomoon/.ssh/known_hosts
    done

    sshpass -p "$lab_passwd" ssh -o StrictHostKeyChecking=no root@$lab_host "shutdown -h now"
done

