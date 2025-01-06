
kubectl -n rook-ceph exec deploy/rook-ceph-operator -- curl $(kubectl -n rook-ceph get svc -l app=rook-ceph-mon -o jsonpath='{.items[0].spec.clusterIP}'):3300 2>/dev/null

