#!/bin/bash

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
# mysql  my_script.sql
# service mysql status;