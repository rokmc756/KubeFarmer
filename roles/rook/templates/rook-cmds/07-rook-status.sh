# kubectl -n rook-ceph logs rook-ceph-operator-7b878c7c4b-gv85p

# kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- ceph status

kubectl -n rook-ceph logs -l app=rook-ceph-operator

