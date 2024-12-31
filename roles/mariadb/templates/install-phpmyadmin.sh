
helm install phpmyadmin bitnami/phpmyadmin -n phpmyadmin -f phpmyadmin-values.yaml


kubectl patch svc phpmyadmin -n phpmyadmin -p '{"spec": {"type": "LoadBalancer", "loadBalancerIP": "192.168.1.237"}}'


