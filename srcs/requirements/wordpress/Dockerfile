
FROM 	debian:buster

#general
#1 couche
RUN		apt update && apt upgrade -y && \
		apt-get -y install wget && \
		apt-get install -y php\
						php-fpm\
						php-mysql\
						mariadb-client 

#DEBUG_listen
# RUN     apt-get install -y net-tools

#wordpress
RUN 	wget https://fr.wordpress.org/wordpress-6.2-fr_FR.tar.gz -P /var/www
RUN 	cd /var/www && tar -xzf wordpress-6.2-fr_FR.tar.gz && rm wordpress-6.2-fr_FR.tar.gz
RUN		chown -R root:root /var/www/wordpress

#CLI
RUN 	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN 	chmod +x wp-cli.phar
RUN		mv wp-cli.phar /usr/local/bin/wp-cli.phar
					
#php
COPY	conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf


COPY  	tools/init_wordpress.sh init_wordpress.sh
RUN 	chmod 755 init_wordpress.sh  
CMD ["/bin/bash", "/init_wordpress.sh"]
