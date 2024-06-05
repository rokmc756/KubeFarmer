## Rancher Architecture
![alt text](https://github.com/rokmc756/kubefarmer/blob/main/roles/rancher/files/rancher-architecture-separation-of-rancher-server.svg)

## Rancher Server and Components
The majority of Rancher 2.x software runs on the Rancher Server. Rancher Server includes all the software components used to manage the entire Rancher deployment.
The figure below illustrates the high-level architecture of Rancher 2.x. The figure depicts a Rancher Server installation that manages two downstream Kubernetes clusters: one created by RKE and another created by Amazon EKS (Elastic Kubernetes Service).
For the best performance and security, we recommend a dedicated Kubernetes cluster for the Rancher management server. Running user workloads on this cluster is not advised. After deploying Rancher, you can create or import clusters for running your workloads.
The diagram below shows how users can manipulate both Rancher-launched Kubernetes clusters and hosted Kubernetes clusters through Rancher's authentication proxy:
Managing Kubernetes Clusters through Rancher's Authentication Proxy
![alt text](https://github.com/rokmc756/kubefarmer/blob/main/roles/rancher/files/rancher-architecture-rancher-api-server.svg)


## Communicating with Downstream User Clusters
This section describes how Rancher provisions and manages the downstream user clusters that run your apps and services.
The below diagram shows how the cluster controllers, cluster agents, and node agents allow Rancher to control downstream clusters.
Communicating with Downstream Clusters
![alt text](https://github.com/rokmc756/kubefarmer/blob/main/roles/rancher/files/rancher-architecture-cluster-controller.svg)


## References
* https://metallb.universe.tf/installation/
* https://oopflow.medium.com/setup-install-rancher-onto-existing-kubernetes-cluster-for-high-availability-7351f0284592
* https://www.adaltas.com/en/2022/09/08/kubernetes-metallb-nginx/
* https://github.com/rancher/rancher/issues/37193
* https://kubernetes.github.io/ingress-nginx/user-guide/exposing-tcp-udp-services/


## Test
~~~
$ kubectl expose deployment nginx-ingress-controller --type=LoadBalancer --name=nginx-ingress -n nginx-ingress
service/nginx-ingress exposed
~~~
