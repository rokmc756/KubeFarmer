
[ Prerequiests ]
* OSD need jumbo frame with MTU 9000
* Kubernetes Network should be with jumbo frame with MTU 9000


[ Useful Commands ]
* How to change admin password
~~~
$
~~~



## Need to check Port is working
* 6789, 3000 Port Check
- Server nc -l 6789 or 3000
- Client nc 192.168.0.x 6789
  type "hi" and check server return "hi"


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
- https://www.talos.dev/v1.7/kubernetes-guides/configuration/ceph-with-rook/


* On VMware

Enabling disk UUID on virtual machines
You must set the disk.EnableUUID parameter for each VM to "TRUE". This step is necessary so that the VMDK always presents a consistent UUID to the VM,
thus allowing the disk to be mounted properly. For each of the virtual machine nodes (VMs) that will be participating in the cluster, follow the steps below from the vSphere client:

To enable disk UUID on a virtual machine

Power off the guest.
Select the guest and select Edit Settings.
Select the Options tab on top.
Select General under the Advanced section.
Select the Configuration Parameters... on right hand side.
Check to see if the parameter disk.EnableUUID is set, if it is there then make sure it is set to TRUE.
If the parameter is not there, select Add Row and add it.

Power on the guest.


* OSD is not created
https://www.juniper.net/documentation/us/en/software/paragon-automation23.2/paragon-automation-troubleshooting-guide/topics/topic-map/tg-troubleshoot-ceph-rook.html
https://www.dbi-services.com/blog/kubernetes-extension-of-disk-in-rook-ceph/


* KubeVirt
- https://kubevirt.io/2019/KubeVirt_storage_rook_ceph.html

* On Oracle Cloud
- https://blogs.oracle.com/cloud-infrastructure/post/running-ceph-clusters-with-rook-in-oracle-container-engine-for-kubernetes
- https://blog.rook.io/run-your-own-high-performance-ebs-wherever-kubernetes-runs-798a136bd808



* Host Storage Cluster
- https://rook.io/docs/rook/latest-release/CRDs/Cluster/host-cluster/#specific-nodes-and-devices


* Architecture
https://www.jacobbaek.com/1102
https://rook.io/docs/rook/latest-release/Getting-Started/storage-architecture/


* NVME
https://github.com/rook/rook/issues/7858
