#!/bin/bash

#DEBUG 
#set -x

service mysql start

sleep 3 
# Assurez-vous que le service MySQL est correctement démarré avant d'exécuter les commandes MySQL. Vous pouvez ajouter une pause ou une vérification pour vous assurer que le service est actif avant d'exécuter les commandes suivantes.

mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
# # mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
# # mysql -e "FLUSH PRIVILEGES;"

# mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
# exec mysqld_safe
exec mysqld

#debug
# set +x

# mysql  my_script.sql
# service mysql status;






# if [ ! -f "/var/lib/mysql/file_flag_mdb_done" ]; then

# 	service mysql start

# 	# Wait for service to be ready
# 	echo -n "Waiting for service to be fully started"
# 	sleep 3 # Sleep at least tree
# 	while [ ! -e /var/run/mysqld/mysqld.sock ]; do 
# 		echo -n .
# 		sleep 1
# 	done
# 	echo ""
	
# 	mysql << EOF
# CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
# CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@\`localhost\` IDENTIFIED BY '${MYSQL_PASSWORD}';
# GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
# FLUSH PRIVILEGES;
# EOF
# 	sleep 5
# 	mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown
# 	touch /var/lib/mysql/file_flag_mdb_done
# fi

# exec mysqld