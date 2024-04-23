for i in `seq 1 6`
do

    sudo ping -c 1 192.168.0.17$i
    sudo ping -c 1 192.168.1.17$i
    sudo ping -c 1 192.168.2.17$i

done

