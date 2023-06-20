#!/bin/sh

# le service MySQL doit etre correctement démarré avant d'exécuter les commandes MySQL. 
# sinon erreurs de mdp =>health sur dockercompose.yml + sleep
# 1 seul daemon par .sh

#DEBUG// a supprimer pour securiser 
set -x



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

    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO\`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

    #ferme le processus enfant
    mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown

    #exec remplace le pid1 du .sh , devient nouveau processus principal
    exec mysqld
fi

#debug
set +x

