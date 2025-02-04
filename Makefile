USERNAME=jomoon
COMMON="yes"
ANSIBLE_HOST_PASS="changeme"
ANSIBLE_TARGET_PASS="changeme"

# Define Variables for KVM
KVM_BOOT_CMD="start"
KVM_SHUTDOWN_CMD="shutdown"
KVM_ROLE_CONFIG="control-vms-kvm.yml"
KVM_HOST_CONFIG="ansible-hosts-kvm"

# Define Variables for VMware
VMWARE_BOOT_CMD="powered-on"
VMWARE_SHUTDOWN_CMD="shutdown-guest"
VMWARE_ROLE_CONFIG="control-vms-vmware.yml"
VMWARE_HOST_CONFIG="ansible-hosts-vmware"


BOOT_CMD=${VMWARE_BOOT_CMD}
SHUTDOWN_CMD=${VMWARE_SHUTDOWN_CMD}
ROLE_CONFIG=${VMWARE_ROLE_CONFIG}
ANSIBLE_HOST_CONFIG=${VMWARE_HOST_CONFIG}


# Switch KVM or VMware
kvm:
	ln -sfv ansible-hosts-rk9-kvm ansible-hosts
vmware:
	ln -sfv ansible-hosts-rk9-vmware ansible-hosts


# Control VMs in KVM For Power On or Off
boot:
	@ansible-playbook -i ${ANSIBLE_HOST_CONFIG} --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} ${ROLE_CONFIG} --extra-vars "power_state=${BOOT_CMD} power_title=Power-On VMs"

shutdown:
	@ansible-playbook -i ${ANSIBLE_HOST_CONFIG} --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} ${ROLE_CONFIG} --extra-vars "power_state=${SHUTDOWN_CMD} power_title=Shutdown VMs"

iharbor:
	@if [ ! -z ${r} ] && [ "${s}" != "all" ]; then\
		ansible-playbook -i ansible-hosts-iharbor --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} config-iharbor.yml -e '{"${s}": True}' --tags='${r}';\
	elif [ ! -z ${r} ] && [ "${s}" == "all" ]; then \
		ansible-playbook -i ansible-hosts-iharbor --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} config-iharbor.yml -e '{harbor_all: True}' --tags='${r}';\
	else\
		echo 'No item for "${r}"';\
	fi


#	@if [ ! -z ${r} ] && [ "${s}" != "all" ]; then\
#		echo ${r};\
#		if [ ! -z ${c} ]; then\
#			ansible-playbook -i ansible-hosts-iharbor --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} config-iharbor.yml -e '{"${s}": True}' --tags='${r}';\
#		else\
#			echo 'No item for "${r}"';\
#		fi\
#	lif [ ! -z ${r} ] && [ "${s}" = "all" ]; then\
#		if [ ! -z ${c} ]; then\
#			ansible-playbook -i ansible-hosts-iharbor --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} config-iharbor.yml -e '{harbor_all: True}' --tags='${r}';\
#		else\
#			echo 'No item for "${r}"';\
#		fi\
#	else\
#		echo 'No item for "${r}"';\
#	fi


#	@if [ "${r}" = "install" ]; then\
#		ansible-playbook -i ansible-hosts-iharbor --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} config-iharbor.yml --tags="install";\
#	elif [ "${r}" = "uninstall" ]; then\
#		ansible-playbook -i ansible-hosts-iharbor --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} config-iharbor.yml --tags="uninstall";\
#	else\
#		echo "No Actions for Harbor";\
#		exit;\
#	fi


# For All Roles
%:
	@cat Makefile.tmp  | sed -e 's/temp/${*}/g' > Makefile.${*}
	@cat setup-temp.yml.tmp | sed -e 's/    - temp/    - ${*}/g' > setup-${*}.yml
	@make -f Makefile.${*} r=${r} s=${s} c=${c} USERNAME=${USERNAME}
	@rm -f setup-${*}.yml Makefile.${*}


#	@make -f ./configs/Makefile.${*} r=${r} s=${s} c=${c} USERNAME=${USERNAME}

# clean:
# 	rm -rf ./known_hosts install-hosts.yml update-hosts.yml


# https://stackoverflow.com/questions/4219255/how-do-you-get-the-list-of-targets-in-a-makefile
#no_targets__:
#role-update:
#	sh -c "$(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep '^ansible-update-*'" | xargs -n 1 make --no-print-directory
#        $(shell sed -i -e '2s/.*/ansible_become_pass: ${ANSIBLE_HOST_PASS}/g' ./group_vars/all.yml )


# Need to check what it should be needed
.PHONY:	all init install update ssh common clean no_targets__ role-update

