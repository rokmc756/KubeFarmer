#!/bin/bash

for i in $(seq 71 75)
do
    ssh root@192.168.1.$i reboot
done

