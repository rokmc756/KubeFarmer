#!/bin/bash

export CALICO_ZONE=calico-net

# Control Plain
for i in `echo rk9-master`
do

    ssh root@$i "cp -f /etc/firewalld/zones/docker.xml /root/docker.xml.org.$( date +%H-%m-%d-%S)"

    ssh root@$i "firewall-cmd --load-zone-defaults=public --permanent"
    ssh root@$i "firewall-cmd --load-zone-defaults=trusted --permanent"
    ssh root@$i "firewall-cmd --load-zone-defaults=docker --permanent"
    ssh root@$i "firewall-cmd --load-zone-defaults=calico-net --permanent"
    ssh root@$i "firewall-cmd --reload"

    # ssh root@$i "firewall-cmd --zone=public --permanent --add-port={6443,2379,2380,8472,10250,10251,10252,20255,30000-32767}/tcp"

    ssh root@$i "firewall-cmd --zone=public --permanent --add-port={80,443,2376,2379,2380,6443,8472,9099,10250,10251,10252,10254,10255}/tcp"
    ssh root@$i "firewall-cmd --zone=public --add-masquerade --permanent"
    # only if you want NodePorts exposed on control plane IP as well

    ssh root@$i "firewall-cmd --zone=public --permanent --add-port=30000-32767/tcp"
    ssh root@$i "firewall-cmd --zone=public --permanent --add-port=30000-32767/udp"

    ssh root@$i "firewall-cmd --permanent --new-zone=$CALICO_ZONE"
    ssh root@$i "firewall-cmd --permanent --zone=$CACLICO_ZONE --set-target=ACCEPT"
    ssh root@$i "firewall-cmd --permanent --zone=$CACLICO_ZONE --add-interface=vxlan.calico"
    # Then I looped through the calico network interfaces
    ssh root@$i "sh /root/add-calico-net-firewalld.sh"

    ssh root@$i "firewall-cmd --reload"

    # ssh root@$i "firewall-cmd --permanent --zone=trusted --add-source=10.0.0.0/16"
    # ssh root@$i "firewall-cmd --permanent --zone=trusted --add-source=192.168.0.0/32"
    # ssh root@$i "firewall-cmd --permanent --zone=trusted --add-source=192.168.219.0/32"
    # ssh root@$i "firewall-cmd --permanent --zone=trusted --add-source=192.168.100.0/32"
    # ssh root@$i "systemctl restart firewalld"

done

# For worker node
for i in `echo rk9-node01 rk9-node02 rk9-node03`
do

    ssh root@$i "cp -f /etc/firewalld/zones/docker.xml /root/docker.xml.org.$( date +%H-%m-%d-%S)"

    ssh root@$i "firewall-cmd --load-zone-defaults=public --permanent"
    ssh root@$i "firewall-cmd --load-zone-defaults=trusted --permanent"
    ssh root@$i "firewall-cmd --load-zone-defaults=docker --permanent"
    ssh root@$i "firewall-cmd --load-zone-defaults=calico-net --permanent"
    ssh root@$i "firewall-cmd --reload"

    ssh root@$i "firewall-cmd --zone=public --permanent --add-port={22,80,443,2376,2379,2380,8472,9099,10250,10254,10255}/tcp"

    ssh root@$i "firewall-cmd --zone=public --permanent --add-port=30000-32767/tcp"
    ssh root@$i "firewall-cmd --zone=public --permanent --add-port=30000-32767/udp"
    ssh root@$i "firewall-cmd --zone=public --add-masquerade --permanent"

    # ssh root@$i "firewall-cmd --zone=public  --remove-masquerade --permanent"

    # ssh root@$i "firewall-cmd --permanent --zone=trusted --add-source=10.0.0.0/16"
    # ssh root@$i "firewall-cmd --permanent --zone=trusted --add-source=192.168.0.0/24"
    # ssh root@$i "firewall-cmd --permanent --zone=trusted --add-source=192.168.219.0/24"
    # ssh root@$i "firewall-cmd --permanent --zone=trusted --add-source=192.168.100.0/24"

    ssh root@$i "firewall-cmd --zone=public --add-masquerade --permanent"

    ssh root@$i "firewall-cmd --permanent --new-zone=$CALICO_ZONE"
    ssh root@$i "firewall-cmd --permanent --zone=$CACLICO_ZONE --set-target=ACCEPT"
    ssh root@$i "firewall-cmd --permanent --zone=$CACLICO_ZONE --add-interface=vxlan.calico"
    # Then I looped through the calico network interfaces
    ssh root@$i "sh /root/add-calico-net-firewalld.sh"

    ssh root@$i "firewall-cmd --reload"
    # ssh root@$i "systemctl restart firewalld"

done
