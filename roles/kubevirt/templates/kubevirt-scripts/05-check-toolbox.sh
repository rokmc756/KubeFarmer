

kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pods -o custom-columns=NAME:.metadata.name --no-headers | grep tools) -- ceph -s

kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pods -o custom-columns=NAME:.metadata.name --no-headers | grep tools) -- ceph osd pool set replicapool pg_num 256

kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pods -o custom-columns=NAME:.metadata.name --no-headers | grep tools) -- ceph -s

kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pods -o custom-columns=NAME:.metadata.name --no-headers | grep tools) -- ceph osd tree

