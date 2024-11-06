
# kubectl -n rook-ceph logs pod/csi-rbdplugin-provisioner-5d9fb8699c-t6bq7

# kubectl -n rook-ceph logs pod/csi-rbdplugin-provisioner-5d9fb8699c-27rsk


for i in `kubectl -n rook-ceph get pod | grep csi-rbdplugin-provisioner | awk '{print $1}'`
do

    kubectl -n rook-ceph logs pod/$i

done
