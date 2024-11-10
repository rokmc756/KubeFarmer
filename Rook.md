## Storage Architecture
Ceph is a highly scalable distributed storage solution for block storage, object storage, and shared filesystems with years of production deployments.
### Design
Rook enables Ceph storage to run on Kubernetes using Kubernetes primitives. With Ceph running in the Kubernetes cluster, Kubernetes applications can mount block devices and filesystems managed by Rook, or can use the S3/Swift API for object storage. The Rook operator automates configuration of storage components and monitors the cluster to ensure the storage remains available and healthy.
The Rook operator is a simple container that has all that is needed to bootstrap and monitor the storage cluster. The operator will start and monitor Ceph monitor pods, the Ceph OSD daemons to provide RADOS storage, as well as start and manage other Ceph daemons. The operator manages CRDs for pools, object stores (S3/Swift), and filesystems by initializing the pods and other resources necessary to run the services.
The operator will monitor the storage daemons to ensure the cluster is healthy. Ceph mons will be started or failed over when necessary, and other adjustments are made as the cluster grows or shrinks. The operator will also watch for desired state changes specified in the Ceph custom resources (CRs) and apply the changes.
Rook automatically configures the Ceph-CSI driver to mount the storage to your pods. The rook/ceph image includes all necessary tools to manage the cluster. Rook is not in the Ceph data path. Many of the Ceph concepts like placement groups and crush maps are hidden so you don't have to worry about them. Instead, Rook creates a simplified user experience for admins that is in terms of physical resources, pools, volumes, filesystems, and buckets. Advanced configuration can be applied when needed with the Ceph tools.
Rook is implemented in golang. Ceph is implemented in C++ where the data path is highly optimized. We believe this combination offers the best of both world
### Architecture
![alt text](https://github.com/rokmc756/kubefarmer/blob/main/roles/rook-ceph/files/Rook-High-Level-Architecture.png)


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


[ TroubelShooting ]
https://github.com/projectcalico/calico/issues/6687 - Calico node issue


[ Kernel Version Config ]
# Default Kernel for Rocky 9.3
$ grubby --set-default /boot/vmlinuz-5.14.0-362.8.1.el9_3.x86_64
$ reboot


[ Kernel Parameter ]
https://www.scaleway.com/en/docs/containers/kubernetes/reference-content/modifying-kernel-parameters-kubernetes-cluster/#creating-a-daemonset-to-modify-kernel-parameters


[ SELinux ]
https://platform9.com/blog/selinux-kubernetes-rbac-and-shipping-security-policies-for-on-prem-applications/
https://platform9.com/learn/v1.0/tutorials/rook-using-ceph-csi
https://kubernetes.io/docs/tasks/configure-pod-container/security-context/

# semanage fcontext -l  | grep kub | grep container_file
# /var/lib/kubelet/pod-resources/kubelet.sock        all files          system_u:object_r:container_file_t:s0
# /var/lib/kubernetes/pods(/.*)?                     all files          system_u:object_r:container_file_t:s0

