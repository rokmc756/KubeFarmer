
MGR_CONT_ID=`podman ps | grep ceph | grep mgr | awk '{print" "$NF}' | tr -d '^[:blank:]'`
MGR_CONT_ID=`podman ps | grep ceph | grep mgr | awk '{print" "$NF}' | tr -d '^[:blank:]'`

podman exec -it $MGR_CONT_ID sh

# podman exec -it $MGR_CONT_ID bash

