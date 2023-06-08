FROM 		debian:buster

#general
RUN			apt update && apt upgrade -y 

#mariadb
RUN 		apt install mariadb-server -y
COPY		conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY		tools/init_database.sh init_database.sh 
RUN 		chmod 755 init_database.sh
# HEALTHCHECK --interval=15s --timeout=10s --start-period=20s --retries=3 CMD ["netstat", "-lnutp", "|", "grep", "3306"] || exit 1
CMD 	["/bin/bash", "/init_database.sh"]

# EXPOSE 3306 // mis ds compose // preferer ici?? 