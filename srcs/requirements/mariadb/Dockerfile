FROM        alpine:3.17.1

#general
RUN			apk update --no-cache  && \
 		    apk add mariadb mariadb-client

# COPY		conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY		conf/50-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY		tools/init_database.sh init_database.sh 
RUN 		chmod 755 init_database.sh

RUN         chown -R mysql:mysql /var/lib/mysql && \
            chmod 777 /var/lib/mysql

ENTRYPOINT 	["sh","init_database.sh"]

#debug
# EXPOSE 3306 