
ssh root@192.168.0.90 "shutdown -h now"

for i in `seq 1 5`; do ssh root@192.168.6$i "shutdown -h now" ;done

