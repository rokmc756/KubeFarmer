pgsql:
	@if [ "${r}" = "prepare" ]; then\
		if [ ! -z ${r} ] && [ "${s}" != "all" ]; then\
			if [ -z ${c} ];  then\
				ansible-playbook --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} setup-pgsql.yml -e '{"${s}": True}' --tags='prepare';\
			else\
				echo "No Actions for Configure PostgreSQL Database";\
			fi\
		elif [ ! -z ${r} ] && [ "${s}" = "all" ]; then\
			if [ -z ${c} ];  then\
				ansible-playbook --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} setup-pgsql.yml -e '{pgsql_all: True}' --tags='prepare';\
			else\
				echo "No Actions for Configure PostgreSQL Database";\
			fi\
		else\
			echo "No Actions for Configure PostgreSQL Database";\
		fi;\
	elif [ "${r}" = "install" ]; then\
		if [ ! -z ${r} ] && [ "${s}" != "all" ]; then\
			if [ -z ${c} ];  then\
				ansible-playbook --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} setup-pgsql.yml -e '{"${s}": True}' --tags='install';\
			else\
				echo "No Actions for Installing PostgreSQL Database";\
			fi\
		elif [ ! -z ${r} ] && [ "${s}" = "all" ]; then\
			if [ -z ${c} ];  then\
				ansible-playbook --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} setup-pgsql.yml -e '{pgsql_all: True}' --tags='install';\
			else\
				echo "No Actions for Installing PostgreSQL Database";\
			fi\
		else\
			echo "No Actions for Installing PostgreSQL Database";\
		fi;\
	elif [ "${r}" = "uninstall" ]; then\
		if [ ! -z ${r} ] && [ "${s}" != "all" ]; then\
			if [ -z ${c} ];  then\
				ansible-playbook --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} setup-pgsql.yml -e '{"${s}": True}' --tags='uninstall';\
			else\
				echo "No Actions for Uninstalling PostgreSQL Database";\
			fi\
		elif [ ! -z ${r} ] && [ "${s}" = "all" ]; then\
			if [ -z ${c} ];  then\
				ansible-playbook --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} steup-pgsql.yml -e '{pgsql_all: True}' --tags='uninstall';\
			else\
				echo "No Actions for Uninstalling PostgreSQL Database";\
			fi\
		elif [ ! -z ${r} ] && [ "${s}" = "common" ]; then\
			if [ -z ${c} ];  then\
				ansible-playbook --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} steup-pgsql.yml -e '{pgsql_all: True}' --tags='uninstall';\
			else\
				echo "No Actions for Uninstalling Common Role for PostgreSQL Database";\
			fi\
		else\
			echo "No Actions for Uninstalling PostgreSQL Database";\
		fi;\
	elif [ "${r}" = "upgrade" ]; then\
		if [ ! -z ${r} ] && [ "${s}" != "all" ]; then\
			if [ -z ${c} ];  then\
				ansible-playbook --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} setup-pgsql.yml -e '{"${s}": True}' --tags='upgrade';\
			else\
				echo "No Actions for Uninstalling PostgreSQL Database";\
			fi\
		elif [ ! -z ${r} ] && [ "${s}" = "all" ]; then\
			if [ -z ${c} ];  then\
				ansible-playbook --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} steup-pgsql.yml -e '{pgsql_all: True}' --tags='upgrade';\
			else\
				echo "No Actions for Uninstalling PostgreSQL Database";\
			fi\
		else\
			echo "No Actions for Uninstalling PostgreSQL Database";\
		fi;\
	else\
		echo "No Actions for PostgreSQL Database Role";\
		exit;\
	fi

