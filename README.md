# What is KubeFarmer
KubeFamer is ansible playbook to deploy kubernetes cluster on Rocky Linux 9 in order to deploy bunch of k8s software and application on it such as postgres,kubeflow,kafka and so an.

# Kubernetes Cluster Architecutre
![alt text](https://github.com/rokmc756/kubefarmer/blob/main/roles/k8s-cluster/files/kubernetes_architecture.webp)

# How to install Kubernetes Cluster
~~~
- hosts: all
  become: yes
  vars:
    print_debug: true
    install_dep_packages: true
    install_k8s_packages: true
    uninstall_dep_packages: true
    uninstall_k8s_packages: true
  roles:
    - k8s-cluster
~~~

# Reference
### https://www.tecmint.com/install-a-kubernetes-cluster-on-centos-8/
### https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker
### https://medium.com/@heshani.samarasekara/installing-harbor-registry-in-centos-7-961773d155ec
### https://serverfault.com/questions/1059073/kubernetes-trouble-var-lib-calico-nodename-no-such-file-or-directory

~~~
iscsiadm --mode node --targetname iqn.2022-02.io.pivotal.jtest:labs.target01 --portal 192.168.0.2 -u
iscsiadm --mode node --targetname iqn.2022-02.io.pivotal.jtest:labs.target01 --portal 192.168.0.2 -o delete
~~~

~~~
[root@rk9-master ~]# kubectl get ns
NAME                   STATUS        AGE
default                Active        16m
kube-node-lease        Active        16m
kube-public            Active        16m
kube-system            Active        16m
kubernetes-dashboard   Terminating   13m

#
[root@rk9-master ~]# kubectl api-resources --verbs=list --namespaced -o name \
  | xargs -n 1 kubectl get --show-kind --ignore-not-found -n kubernetes-dashboard
NAME                                            READY   STATUS        RESTARTS   AGE
pod/dashboard-metrics-scraper-7bc864c59-cm7q6   0/1     Terminating   0          15m
pod/kubernetes-dashboard-6ff574dd47-4vf28       0/1     Terminating   0          15m

[root@rk9-master ~]# kubectl get namespace "kubernetes-dashboard" -o json   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/"   | kubectl replace --raw /api/v1/namespaces/kubernetes-dashboard/finalize -f -

{"kind":"Namespace","apiVersion":"v1","metadata":{"name":"kubernetes-dashboard","uid":"f29fb080-9a2b-439e-87f8-e986d34dcaaf","resourceVersion":"1292","creationTimestamp":"2022-12-29T15:05:54Z","deletionTimestamp":"2022-12-29T15:08:20Z","labels":{"kubernetes.io/metadata.name":"kubernetes-dashboard"},"annotations":{"kubectl.kubernetes.io/last-applied-configuration":"{\"apiVersion\":\"v1\",\"kind\":\"Namespace\",\"metadata\":{\"annotations\":{},\"name\":\"kubernetes-dashboard\"}}\n"},"managedFields":[{"manager":"kubectl-client-side-apply","operation":"Update","apiVersion":"v1","time":"2022-12-29T15:05:54Z","fieldsType":"FieldsV1","fieldsV1":{"f:metadata":{"f:annotations":{".":{},"f:kubectl.kubernetes.io/last-applied-configuration":{}},"f:labels":{".":{},"f:kubernetes.io/metadata.name":{}}}}},{"manager":"kube-controller-manager","operation":"Update","apiVersion":"v1","time":"2022-12-29T15:09:04Z","fieldsType":"FieldsV1","fieldsV1":{"f:status":{"f:conditions":{".":{},"k:{\"type\":\"NamespaceContentRemaining\"}":{".":{},"f:lastTransitionTime":{},"f:message":{},"f:reason":{},"f:status":{},"f:type":{}},"k:{\"type\":\"NamespaceDeletionContentFailure\"}":{".":{},"f:lastTransitionTime":{},"f:message":{},"f:reason":{},"f:status":{},"f:type":{}},"k:{\"type\":\"NamespaceDeletionDiscoveryFailure\"}":{".":{},"f:lastTransitionTime":{},"f:message":{},"f:reason":{},"f:status":{},"f:type":{}},"k:{\"type\":\"NamespaceDeletionGroupVersionParsingFailure\"}":{".":{},"f:lastTransitionTime":{},"f:message":{},"f:reason":{},"f:status":{},"f:type":{}},"k:{\"type\":\"NamespaceFinalizersRemaining\"}":{".":{},"f:lastTransitionTime":{},"f:message":{},"f:reason":{},"f:status":{},"f:type":{}}}}},"subresource":"status"}]},"spec":{},"status":{"phase":"Terminating","conditions":[{"type":"NamespaceDeletionDiscoveryFailure","status":"False","lastTransitionTime":"2022-12-29T15:08:26Z","reason":"ResourcesDiscovered","message":"All resources successfully discovered"},{"type":"NamespaceDeletionGroupVersionParsingFailure","status":"False","lastTransitionTime":"2022-12-29T15:08:26Z","reason":"ParsedGroupVersions","message":"All legacy kube types successfully parsed"},{"type":"NamespaceDeletionContentFailure","status":"True","lastTransitionTime":"2022-12-29T15:09:04Z","reason":"ContentDeletionFailed","message":"Failed to delete all resource types, 1 remaining: unexpected items still remain in namespace: kubernetes-dashboard for gvr: /v1, Resource=pods"},{"type":"NamespaceContentRemaining","status":"True","lastTransitionTime":"2022-12-29T15:08:26Z","reason":"SomeResourcesRemain","message":"Some resources are remaining: pods. has 2 resource instances"},{"type":"NamespaceFinalizersRemaining","status":"False","lastTransitionTime":"2022-12-29T15:08:26Z","reason":"ContentHasNoFinalizers","message":"All content-preserving finalizers finished"}]}}
~~~

### Pods stuck in Terminating status
~~~
[root@rk9-master ~]# kubectl api-resources --verbs=list --namespaced -o name \
  | xargs -n 1 kubectl get --show-kind --ignore-not-found -n kubernetes-dashboard
NAME                                            READY   STATUS        RESTARTS   AGE
pod/dashboard-metrics-scraper-7bc864c59-cm7q6   0/1     Terminating   0          18m
pod/kubernetes-dashboard-6ff574dd47-4vf28       0/1     Terminating   0          18m
[root@rk9-master ~]#
[root@rk9-master ~]#
[root@rk9-master ~]#
[root@rk9-master ~]# kubectl delete pod kubernetes-dashboard-6ff574dd47-4vf28
Error from server (NotFound): pods "kubernetes-dashboard-6ff574dd47-4vf28" not found
[root@rk9-master ~]#
[root@rk9-master ~]#

[root@rk9-master ~]# kubectl delete pod dashboard-metrics-scraper-7bc864c59-cm7q6 --grace-period=0 --force --namespace kubernetes-dashboard
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "dashboard-metrics-scraper-7bc864c59-cm7q6" force deleted

[root@rk9-master ~]# kubectl delete pod kubernetes-dashboard-6ff574dd47-4vf28 --grace-period=0 --force --namespace kubernetes-dashboard
Warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "kubernetes-dashboard-6ff574dd47-4vf28" force deleted
~~~
