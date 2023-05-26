
FROM 	debian:buster

#general
RUN		apt update && apt upgrade -y 

#wordpress
RUN		apt-get -y install wget
RUN 	wget https://fr.wordpress.org/wordpress-6.2-fr_FR.tar.gz -P /var/www
RUN 	cd /var/www && tar -xzf wordpress-6.2-fr_FR.tar.gz && rm wordpress-6.2-fr_FR.tar.gz
RUN		chown -R root:root /var/www/wordpress

#php
RUN 	apt install -y php\
			php-fpm\
			php-mysql\
			mariadb-client