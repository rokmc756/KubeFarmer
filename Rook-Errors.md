


# Quroum Failure

kubectl -n rook-ceph logs -l app=rook-ceph-operator

2024-11-05 05:53:25.695609 I | op-mon: mon "a" is back in quorum, removed from mon out timeout list
2024-11-05 05:53:25.695652 I | op-mon: marking mon "b" out of quorum
2024-11-05 05:53:25.696149 W | cephclient: skipping adding mon "b" to config file, detected out of quorum
2024-11-05 05:53:25.699017 I | cephclient: writing config file /var/lib/rook/rook-ceph/rook-ceph.config
2024-11-05 05:53:25.699259 I | cephclient: generated admin config in /var/lib/rook/rook-ceph
2024-11-05 05:53:25.707091 W | op-mon: mon "b" not found in quorum, waiting for timeout (599 seconds left) before failover
2024-11-05 05:53:26.241303 E | ceph-cluster-controller: failed to get ceph daemons versions. failed to run 'ceph versions'. . timed out: exit status 1
2024-11-05 05:54:25.857162 W | op-mon: failed to check mon health. failed to get mon quorum status: mon quorum status failed: exit status 1
2024-11-05 05:54:41.393755 E | ceph-cluster-controller: failed to get ceph status. failed to get status. . timed out: exit status 1
2024-11-05 05:54:56.527185 E | ceph-cluster-controller: failed to get ceph daemons versions. failed to run 'ceph versions'. . timed out: exit status 1


