
root_pass="changeme"
sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no root@192.168.2.$1 $2

