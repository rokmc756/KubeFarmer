
for i in `seq 1 6`
do
    
    sudo ping -c1 192.168.1.17$i
    nc -vz 192.168.1.17$i 22
    ssh-keyscan 192.168.1.17$i >/dev/null 2>&1

    # ssh-keyscan 192.168.1.17$i

done


