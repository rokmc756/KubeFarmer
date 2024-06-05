## What is KubeFarmer
The KubeFarmer is Ansible Playbook to deploy Native Kubernetes Cluster and deploy bunch of K8S Softwares and Applications on it such as Rancher, Rook Ceph, Postgres, Kubeflow, Kafka and so an.

## Kubernetes Cluster Architecutre
![alt text](https://github.com/rokmc756/kubefarmer/blob/main/roles/k8s/files/kubernetes_architecture.webp)

## Supported Platform and OS
Virtual Machines\
Baremetal\
RHEL and CentOS 9 and Rocky Linux 9.x\
OpenSUSE 15.x\
Ubuntu 22.x

## Prerequisite for ansible host
MacOS or Windows Linux Subsysetm or Many kind of Linux Distributions should have ansible as ansible host.\
Supported OS for ansible target host should be prepared with package repository configured such as yum, dnf and apt as well as zypper\

## Prepare ansible host to run gpfarmer
* MacOS
```
$ xcode-select --install
$ brew install ansible
$ brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb
```

* Fedora/CentOS/RHEL, Ubuntu, OpenSUSE
```
$ yum install ansible
$ apt install ansible
$ zypper install ansible
```

## How to Deploy and Destroy Kubernetes Cluster
#### 1) Configure Variables and Inventory with Hostnames, IP Addresses, sudo Username and Password
##### Configure Inventory
```
$ vi ansible-hosts
[all:vars]
ssh_key_filename="id_rsa"
remote_machine_username="jomoon"
remote_machine_password="changeme"
ansible_python_interpreter=/usr/bin/python3

[master]
rk9-master ansible_ssh_host=192.168.0.91

[workers]
rk9-node01 ansible_ssh_host=192.168.0.93
rk9-node02 ansible_ssh_host=192.168.0.94
rk9-node03 ansible_ssh_host=192.168.0.95
```

##### Configure Variables
```
$ vi roles/init-hosts/vars/main.yml
ansible_ssh_pass: "changeme"
ansible_become_pass: "changeme"
sudo_user: "kubeadm"
sudo_group: "kubeadm"
local_sudo_user: "jomoon"
wheel_group: "wheel"            # RHEL / CentOS / Rocky / SUSE / OpenSUSE
root_user_pass: "changeme"
sudo_user_pass: "changeme"
sudo_user_home_dir: "/home/{{ sudo_user }}"
domain_name: "jtest.suse.com"
~~ snip
```

##### Configure Global Variables
```
$ vi group_vars/all.yml
ansible_ssh_pass: "changeme"
ansible_become_pass: "changeme"

k8s:
  cluster_name: jack-suse-k8s
  major_version: "1"
  minor_version: "28"               # Rancher does not support higher than kubernetes 1.28.x versions currently
  patch_version: "0"
  build_version: ""
  repo_url: ""
  download_url: ""
  download: false
  base_path: /root
  host_num: "{{ groups['workers'] | length }}"
  net:
    type: "virtual"                # Or Physical
    gateway: "192.168.0.1"
    ipaddr0: "192.168.0.7"
    ipaddr1: "192.168.1.7"
    ipaddr2: "192.168.2.7"
~~ snip
  cni:
    name: calico # kube-flannel
    operator: ""
    major_version: 3
    minor_version: 27
    patch_version: 3
    pod_network: "10.142.0.0/16"
~~ snip
```


#### 2) Initialize Linux Hosts to exchanges ssh keys for passwordless login and install neccessary packages as well as configure /etc/hosts file
```
$ vi install.yml
---
- hosts: all
  become: yes
  vars:
    container_runtime: "containerd"   # crio or podman
    print_debug: true
    install_pkgs: true
    disable_firewall: true
    config_kube_software: true
    init_k8s: true
    stop_services: true
  roles:
    - init-hosts

$ make install
```
[![YouTube](http://i.ytimg.com/vi/mFp3oi2-sb0/hqdefault.jpg)](https://www.youtube.com/watch?v=mFp3oi2-sb0)


#### 3) Deploy Kubernetes Cluster
```
$ vi install.yml
---
- hosts: all
  become: yes
  vars:
    container_runtime: "containerd"   # crio or podman
    print_debug: true
    install_pkgs: true
    disable_firewall: true
    config_kube_software: true
    init_k8s: true
    stop_services: true
  roles:
    - k8s

$ make install
```
[![YouTube](http://i.ytimg.com/vi/ZAYEYPk-NEk/hqdefault.jpg)](https://www.youtube.com/watch?v=ZAYEYPk-NEk)


#### 4) Destroy Kubernetes Cluster
```
$ vi uninstall.yml
---
- hosts: all
  become: yes
  vars:
    container_runtime: "containerd"   # containerd
    print_debug: true
    stop_services: true
    uninstall_pkgs: true
    uninstall_config: true
    enable_firewall: false
    reboot_required: true
  roles:
    - k8s

$ make uninstall
```
[![YouTube](http://i.ytimg.com/vi/OW_NdpsjJSg/hqdefault.jpg)](https://www.youtube.com/watch?v=OW_NdpsjJSg)


#### 5) Deploy Rancher
```
$ vi install.yml
---
- hosts: all
  become: yes
  vars:
    container_runtime: "containerd"   # crio or podman
    print_debug: true
    install_pkgs: true
    disable_firewall: true
    config_kube_software: true
    init_k8s: true
    stop_services: true
  roles:
    - rancher

$ make install
~~~
```
[![YouTube](http://i.ytimg.com/vi/8a8S0V1Gs4E/hqdefault.jpg)](https://www.youtube.com/watch?v=8a8S0V1Gs4E)


#### 6) Destroy Rancher
```
$ vi uninstall.yml
---
- hosts: all
  become: yes
  vars:
    container_runtime: "containerd"   # containerd
    print_debug: true
    stop_services: true
    uninstall_pkgs: true
    uninstall_config: true
    enable_firewall: false
    reboot_required: true
  roles:
    - rancher

$ make uninstall
~~~
```
[![YouTube](http://i.ytimg.com/vi/QTmhB9awxY8/hqdefault.jpg)](https://www.youtube.com/watch?v=QTmhB9awxY8)


#### 7) Deploy Rook Ceph
```
$ vi install.yml
---
- hosts: all
  become: yes
  vars:
    container_runtime: "containerd"   # crio or podman
    print_debug: true
    install_pkgs: true
    disable_firewall: true
    config_kube_software: true
    init_k8s: true
    stop_services: true
  roles:
    - rook-ceph

$ make install
~~~
```
[![YouTube](http://i.ytimg.com/vi/fw0qFdploNQ/hqdefault.jpg)](https://www.youtube.com/watch?v=fw0qFdploNQ)


#### 8) Destroy Rook Ceph
```
$ vi uninstall.yml
---
- hosts: all
  become: yes
  vars:
    container_runtime: "containerd"   # containerd
    print_debug: true
    stop_services: true
    uninstall_pkgs: true
    uninstall_config: true
    enable_firewall: false
    reboot_required: true
  roles:
    - rook-ceph

$ make uninstall
~~~
```
[![YouTube](http://i.ytimg.com/vi/jSCiGs7OCFg/hqdefault.jpg)](https://www.youtube.com/watch?v=jSCiGs7OCFg)


### 9) Reinitialize Kubernetes Cluster
The make reinit will reinitialize k8s cluster referring reinit.yml playbook if you are struggle the uncertain situation such as stuck or panic
```
$ vi reinit.yml
- hosts: all
  become: yes
  vars:
    container_runtime: "containerd"   # crio or podman?
    print_debug: true
    enable_firewall: false
    disable_firewall: true
    stop_services: true
    calico_network: false
  roles:
    - k8s

$ make reinit
```


## Reference
* https://www.tecmint.com/install-a-kubernetes-cluster-on-centos-8/
* https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker
* https://medium.com/@heshani.samarasekara/installing-harbor-registry-in-centos-7-961773d155ec
* https://serverfault.com/questions/1059073/kubernetes-trouble-var-lib-calico-nodename-no-such-file-or-directory
* https://k21academy.com/docker-kubernetes/multi-node-kubernetes-cluster-on-suse-linux/
* https://stackoverflow.com/questions/62795930/how-to-install-kubernetes-in-suse-linux-enterprize-server-15-virtual-machines
* https://documentation.suse.com/ko-kr/sles/15-SP2/html/SLES-all/cha-selinux.html
* https://k21academy.com/docker-kubernetes/container-runtime-is-not-running/
* https://tuanpembual.wordpress.com/2020/10/15/run-opensuse-kubic-like-k8s-podman-cri-o-on-alibaba-cloud/
* https://github.com/rokmc756/kubefarmer/blob/main/roles/k8s/files/kubernetes-cluster-architecture.svg
* https://medium.com/@muppedaanvesh/deploying-nginx-on-kubernetes-a-quick-guide-04d533414967
* https://kubernetes.io/docs/tasks/run-application/run-stateless-application-deployment/
* https://aws.plainenglish.io/how-to-deploy-a-nginx-server-with-kubernetes-9228f17e399c
* https://medium.com/@sumuduliyan/kubernetes-networking-with-calico-623f4583ae8d


## TODO
* Fixing interaction with harbor
* Deploy VMware-Postgres and MySQL


## Debugging
* DNS - https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/
* Network - https://yandex.cloud/en/docs/managed-kubernetes/operations/calico?utm_referrer=https%3A%2F%2Fwww.google.com%2F

