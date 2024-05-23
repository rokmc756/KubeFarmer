
## Install Metallb and Rancher
* https://metallb.universe.tf/installation/
* https://oopflow.medium.com/setup-install-rancher-onto-existing-kubernetes-cluster-for-high-availability-7351f0284592
* https://www.adaltas.com/en/2022/09/08/kubernetes-metallb-nginx/


~~~
# kubectl create namespace metallb-system
# helm repo add metallb https://metallb.github.io/metallb
# helm install metallb metallb/metallb -n metallb-system

$ kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system

$ kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.11/config/manifests/metallb-native.yaml

$ kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

~~~

$ mkdir /metallb-config

$ vi /metallb-config/metallb-config.yaml
~~~
apiVersion: v1
kind: ConfigMap
metadata:
  name: config
  namespace: metallb-system
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 192.168.1.180-192.168.1.250
~~~

~~~

$ kubectl apply -f /metallb-config/metallb-config.yaml

$ git clone https://github.com/nginxinc/kubernetes-ingress.git --branch v3.0.2

$ cd kubernetes-ingress/deployments/helm-chart

$ helm repo add nginx-stable https://helm.nginx.com/stable

$ helm repo update

$ helm install nginx-ingress nginx-stable/nginx-ingress --namespace=nginx-ingress --create-namespace=true

$ kubectl delete ingressclass nginx --all-namespaces

$ kubectl get ingressclass --all-namespaces

$ helm install nginx-ingress .

$ kubectl apply -f crds/ --namespace=nginx-ingress

$ kubectl delete -f crds/ --namespace=nginx-ingress

$ kubectl apply -f crds/ --namespace=nginx-ingress

$ helm upgrade nginx-ingress nginx-stable/nginx-ingress --namespace=nginx-ingress

~~~


~~~
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh
~~~

~~~
$ helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
$ helm repo update
$ kubectl delete namespace cattle-system
$ kubectl create namespace cattle-system
~~~


~~~

$ kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.7.1/cert-manager.crds.yaml
$ helm repo add jetstack https://charts.jetstack.io
$ helm repo update


$ kubectl create namespace cert-manager
$ helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.7.1

# \
#  --set webhook.hostNetwork=true \
#  --debug

$ kubectl get pods --namespace cert-manager

~~~


# OK
$ helm install cert-manager jetstack/cert-manager \
--namespace cert-manager \
--version v1.7.1 \
--set webhook.hostNetwork=true \
--set webhook.securePort=10260 \
--set startupapicheck.timeout=1m \
--debug
# --set installCRDs=true \
# --create-namespace \


kubectl get pods --namespace cert-manager


kubectl apply -f /kubernetes_config/rancher/rancher-loadbalancer.yml


 kubectl -n cattle-system get all


# helm install rancher rancher-stable/rancher \
#  --version 2.6.4 \
#  --namespace cattle-system \
#  --set hostname=rancher.test.co.th \
#  --set replicas=3

$ helm install rancher rancher-stable/rancher \
>   --namespace cattle-system \
>   --set hostname=rancher.jtest.suse.com \
    --set replicas=3

# Error: INSTALLATION FAILED: chart requires kubeVersion: < 1.29.0-0 which is incompatible with Kubernetes v1.30.1



kubectl -n cattle-system rollout status deploy/rancher


kubectl -n cattle-system get all



## References
* https://github.com/rancher/rancher/issues/37193
* https://kubernetes.github.io/ingress-nginx/user-guide/exposing-tcp-udp-services/

~~~
$ kubectl expose deployment nginx-ingress-controller --type=LoadBalancer --name=nginx-ingress -n nginx-ingress
service/nginx-ingress exposed
~~~
