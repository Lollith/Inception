#!/bin/bash
#.sh remplace mon .sql

service mysql start
#le service MySQL doit etre correctement démarré avant d'exécuter les commandes MySQL. sinon erreurs de mdp
# while ( mysql --user=root --connect-timeout=1 -e "SELECT 1" &> /dev/null)
# while ! service mysql status | grep "running"
# while ! ps -ef | grep mysqld | grep -v grep > /dev/null
# mysqld & while !(mysqladmin  ping  &> /dev/null)

# while [ ! -e /var/run/mysqld/mysqld.pid ]
# while [[ -z $(mysqladmin -uroot status 2>/dev/null) ]]
# do
#     echo "Waiting for database..."
#     sleep 1
# done
#     echo "Database is ready"

#DEBUG 
set -x

mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO\`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"


mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown
exec mysqld

#debug
set +x