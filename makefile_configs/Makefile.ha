ha:
	@if [ "${r}" = "install" ]; then\
		ansible-playbook --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} setup-ha.yml --tags='install';\
	elif [ "${r}" = "uninstall" ]; then\
		ansible-playbook --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} setup-ha.yml --tags='uninstall';\
	else\
		echo "No Actions for HA Proxy";\
		exit;\
	fi

