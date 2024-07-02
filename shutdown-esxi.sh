GW_HOST="192.168.0.101"
ESXi_IPs="192.168.0.231 192.168.0.101"

for i in `echo $ESXi_IPs`
do
    # echo $i

    for ln in `cat /home/jomoon/.ssh/known_hosts | grep -n $i | cut -d : -f 1`
    do
        echo $ln
        sed -ie "$ln"d /home/jomoon/.ssh/known_hosts
    done

    sshpass -p "Changeme34#$" ssh -o StrictHostKeyChecking=no root@192.168.0.231 "poweroff; halt"
    # sshpass -p "Changeme12!@" ssh -o StrictHostKeyChecking=no root@192.168.0.101 "poweroff; halt"

done

