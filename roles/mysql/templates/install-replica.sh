

kubectl create namespace mysql-replica


helm install mysql-replica bitnami/mysql --namespace mysql-replica --values mysql-replica-values.yaml



