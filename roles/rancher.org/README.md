## Setup: Install Rancher onto Existing Kubernetes Cluster for High Availability
There are many tutorials on Rancher being installed on Docker. Or Kubernetes Deployment within Rancher. But very few on Rancher being installed on an Existing Kubernetes Cluster. This tutorial will help address that.

Here are the prerequisites prior to installing rancher onto the existing Kubernetes cluster:

1. SSH Setup & Static IP Configuration for each node
2. Keepalived Setup
3. Kubernetes v1.24 Setup (required)
4. Calico Setup
5. Nginx-Ingress Setup
6. Metallb Setup

## This guide assumes that you are doing a baremetal Kubernetes setup.

As of this writing, Rancher requires that the Kubernetes server version is less than v1.25. You can find out your version by typing:
~~~
kubectl version --short
~~~

~~~
root@kmaster1:/# kubectl version --short
Flag --short has been deprecated, and will be removed in the future. The --short output will become the default.
Client Version: v1.24.0
Kustomize Version: v4.5.4
Server Version: v1.24.11
~~~

### If you do not have < v1.25, this rancher install will not work. So you must adjust your Kubernetes version until it says <v1.25. I recommend just restarting from scratch if you do not have that much installed. I couldnt get it to downgrade properly so I just restarted from scratch.
The commands to destroy the entire kubernetes cluster and restarting it is this. You have to do it on every single node:

~~~
kubeadm reset
sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni kube*
sudo dpkg --remove --force-all kubeadm kubectl kubelet kubernetes-cni kube*
sudo apt-get autoremove
sudo rm -rf ~/.kube

sudo reboot
~~~

When I reinstall the Kubernetes, this is what I type to ensure it installs the correct version

~~~
sudo apt update
sudo apt-get install -y kubelet=1.24.0-00 kubeadm=1.24.0-00 kubectl=1.24.0-00 --allow-downgrades --allow-change-held-packages
sudo apt-mark hold kubelet kubeadm kubectl
~~~

Afterwards, I install the other packages. The most notable of the packages is the Metallb. This is necessary (or some other external IP assigner) in order for Rancher to work. In case you do not have external IP Assigner in your Kubernetes Cluster, here is the steps to set that up.
~~~
mkdir /metallb-config
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist - from-literal=secretkey="$(openssl rand -base64 128)"
nano /metallb-config/metallb-config.yaml
~~~

Copy and paste the file called metallb-config.yaml from the repository into your local machine and edit the IP range to match your environment. Then apply the configuration to the cluster.

The file should look very similar to this. Copy and paste that into the yaml file that appeared when you ran the last command:
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
      - 192.168.1.120-192.168.1.250
~~~

I want to call attention to the line where it says 192.168.1.120–192.168.1.250. This is the part where you have to figure out what your router (dns server) can accept ip address ranges. Normally the way to figure out is by doing some sort of IP scan, and then knowing the first 3 blocks. So for example, I know that my router will accept 192.168.1 as valid. The last block, 120–250, is what I allow Metallb to assign as valid external ip to any services I want to use as an external IP on the kubernetes cluster. Because Rancher requires an external IP, this is why we need Metallb.

Afterwards, apply the metallb-config into the kubernetes cluster.
~~~
kubectl apply -f /metallb-config/metallb-config.yaml
~~~
The last thing to note before we begin setting up Rancher is the Nginx-Ingress Controller. Here are the commands to set that up:
~~~
git clone https://github.com/nginxinc/kubernetes-ingress.git --branch v3.0.2
cd kubernetes-ingress/deployments/helm-chart
helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update
helm install nginx-ingress nginx-stable/nginx-ingress --namespace=nginx-ingress --create-namespace=true
helm install nginx-ingress .
kubectl apply -f crds/ --namespace=nginx-ingress
helm upgrade nginx-ingress nginx-stable/nginx-ingress --namespace=nginx-ingress
~~~

Let us begin setting up rancher:

First you will need helm:
~~~
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
~~~

Then we will setup a namespace for everything related to rancher. We will call it cattle-system. The reason why we do it this way is to ensure each service is neatly installed and organized in the right place.

~~~
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
helm repo update
kubectl delete namespace cattle-system
kubectl create namespace cattle-system
~~~

I want to call out to the line: kubectl delete namespace cattle-system

The reason why I have that above create is to ensure that I delete any prior version of cattle-system I have before recreating. This type of way I ensure that I dont have any lingerring prior versions of any reinstalls for me. It is a good habit to have this so you dont end up with corrupted previous versions. This will reoccur throughout the remainder of this article.

Next we will install cert-manager
~~~
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.7.1/cert-manager.crds.yaml
kubectl create namespace cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.7.1
kubectl get pods --namespace cert-manager
~~~

