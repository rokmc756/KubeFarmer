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
