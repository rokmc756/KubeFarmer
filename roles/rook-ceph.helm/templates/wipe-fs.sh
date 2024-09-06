
# HOSTNAME_PREFIX=osuse15
HOSTNAME_PREFIX=rk9

for i in `seq 2 5`
do

    ssh root@$HOSTNAME_PREFIX-node0$i "echo \$(hostname)"
    ssh root@$HOSTNAME_PREFIX-node0$i "for j in \$(echo 'nvme0n1 nvme0n2 nvme0n3 nvme0n4'); do dd if=/dev/zero of=/dev/\$j bs=10M count=10; done"
    ssh root@$HOSTNAME_PREFIX-node0$i "for j in \$(echo 'nvme0n1 nvme0n2 nvme0n3 nvme0n4'); do wipefs -a -f /dev/\$j; done"

done

for j in $(echo 'nvme0n1 nvme0n2 nvme0n3 nvme0n4'); do dd if=/dev/zero of=/dev/$j bs=10M count=10; done
for j in $(echo 'nvme0n1 nvme0n2 nvme0n3 nvme0n4'); do wipefs -a -f /dev/$j; done

