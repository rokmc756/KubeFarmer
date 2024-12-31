USERNAME=jomoon
COMMON="yes"
ANSIBLE_HOST_PASS="changeme"
ANSIBLE_TARGET_PASS="changeme"

boot:
	@ansible-playbook --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} control-vms.yml --extra-vars "power_state=powered-on power_title=Power-On VMs"

shutdown:
	@ansible-playbook --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} control-vms.yml --extra-vars "power_state=shutdown-guest power_title=Shutdown VMs"

# For All Roles
%:
	@cp -af setup-hosts.yml.temp setup-${*}.yml
	@sed -i 's/    - hosts/    - ${*}/g' setup-${*}.yml
	@make -f ./configs/Makefile.${*} r=${r} s=${s} c=${c} USERNAME=${USERNAME}
	@rm -rf setup-${*}.yml

# clean:
# 	rm -rf ./known_hosts install-hosts.yml update-hosts.yml


# hosts     :  make hosts r=init ( or uninit )
# k8s       :  make k8s r=install ( or uninstall ) s=single ( or multi )
# rook:     :  make rook r=install or r=uninstall
# rancher   :  make rancher r=install or r=uninstall
# kubeflow  :  make kubeflow r=insstall or r=uninstall
# kubevirt  :  make kubevirt r=install or r=uninstall
# ha        :  haproxy and keeyalived
# korifi:   :  make korifi r=install or r=uninstall
# harbor:   :  make harbor r=install or r=uninstall
# spark     :  make spark r=install or r=uninstall
# dashboard :  make dashboard r=install or r=uninstall
# stratos   :  make stratos r=install or r=uninstall
# mariadb   :  make mariadb r=install ( or uninstall ) s=galera ( replica or phpmyadmin )
# powerdns  :  make powernds r=install ( or uninstall )
# grafana   :  make grafana r=install ( or unintll )
# pgsql     :  make pgsql


# https://stackoverflow.com/questions/4219255/how-do-you-get-the-list-of-targets-in-a-makefile
#no_targets__:
#role-update:
#	sh -c "$(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep '^ansible-update-*'" | xargs -n 1 make --no-print-directory
#        $(shell sed -i -e '2s/.*/ansible_become_pass: ${ANSIBLE_HOST_PASS}/g' ./group_vars/all.yml )


# Need to check what it should be needed
.PHONY:	all init install update ssh common clean no_targets__ role-update

