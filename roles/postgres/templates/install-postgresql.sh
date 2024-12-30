
helm install postgresql-ha bitnami/postgresql-ha -n postgresql-ha -f postgresql-ha-values.yaml

kubectl patch svc postgresql-ha-postgresql -n postgresql-ha -p '{"spec": {"type": "LoadBalancer", "loadBalancerIP": "192.168.1.241"}}'

helm uninstall postgresql-ha -n postgresql-ha

