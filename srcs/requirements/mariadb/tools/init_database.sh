#!/bin/sh  #alpine 

# le service MySQL doit etre correctement démarré avant d'exécuter les commandes MySQL. 
# sinon erreurs de mdp =>health sur dockercompose.yml + sleep
# 1 seul daemon par .sh

#DEBUG
set -x

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    #initialise le repertoire de donnee +creer les  tables system #alpine
	mariadb-install-db \
		--user=mysql \
		--datadir=/var/lib/mysql \
		--auth-root-authentication-method=normal
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
	# chown -R root:root /run/mysqld

    #lance mysql pour le config
    mysqld -uroot & #creer un background = process enfant

    # limite maximale de tentatives
    max_attempts=10
    # compteur
    attempt=1
    #attend q mysql soit lance sinon erreur socket
    while !(mysqladmin -uroot --skip-password ping > /dev/null) && [ $attempt -le $max_attempts ]
    do
        echo "Waiting for database..."
        sleep 3
        attempt=$((attempt + 1))
    done

    if [ $attempt -gt $max_attempts ]; then
        echo "Failed to start MySQL. Exiting..."
        #ferme le processus enfant
        mysqladmin -uroot --skip-password shutdown
    else
        echo "Database is up and running."

    fi
        mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
        mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
        mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
        mysql -e "FLUSH PRIVILEGES;"
        mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD');"

        #ferme le processus enfant
        mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown
fi
    #exec remplace le pid1 du .sh , devient nouveau processus principal
    exec mysqld --user=root
#debug
set +x

