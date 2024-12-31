
root_pass="changeme"

for i in `seq 71 77`
do

    sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no root@192.168.1.$i "rm -rf /mnt/postgresql-storage/*"

done

