FROM 		debian:buster

#general
RUN			apt update && apt upgrade -y 
# RUN	    apt install vim -y
# RUN		apt install curl -y

#mariadb
RUN 		apt install mariadb-server -y
COPY		conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# COPY	data/myscriptsql.sql /var/lib/mysql 
COPY		tools/init_database.sh init_database.sh 
RUN 		chmod 755 init_database.sh
ENTRYPOINT 	["/init_database.sh"]
# => volumes
# ENTRYPOINT 	["/bin/bash", "/var/lib/mysql/entrypoint.sh"]
# RUN 	service mysql start;
# CMD 		["/var/lib/mysql/myscriptsql.sql"] 
# = volume creer par docker compose

# EXPOSE 3306