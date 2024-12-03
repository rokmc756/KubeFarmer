
sed -i 's/hdd/rook-ceph-block/' vm-dv.yaml

sed -i 's/fedora/centos/' vm-dv.yaml

sed -i 's@https://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img@http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2@' vm-dv.yaml

sed -i 's/storage: 100M/storage: 9G/' vm-dv.yaml

sed -i 's/memory: 64M/memory: 1G/' vm-dv.yaml

