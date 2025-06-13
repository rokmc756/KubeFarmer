#
~~~
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.6.1/aio/deploy/recommended.yaml
~~~

#
~~~
$ vi dashboard-adminuser.yaml
~~~
~~~
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
~~~

#
~~~
kubectl apply -f dashboard-adminuser.yaml
~~~

#
~~~
$ vi rbac.yml
~~~
~~~
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
~~~

#
~~~
kubectl apply -f rbac.yml
~~~

#
~~~
kubectl -n kubernetes-dashboard create token admin-user
~~~


## References
- https://engineering.zalando.com/posts/2021/12/maps-with-postgresql-and-postgis.html

