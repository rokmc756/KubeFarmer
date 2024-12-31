

kubectl create namespace mariadb-replica


helm install mariadb-replica bitnami/mariadb --namespace mariadb-replica --values mariadb-replica-values.yaml



