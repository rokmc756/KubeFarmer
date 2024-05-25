
[ References ]

- https://danawalab.github.io/kubernetes/2020/01/28/kubernetes-rook-ceph.html
- https://medium.com/@rkssh-daas/setting-up-rook-ceph-on-k8s-and-safeguarding-your-data-on-an-unmanaged-ha-k8s-cluster-368ee3924cc4
- https://velero.io/docs/main/contributions/minio/
- https://itmaya.co.kr/wboard/view.php?wb=tech&idx=35
- https://nairns.tistory.com/95
- https://gcore.com/learning/deploying-highly-scalable-cloud-storage-with-rook-part-1-ceph-storage/
- https://rook.io/docs/rook/v1.11/Storage-Configuration/NFS/nfs-csi-driver/#creating-snapshots
- https://rook.io/docs/rook/v1.14/Troubleshooting/ceph-csi-common-issues/#cephfs-stale-operations
- https://itmaya.co.kr/wboard/view.php?wb=tech&idx=35
- https://gcore.com/learning/deploying-highly-scalable-cloud-storage-with-rook-part-1-ceph-storage/
- Latest version 5/25, 2024
- https://www.digitalocean.com/community/tutorials/how-to-set-up-a-ceph-cluster-within-kubernetes-using-rook
- https://platform9.com/learn/v1.0/tutorials/rook-using-ceph-csi
- https://velero.io/docs/main/contributions/minio/
- https://rook.io/docs/rook/v1.14/Troubleshooting/ceph-csi-common-issues/


* On Cloud
- https://elastisys.com/elastisys-engineering-how-to-set-up-rook-with-ceph-on-kubernetes/
- https://ashish932.medium.com/f3abe23d9e79
- https://github.com/kubernetes/community/blob/master/contributors/devel/sig-storage/flexvolume.md#prerequisites
- https://1week.tistory.com/16

* 6789, 3000 Port Check
- Server nc -l 6789 or 3000
- Client nc 192.168.0.x 6789
  type "hi" and check server return "hi"
