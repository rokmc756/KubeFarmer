## Install Harbor Container Registry
~~~yaml
$ make iharbor r=setup     s=pkgs
$ make iharbor r=disable   s=selinux
$ make iharbor r=setup     s=docker
$ make iharbor r=setup     s=harbor
$ make iharbor r=enable    s=ssl
$ make iharbor r=enable    s=docker
$ make iharbor r=enable    s=harbor
$ make iharbor r=start     s=harbor
$ make iharbor r=enable    s=firewall

or
$ make iharbor r=install   s=all
~~~


## Uninstall Harbor Container Registry
~~~yaml
$ make iharbor r=stop      s=harbor
$ make iharbor r=remove    s=docker
$ make iharbor r=remove    s=pkgs
$ make iharbor r=enable    s=selinux

or
$ make iharbor r=uninstall s=all
~~~


## Push Docker Image into Harbor
### Find Harbor URI
~~~
[root@rk9-node01 ~]# nslookup harbor.jtest.pivotal.io
Server:         192.168.0.90
Address:        192.168.0.90#53

Name:   harbor.jtest.pivotal.io
Address: 192.168.0.78
~~~

### Login into Harbor Registry
~~~
[root@rk9-node01 ~]# docker login https://harbor.jtest.pivital.io
Authenticating with existing credentials...
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credential-stores

Login Succeeded
~~~

### Pull Ubuntu Image
~~~
[root@rk9-node01 ~]# docker pull ubuntu:22.04
22.04: Pulling from library/ubuntu
3713021b0277: Pull complete
Digest: sha256:340d9b015b194dc6e2a13938944e0d016e57b9679963fdeb9ce021daac430221
Status: Downloaded newer image for ubuntu:22.04
docker.io/library/ubuntu:22.04
~~~

### List Ubuntu Image
~~~
[root@rk9-node01 ~]# docker images
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
ubuntu       22.04     8a3cdc4d1ad3   4 weeks ago   77.9MB
~~~

### Tag Ubuntu Image
~~~
[root@rk9-node01 ~]# docker tag ubuntu:22.04 harbor.jtest.pivotal.io/jproject01/ubuntu:22.04
~~~

### Push Ubuntu Image
~~~
[root@rk9-node01 ~]# docker push harbor.jtest.pivotal.io/jproject01/ubuntu:22.04
The push refers to repository [harbor.jtest.pivotal.io/jproject01/ubuntu]
931b7ff0cb6f: Pushed
22.04: digest: sha256:bd1487129c4e01470664c3f3c9a25ce01f73ff3df75ffa7eb3388d3d4b945369 size: 529
~~~


