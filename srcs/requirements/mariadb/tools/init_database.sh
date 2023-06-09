#!/bin/bash

# le service MySQL doit etre correctement démarré avant d'exécuter les commandes MySQL. 
# sinon erreurs de mdp =>health sur dockercompose.yml

#DEBUG// a supprimer pour securiser - a utiliser avec service mysql start
# set -x


mysqld & # et non: 
# service mysql start

mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO\`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown

exec mysqld


#debug
# set +x

# docker build srcs/requirements/mariadb/ -t maria
#docker run -it --rm --env-file srcs/.env maria /bin/bash

