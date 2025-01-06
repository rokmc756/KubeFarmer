[01]
kubectl create -f 01-storageclass.yaml


[02]
kubectl create -f 02-mysql.yaml


[03]
kubectl create -f 03-wordpress.yaml


[04]
kubectl delete -f wordpress.yaml


[05]
kubectl delete -f mysql.yaml


[06]
# Got hung when mysql and workproess is not deleted
kubectl delete -n rook-ceph cephblockpools.ceph.rook.io replicapool
~~~
2025-01-06 16:36:56.060663 E | ceph-block-pool-controller: failed to reconcile CephBlockPool "rook-ceph/replicapool". failed to delete pool "replicapool". : failed to delete pool "replicapool": failed to check if pool "replicapool" has rbd images: pool "replicapool" contains images/snapshots
~~~
# https://github.com/rook/rook/issues/6002


[07]
# kubectl get cephblockpools.ceph.rook.io -n rook-ceph
NAME          PHASE   TYPE         FAILUREDOMAIN   AGE
replicapool   Ready   Replicated   host            61m


[08]
kubectl -n rook-ceph logs po/rook-ceph-operator-5bfddc8c57-5s2fq -f


[09]
kubectl -n rook-ceph get events
LAST SEEN   TYPE      REASON               OBJECT                      MESSAGE
116s        Normal    ReconcileSucceeded   cephblockpool/replicapool   successfully configured CephBlockPool "rook-ceph/replicapool"
119s        Normal    Deleting             cephblockpool/replicapool   deleting CephBlockPool "rook-ceph/replicapool"
119s        Normal    ReconcileStarted     cephblockpool/replicapool   starting blockpool deletion
18m         Warning   ReconcileFailed      cephblockpool/replicapool   failed to reconcile CephBlockPool "rook-ceph/replicapool". failed to delete pool "replicapool". : failed to delete pool "replicapool": failed to check if pool "replicapool" has rbd images: pool "replicapool" contains images/snapshots
116s        Normal    ReconcileSucceeded   cephblockpool/replicapool   successfully removed finalizer
116s        Normal    ReconcileSucceeded   cephblockpool/replicapool   successfully configured CephBlockPool "rook-ceph/replicapool"


[10]
kubectl delete storageclass rook-ceph-block


[11]
kubectl create -f 04-pool-mirrored.yaml
Error from server (BadRequest): error when creating "04-pool-mirrored.yaml": CephBlockPool in version "v1" cannot be handled as a CephBlockPool: strict decoding error: unknown field "mirroring", unknown field "name", unknown field "namespace", unknown field "replicated"


[12]
kubectl create -f 05-filesystem.yaml


[13]
kubectl -n rook-ceph get pod -l app=rook-ceph-mds


[14]
sh 07-rook-status.sh
~~~
  cluster:
    id:     c38f75ed-04d7-456c-8c43-c877529942ce
~~~
  services:
    mon: 3 daemons, quorum a,b,c (age 2h)
    mgr: b(active, since 2h), standbys: a
    mds: 1/1 daemons up, 1 hot standby
~~


[15]
kubectl create -f /root/rook/deploy/examples/csi/cephfs/storageclass.yaml


[16]
kubectl create -f /root/rook/deploy/examples/csi/cephfs/kube-registry.yaml


[17]
kubectl create -f 06-shared-volume.yaml


[18]
kubectl create -f 07-shared-volume-02.yaml


[19]
kubectl create -f 08-shared-volume-03.yaml


[20]
kubectl delete -f /root/rook/deploy/examples/csi/cephfs/kube-registry.yaml


[21]
kubectl -n rook-ceph delete cephfilesystem myfs


[22]
kubectl create -f 09-filesystem-mirror.yaml


[23]
kubectl create -f 11-object.yaml


[24]
kubectl -n rook-ceph get pod -l app=rook-ceph-rgw


[25]
kubectl create -f 12-object-shared-pools.yaml


[26]
kubectl create -f 13-object-a.yaml


[27]
kubectl -n rook-ceph get pod -l rgw=store-a


[28]
kubectl create -f 14-local-object-store.yaml
Error from server (AlreadyExists): error when creating "14-local-object-store.yaml": cephobjectstores.ceph.rook.io "my-store" already exists


# https://rook.io/docs/rook/latest/Storage-Configuration/Object-Storage-RGW/object-storage/#create-each-object-store