Next we will create the loadbalancer for rancher:
~~~
mkdir -p /var/lib/rancher
mkdir -p /kubernetes_config/rancher/
kubectl delete -f /kubernetes_config/rancher/rancher-loadbalancer.yml
rm /kubernetes_config/rancher/rancher-loadbalancer.yml
sudo nano /kubernetes_config/rancher/rancher-loadbalancer.yml
~~~
Copy and paste the following yaml file for rancher-loadbalancer.yml

~~~
apiVersion: v1
kind: Service
metadata:
  name: rancher-loadbalancer
  namespace: cattle-system
  annotations:
    nginx.ingress.kubernetes.io/proxy-protocol: "true"
spec:
  selector:
    app: rancher
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: 80
    - name: https
      protocol: TCP
      port: 443
      targetPort: 443
  type: LoadBalancer
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: rancher-ingress
  namespace: cattle-system
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
    - host: rancher.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: rancher
                port:
                  name: http
~~~

Make sure to change “rancher.example.com” to whatever url you want. It does not need to be a valid public url.

Then apply the changes to the Kubernetes Cluster:
~~~
kubectl apply -f /kubernetes_config/rancher/rancher-loadbalancer.yml
~~~

When I run the following command to see if I deployed the loadbalancer correctly:
~~~
 kubectl -n cattle-system get all
~~~

It should look something very similar to:
~~~
NAME                           TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                      AGE
service/rancher-loadbalancer   LoadBalancer   10.109.90.178    192.168.1.121   80:32600/TCP,443:31603/TCP   74m
~~~

Note that it under the EXTERNAL-IP, it has an IP Address assigned to it. That means Metallb is working properly. If you do not have an External IP underneath it. Then Metallb is not installed properly. If it goes back and forth between showing an external ip and pending (when you rerun the get all command), that means another external ip assigner exists and the two are fighting control of it. So you need to resolve that.
If you got an external ip then you are good. We can go forward from there. Keep in mind that that is the external ip that rancher will end up getting.
Next we will install rancher:
~~~
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.example.com
~~~

This will take a metric assload long time. It took me around 15 minutes for everything to be properly deploy. You can check the status of the deployment by this:
~~~
kubectl -n cattle-system rollout status deploy/rancher
~~~

You can tell rancher is deployed successfully when you get this:
~~~
deployment "rancher" successfully rolled out
~~~
You can also check if rancher is deployed successfully by running:
~~~
kubectl -n cattle-system get all
~~~
Notice the pods of the output below. If you see Ready 1/1 on all of the rancher pods, and the external ip of the rancher-loadbalancer. You Are good. It should look very very similar to that output.
~~~
NAME                                   READY   STATUS    RESTARTS      AGE
pod/rancher-6757f6b675-687rc           1/1     Running   3 (66m ago)   74m
pod/rancher-6757f6b675-wvvmw           1/1     Running   1 (71m ago)   74m
pod/rancher-6757f6b675-zwnsl           1/1     Running   1 (71m ago)   74m
pod/rancher-webhook-577b778f8f-trkqw   1/1     Running   0             62m

NAME                           TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                      AGE
service/rancher                ClusterIP      10.106.146.246   <none>          80/TCP,443/TCP               74m
service/rancher-loadbalancer   LoadBalancer   10.109.90.178    192.168.1.121   80:32600/TCP,443:31603/TCP   74m
service/rancher-webhook        ClusterIP      10.110.173.40    <none>          443/TCP                      62m
service/webhook-service        ClusterIP      10.104.1.120     <none>          443/TCP                      62m

NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/rancher           3/3     3            3           74m
deployment.apps/rancher-webhook   1/1     1            1           62m

NAME                                         DESIRED   CURRENT   READY   AGE
replicaset.apps/rancher-6757f6b675           3         3         3       74m
replicaset.apps/rancher-webhook-577b778f8f   1         1         1       62m
~~~

After 15 minute or so of it deploying. You can go to your browser and type the external ip address of the rancher-loadbalancer. In my particular case it is 192.168.1.121. YOURS WILL BE DIFFERENT. So you just copy and paste your external ip address into the browser.
Once you see that page. You got rancher installed properly!
If you are having issues you can use these commands to try and diagnose the issue by looking into the logs:
~~~
kubectl get events --all-namespaces  --sort-by='.metadata.creationTimestamp'
kubectl -n cattle-system describe pods
kubectl -n cattle-system get all
kubectl -n cattle-system get pods
kubectl -n cattle-system logs <pod-name>
~~~

Note that if you want to setup the url for rancher properly you will need to manage the url with a DNS server, be it internally or externally.
For internal use, just use Pi-Hole. I tried Bind9 enterprise and kept bashing my head in. So to save you that headache, just go with Pi-Hole.
Getting rancher.example.com to work properly, is separate article.  

## Relevant Links
https://oopflow.medium.com/setup-install-rancher-onto-existing-kubernetes-cluster-for-high-availability-7351f0284592

