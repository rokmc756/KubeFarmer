for i in `kubectl -n rook-ceph get pod | grep rook-ceph-mon- | awk '{print $1}'`
do

    # kubectl -n rook-ceph logs pod/$i
    kubectl -n rook-ceph describe pod/$i

done
