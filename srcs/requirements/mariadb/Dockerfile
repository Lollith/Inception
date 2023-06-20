FROM        alpine:3.17.1

#general
RUN			apk update --no-cache  && \
 		    apk add mariadb mariadb-client && \
            mkdir -p /run/mysqld && \
            chown -R mysql:mysql /run/mysqld && \
            chmod 777 /run/mysqld
            #mariadb= server
            #setup launch mysqld, mettre avnt le USER => pas root

COPY		conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY		tools/init_database.sh init_database.sh 
RUN 		chmod 755 init_database.sh

USER    mysql

ENTRYPOINT 	["sh","init_database.sh"]

#debug
# EXPOSE 3306 