FROM 		debian:buster

#general
RUN			apt-get update && apt upgrade -y 

#mariadb
RUN 		apt-get install -y mariadb-server -y && \
            apt-get install -y mariadb-client

COPY		conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY		tools/init_database.sh init_database.sh 
RUN 		chmod 755 init_database.sh

ENTRYPOINT 	["bash", "/init_database.sh"]

#debug
EXPOSE 3306 