FROM 	alpine:3.17.1


#general
RUN		apk update && apk upgrade && \
                apk add --no-cache nginx openssl

#DEBUG
#RUN   apt install vim -y
#RUN   apt install curl -y 
#RUN   apt-get install -y net-tools

#securite		
RUN 	mkdir -p /etc/nginx/ssl && \
	    openssl req -x509 -days 365 -nodes -out /etc/nginx/ssl/inception.crt \
            -keyout /etc/nginx/ssl/inception.key \
            -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=agouet.42.fr/UID=agouet"

#NGINX
RUN     adduser -D -H -g 'www' www && \
        mkdir -p /var/run/nginx

COPY	conf/nginx.conf /etc/nginx/nginx.conf

#1er plan pour que le conteneur ne s'arrete pas
CMD ["nginx", "-g", "daemon off;" ]



