
for i in `seq 1 5`
do

    ssh root@rk9-node0$i "echo \$(hostname)"
    ssh root@rk9-node0$i "rm -rf /var/lib/rook"
    ssh root@rk9-node0$i "for j in \$(echo 'nvme0n1 nvme0n2 nvme0n3 nvme0n4'); do nvme format --ses=1 /dev/\$j --force ; done"
    ssh root@rk9-node0$i "for j in \$(echo 'nvme0n1 nvme0n2 nvme0n3 nvme0n4'); do wipefs -a /dev/\$j ; done"
    ssh root@rk9-node0$i "for j in \$(echo 'nvme0n1 nvme0n2 nvme0n3 nvme0n4'); do sgdisk --zap-all /dev/\$j ; done"
    ssh root@rk9-node0$i "for j in \$(echo 'nvme0n1 nvme0n2 nvme0n3 nvme0n4'); do dd if=/dev/zero of=/dev/\$j bs=10M count=10 oflag=direct,dsync ; done"
    ssh root@rk9-node0$i "for j in \$(echo 'nvme0n1 nvme0n2 nvme0n3 nvme0n4'); do blkdiscard /dev/\$j ; done"
    ssh root@rk9-node0$i "for j in \$(echo 'nvme0n1 nvme0n2 nvme0n3 nvme0n4'); do partprobe /dev/\$j ; done"

done

