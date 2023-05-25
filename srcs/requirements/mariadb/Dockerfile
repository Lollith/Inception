FROM 	debian:buster

#general
RUN		apt update && apt upgrade -y 
# RUN	    apt install vim -y
# RUN		apt install curl -y

#mariadb
RUN 	apt install mariadb-server -y
COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# CMD 	service mysql start;

