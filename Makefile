# add the IP address, username and hostname of the target hosts here

USERNAME=jomoon
COMMON="yes"
# ANSIBLE_HOST_PASS="Mc002661!@"
ANSIBLE_HOST_PASS="changeme"
ANSIBLE_TARGET_PASS="changeme"
# include ./*.mk

GPHOSTS := $(shell grep -i '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' ./ansible-hosts | sed -e "s/ ansible_ssh_host=/,/g")

all:
	@echo ""
	@echo "[ Available targets ]"
	@echo ""
	@echo "init:            will install basic requirements (will ask several times for a password)"
	@echo "install:         will install the host with what is defined in install.yml"
	@echo "update:          run OS updates"
	@echo "ssh:             jump ssh to host"
	@echo "role-update:     update all downloades roles"
	@echo "available-roles: list known roles which can be downloaded"
	@echo "clean:           delete all temporary files"
	@echo ""
	@for GPHOST in ${GPHOSTS}; do \
		IP=$${GPHOST#*,}; \
	    	HOSTNAME=$${LINE%,*}; \
		echo "Current used hostname: $${HOSTNAME}"; \
		echo "Current used IP: $${IP}"; \
		echo "Current used user: ${USERNAME}"; \
		echo ""; \
	done

init:	setup-host.yml update-host.yml
	$(shell sed -i -e '2s/.*/ansible_become_pass: ${ANSIBLE_TARGET_PASS}/g' ./group_vars/all.yml)
	@echo ""
	@for GPHOST in ${GPHOSTS}; do \
		IP=$${GPHOST#*,}; \
	    	HOSTNAME=$${LINE%,*}; \
		echo "It will init host $${IP} and install ssh key and basic packages"; \
		echo ""; \
		echo "Note: NEVER use this step to init a host in an untrusted network!"; \
		echo "Note: this will OVERWRITE any existing keys on the host!"; \
		echo ""; \
		echo "3 seconds to abort ..."; \
		echo ""; \
		sleep 3; \
		echo "IP : $${IP} , HOSTNAME : $${HOSTNAME} , USERNAME : ${USERNAME}"; \
		./init_host.sh "$${IP}" "${USERNAME}"; \
	done
	ansible-playbook -i ansible-hosts -u ${USERNAME} --ssh-common-args='-o UserKnownHostsFile=./known_hosts -o VerifyHostKeyDNS=true' install-ansible-prereqs.yml

# - https://ansible-tutorial.schoolofdevops.com/control_structures/
install: role-update install.yml
	ansible-playbook -i ansible-hosts --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} install.yml --tags="install"

reinit: role-update reinit.yml
	ansible-playbook -i ansible-hosts --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} reinit.yml --tags="reinit"

uninstall: role-update uninstall.yml
	ansible-playbook -i ansible-hosts --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} uninstall.yml --tags="uninstall"

upgrade: role-update upgrade-hosts.yml
	ansible-playbook -i ansible-hosts --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} upgrade-hosts.yml --tags="upgrade"

update: role-update update-hosts.yml
	ansible-playbook -i ansible-hosts --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -i ${IP}, -u ${USERNAME} update-hosts.yml

boot: role-update control-vms.yml
	ansible-playbook --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} control-vms.yml --extra-vars "power_state=powered-on power_title=Power-On VMs"

shutdown: role-update control-vms.yml
	ansible-playbook --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} control-vms.yml --extra-vars "power_state=shutdown-guest power_title=Shutdown VMs"


# https://stackoverflow.com/questions/4219255/how-do-you-get-the-list-of-targets-in-a-makefile
no_targets__:
role-update:
	sh -c "$(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep '^ansible-update-*'" | xargs -n 1 make --no-print-directory
        $(shell sed -i -e '2s/.*/ansible_become_pass: ${ANSIBLE_HOST_PASS}/g' ./group_vars/all.yml )

ssh:
	ssh -o UserKnownHostsFile=./known_hosts ${USERNAME}@${IP}

install-hosts.yml:
	cp -a install-host.template install-hosts.yml

update-hosts.yml:
	cp -a update-host.template update-hosts.yml

# clean:
# 	rm -rf ./known_hosts install-hosts.yml update-hosts.yml

.PHONY:	all init install update ssh common clean no_targets__ role-update
