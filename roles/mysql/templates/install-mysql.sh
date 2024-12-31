# https://github.com/mysql/mysql-ndb-operator/blob/main/docs/getting-started.md

# https://lkshminarayanan.medium.com/introducing-ndb-operator-the-kubernetes-operator-for-mysql-ndb-cluster-7db4c712cb8b

# https://velog.io/@kubernetes/MySQL-Operator-for-Kubernetes

# https://dev.mysql.com/doc/ndb-operator/8.4/en/installation-helm-chart.html

# helm install mysql-innodb mysql-operator/mysql-innodbcluster --set credentials.root.password='changeme' --set tls.useSelfSigned=true --set installCRDs=true --namespace mysql-innodb --create-namespace



helm repo add ndb-operator-repo https://mysql.github.io/mysql-ndb-operator/

helm repo update

helm install ndb-operator ndb-operator-repo/ndb-operator     --namespace=ndb-operator --create-namespace

kubectl get all -n ndb-operator

git clone https://github.com/mysql/mysql-ndb-operator

cd mysql-ndb-operator/

kubectl apply -f example-ndb.yaml
