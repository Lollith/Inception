
FROM 	debian:buster

#general
RUN		apt update && apt upgrade -y 

#wordpress
RUN		apt-get -y install wget
RUN 	wget https://fr.wordpress.org/wordpress-6.2-fr_FR.tar.gz -P /var/www
RUN 	cd /var/www && tar -xzf wordpress-6.2-fr_FR.tar.gz && rm wordpress-6.2-fr_FR.tar.gz
RUN		chown -R root:root /var/www/wordpress

#CLI
RUN 	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN 	chmod +x wp-cli.phar
RUN		mv wp-cli.phar /usr/local/bin/wp-cli.phar
					
#php
RUN 	apt install -y php\
			php-fpm\
			php-mysql\
			mariadb-client
COPY	conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

#DEBUG_listen
# RUN     apt-get install -y net-tools

COPY  	tools/init_wordpress.sh init_wordpress.sh
RUN 	chmod 755 init_wordpress.sh  
ENTRYPOINT ["/init_wordpress.sh"]

# Create the folder to enable php start
# RUN 	mkdir /run/php

# #We go the html directory
# WORKDIR /var/www/html/

# EXPOSE 9000

#Launch PHP FPM in foreground and ignore deamonize from conf file (-F)
# CMD ["/usr/sbin/php-fpm7.3", "-F"]