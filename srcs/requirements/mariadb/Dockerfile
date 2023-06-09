FROM 		debian:buster

#general
RUN			apt-get update && apt upgrade -y 

#mariadb
RUN 		apt-get install -y mariadb-server -y && \
            apt-get install -y mariadb-client

# RUN chown -R mysql:mysql /var/lib/mysql

#setup launch mysqld
RUN         mkdir -p /run/mysqld
RUN         chown -R mysql:mysql /run/mysqld

COPY		conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY		tools/init_database.sh init_database.sh 
RUN 		chmod 755 init_database.sh

CMD 	["/bin/bash", "/init_database.sh"]

EXPOSE 3306 
#debug