## What is KubeFarmer
The KubeFarmer is ansible playbook to deploy Native Kubernetes Cluster in order to deploy bunch of k8s software and application on it such as rancher,rook ceph,postgres,kubeflow,kafka and so an.

## Kubernetes Cluster Architecutre
![alt text](https://github.com/rokmc756/kubefarmer/blob/main/roles/k8s/files/kubernetes_architecture.webp)

![alt text](https://github.com/rokmc756/kubefarmer/blob/main/roles/k8s/files/kubernetes-cluster-architecture.svg)

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

* Fedora/CentOS/RHEL
```
$ sudo yum install ansible
```

## How to deploy and destroy Kubernetes Cluster
#### 1) Configure Inventory with hostnames, ip addresses, sudo username and password for VMs
```
$ vi ansible-hosts
[all:vars]
ssh_key_filename="id_rsa"
remote_machine_username="jomoon"
remote_machine_password="changeme"
ansible_python_interpreter=/usr/bin/python3

[master]
rk9-master ansible_ssh_host=192.168.0.91

[slave]
rk9-slave ansible_ssh_host=192.168.0.92

[workers]
rk9-node01 ansible_ssh_host=192.168.0.93
rk9-node02 ansible_ssh_host=192.168.0.94
rk9-node03 ansible_ssh_host=192.168.0.95

[docker-repo]
rk9-harbor ansible_ssh_host=192.168.0.99

[minio]
rk9-minio ansible_ssh_host=192.168.0.98
```

#### 2) Configure KubeFarmer ansible playbook and deploy harbor, kubernetes cluster and dashboard
```
$ vi install-hosts.yml
---
- hosts: rk9-slave
  roles:
    - harbor

- hosts: all
  become: yes
  vars:
    print_debug: true
    install_dep_packages: false
    install_k8s_packages: false
  roles:
    - k8s-cluster
    - dashboard

$ make install
```

#### 3) Reinitialize Kubernetes Cluster
The make reinit will reinitialize k8s cluster referring install-hosts.yml playbook same as initial deployment
```
$ make reinit
```

#### 4) Configure KubeFarmer ansible playbook and destroy harbor, dashboard and kubenetes cluster
```
$ vi uninstall-hosts.yml
- hosts: rk9-harbor
  become: yes
  roles:
    - harbor

- hosts: all
  become: yes
  vars:
    print_debug: true
    uninstall_dep_packages: true
    uninstall_k8s_packages: true
    calico_network: false
    k8s_network_address: "192.168.0.0/16"
  roles:
    - dashboard
    - k8s-cluster

$ make uninstall
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


## Planing
Fixing interaction with harbor\
Deploy VMware-Postgres and MySQL


## Testing
```
iscsiadm --mode node --targetname iqn.2022-02.io.pivotal.jtest:labs.target01 --portal 192.168.0.2 -u
iscsiadm --mode node --targetname iqn.2022-02.io.pivotal.jtest:labs.target01 --portal 192.168.0.2 -o delete
```


## Debugging
* DNS - https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/
* Network - https://yandex.cloud/en/docs/managed-kubernetes/operations/calico?utm_referrer=https%3A%2F%2Fwww.google.com%2F


## References
* https://medium.com/@muppedaanvesh/deploying-nginx-on-kubernetes-a-quick-guide-04d533414967
* https://kubernetes.io/docs/tasks/run-application/run-stateless-application-deployment/
* https://aws.plainenglish.io/how-to-deploy-a-nginx-server-with-kubernetes-9228f17e399c
* https://medium.com/@sumuduliyan/kubernetes-networking-with-calico-623f4583ae8d

