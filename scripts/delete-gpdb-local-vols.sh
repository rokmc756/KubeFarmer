#!/bin/bash

RANGE="81 85"
USER="root"

for i in `seq $RANGE`
do
    ssh $USER@192.168.0.$i "
    rm -fv /local-vols/gpdb-vol01/*;
    ls -al /local-vols/gpdb-vol01/;
    rm -fv /local-vols/gpdb-vol02/*;
    ls -al /local-vols/gpdb-vol02/;
    rm -fv /local-vols/gpdb-vol03/*;
    ls -al /local-vols/gpdb-vol03/;
    rm -fv /local-vols/gpdb-vol04/*;
    ls -al /local-vols/gpdb-vol04/;
    rm -fv /local-vols/gpdb-vol05/*;
    ls -al /local-vols/gpdb-vol05/;
    rm -fv /local-vols/gpdb-vol06/*;
    ls -al /local-vols/gpdb-vol06/;
"
done
