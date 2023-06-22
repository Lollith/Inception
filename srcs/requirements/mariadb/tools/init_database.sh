#!/bin/sh  #alpine 

# le service MySQL doit etre correctement démarré avant d'exécuter les commandes MySQL. 
# sinon erreurs de mdp =>health sur dockercompose.yml + sleep
# 1 seul daemon par .sh

#DEBUG// a supprimer pour securiser 
set -x
# /etc/init.d/mariadb setup



#lance mysql pour le config
mysqld & #creer un background = process enfant

# limite maximale de tentatives
max_attempts=10
# compteur
attempt=1
#attend q mysql soit lance sinon erreur socket
while !(mysqladmin ping > /dev/null) && [ $attempt -le $max_attempts ]
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
    #TODO
    # mysql_secure_installation #alpine 
    # echo -e "y\n $MYSQL_ROOT_PASSWORD \n $MYSQL_ROOT_PASSWORD \ny\ny\ny\ny" | mysql_secure_installation
    # mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO\`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"

    #TODO
    mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD');"

    #ferme le processus enfant
    mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown

    #exec remplace le pid1 du .sh , devient nouveau processus principal
    exec mysqld
fi
#debug
set +x

