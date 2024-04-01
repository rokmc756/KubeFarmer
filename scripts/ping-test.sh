for i in `echo "1 2 3 4 5 9"`
do

    sudo ping -c 1 192.168.0.7$i
    sudo ping -c 1 192.168.1.7$i
    sudo ping -c 1 192.168.2.7$i
 
    #sudo ping -c 1 192.168.0.17$i
    #sudo ping -c 1 192.168.1.17$i
    #sudo ping -c 1 192.168.1.18$i
    #sudo ping -c 1 192.168.1.19$i
    #sudo ping -c 1 192.168.1.20$i
    #sudo ping -c 1 192.168.1.21$i

done

