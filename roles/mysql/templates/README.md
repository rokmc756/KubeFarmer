
# https://severalnines.com/blog/running-galera-cluster-kubernetes/

# https://techdocs.broadcom.com/us/en/vmware-tanzu/reference-architectures/tanzu-solutions-workbooks/services/tnz-use-cases/solution-workbooks-mysql-backup.html

Volumes:
  data:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  data-galera-mysql-galera-0
    ReadOnly:   false
  previous-boot:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:
    SizeLimit:  <unset>
  mysql-galera-config:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      galera-mysql-galera-configuration
    Optional:  false
  empty-dir:
    Type:        EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:



https://github.com/bitnami/charts/blob/main/bitnami/mysql-galera/values.yaml


https://artifacthub.io/packages/helm/bitnami/mysql-galera


