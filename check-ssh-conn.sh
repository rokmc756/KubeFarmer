
for i in `seq 1 7`
do
    nc -vz 192.168.1.7$i 22
    # ssh-keyscan 192.168.1.71
    # ssh-keyscan 192.168.1.71 >/dev/null 2>&1
done

