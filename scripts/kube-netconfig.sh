#!/bin/bash

MTU0=1500
MTUx=9000
DOMAIN="jtest.pivotal.io"
DNS0="192.168.0.100"
DNS1="192.168.0.90"
DNS2="8.8.8.8"
DNS3="168.126.63.1"
NET0="192.168.0.0/24"
NET1="192.168.1.0/24"
NET2="192.168.2.0/24"
GW0="192.168.0.1"
GW1="192.168.1.1"
GW2="192.168.2.1"
NETDEV_PREFIX=ens


# SEQ,NET,TABLE,PRIO,MTU,NETNUM,NETWORK_RANGE,ROUTABLE
INFO_TABLE="
0,192.168.0.17,200,100,$MTU0,192,$NET0,yes,$GW0
1,192.168.1.17,201,101,$MTUx,224,$NET1,no,$GW1
2,192.168.2.17,202,102,$MTUx,256,$NET2,yes,$GW2
"

ENDIP=$(hostname | cut -d 0 -f 2)

for i in $(echo $INFO_TABLE)
do

    SEQ=$(echo $i | cut -d , -f 1)
    IPNUM=$(echo $i | cut -d , -f 2)
    TABLE=$(echo $i | cut -d , -f 3)
    PRIO=$(echo $i | cut -d , -f 4)
    MTU=$(echo $i | cut -d , -f 5)
    NETNUM=$(echo $i | cut -d , -f 6)
    NET=$(echo $i | cut -d , -f 7)
    ROUTABLE=$(echo $i | cut -d , -f 8)
    GATEWAY=$(echo $i | cut -d , -f 9)


    nmcli connection delete conn$SEQ
    # nmcli connection delete eth$SEQ
    # nmcli connection delete ens$NETNUM
    nmcli con add con-name conn$SEQ type ethernet ifname ens$NETNUM ipv4.method auto
    nmcli con modify conn$SEQ ipv4.method manual ipv4.address $IPNUM$ENDIP/24
    nmcli con modify conn$SEQ ipv4.gateway $GATEWAY
    nmcli connection modify conn$SEQ 802-3-ethernet.mtu $MTU
    nmcli connection modify conn$SEQ ipv4.dns $DNS0,$DNS1,$DNS2,$DNS3 ipv4.dns-search $DOMAIN
    nmcli connection modify conn$SEQ ipv4.routes "$NET table=$TABLE" ipv4.routing-rules "priority $PRIO from $IPNUM$ENDIP table $TABLE"
    nmcli connection modify conn$SEQ ipv6.method "disabled"
    nmcli con mod conn$SEQ ipv4.never-default $ROUTABLE
    nmcli con up conn$SEQ

done

# Need reboot to apply or check if restaring NM is possible
# nmcli connection modify conn1 ipv4.routes "192.168.0.0/24 table=100" +ipv4.routes "0.0.0.0/0 192.168.0.18$ENDIP table=100" ipv4.routing-rules "priority 101 from 192.168.0.1 table 100"
# nmcli connection modify conn2 ipv4.routes "192.168.1.0/24 table=100" +ipv4.routes "0.0.0.0/0 192.168.1.15$ENDIP table=100" ipv4.routing-rules "priority 101 from 192.168.1.1 table 100"
# nmcli connection modify conn3 ipv4.routes "192.168.1.0/24 table=200" +ipv4.routes "0.0.0.0/0 192.168.1.20$ENDPI table=200" ipv4.routing-rules "priority 102 from 192.168.1.1 table 200"

