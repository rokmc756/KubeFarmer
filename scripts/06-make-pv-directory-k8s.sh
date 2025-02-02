for i in `seq 1 5`
do
    for j in `echo "rk9-master rk9-node01 rk9-node02 rk9-node03"`
    do
        ssh root@$j "rm -rfv /postgres-volume/data0$i"
        ssh root@$j "mkdir -pv /postgres-volume/data0$i"
        ssh root@$j "ls -al /postgres-volume/data0$i"
    done
done
