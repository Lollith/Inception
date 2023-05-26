
FROM 	debian:buster

#general
RUN		apt update && apt upgrade -y 

#wordpress
RUN		apt-get -y install wget
RUN 	wget https://fr.wordpress.org/wordpress-6.2-fr_FR.tar.gz -P /var/www
RUN 	cd /var/www && tar -xzf wordpress-6.2-fr_FR.tar.gz && rm wordpress-6.2-fr_FR.tar.gz
RUN		chown -R root:root /var/www/wordpress
RUN 	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN 	chmod +x wp-cli.phar
RUN		mv wp-cli.phar /usr/local/bin/wp
					
#php
RUN 	apt install -y php\
			php-fpm\
			php-mysql\
			mariadb-client
COPY	conf/www.conf /etc/php/7.2/fpm/pool.d/www.conf

COPY  	tools/init_wordpress.sh init_wordpress.sh
RUN 	chmod 755 init_wordpress.sh  
ENTRYPOINT ["/init_wordpress.sh"]

# EXPOSE 9000