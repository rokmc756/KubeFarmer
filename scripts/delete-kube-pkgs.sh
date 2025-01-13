
root_pass="changeme"

for i in `seq 1 7`
do

    sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no root@192.168.0.7$i "yum versionlock clear"
    sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no root@192.168.0.7$i "yum remove -y kubectl kubeadm kubelet"

done
