## Deploy and Destroy Harbor Container Registry
~~~yaml
$ make iharbor r=install s=all

or
$ make iharbor r=uninstall s=all
~~~


## Test Private Docker Repository
~~~yaml
$ docker pull nginx:latest
$ docker tag nginx:latest harbor.jtest.pivotal.io/jproject01/nginx:latest
$ docker push harbor.jtest.pivotal.io/jproject01/nginx:latest
~~~


## Install Korifi
~~~yaml
$ make  korifi  r=enable     s=repo
$ make  korifi  r=setup      s=go
$ make  korifi  r=setup      s=kustomize
$ make  korifi  r=setup      s=cm
$ make  korifi  r=setup      s=cli
$ make  korifi  r=prepare    s=korifi
$ make  korifi  r=deploy     s=korifi
$ make  korifi  r=create     s=admin
$ make  korifi  r=enable     s=docker
$ make  korifi  r=deploy     s=apps

or
$ make  korifi  r=install    s=all
~~~

## Uninstall Korifi
~~~yaml
$ make  korifi  r=destroy    s=apps
$ make  korifi  r=disable    s=docker
$ make  korifi  r=delete     s=admin
$ make  korifi  r=destroy    s=korifi
$ make  korifi  r=clean      s=korifi
$ make  korifi  r=delete     s=cli
$ make  korifi  r=delete     s=cm
$ make  korifi  r=delete     s=go
$ make  korifi  r=disable    s=repo

or
$ make  korifi  r=uninstall  s=all
~~~

