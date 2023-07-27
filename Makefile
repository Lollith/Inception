SRC_COMPOSE = ./srcs/docker-compose.yml


all: 	dirs build up

up : 
		docker compose -f $(SRC_COMPOSE) up -d

dirs:
		mkdir -p /home/agouet42/data/mariadb
		mkdir -p /home/agouet42/data/wordpress

build: 
		docker compose -f $(SRC_COMPOSE) build

logs: 
		docker-compose -f $(SRC_COMPOSE) logs -f --tail 20

stop:
		docker compose -f $(SRC_COMPOSE) stop

restart:
		docker compose -f $(SRC_COMPOSE) restart


#detruit la stack
down:
		docker compose -f $(SRC_COMPOSE) down

#img, volumes, dossier du home
clean: down
		sudo docker system prune -af 
		sudo rm -rf /home/agouet42/data/*
		-sudo docker volume rm -f $$(sudo docker volume ls -q)

re: clean
	make all

debug_nginx: 
				docker-compose -f $(SRC_COMPOSE) exec nginx /bin/bash 

debug_wordpress:
				docker-compose -f $(SRC_COMPOSE) exec wordpress /bin/bash 
debug_mariadb:
				docker-compose -f $(SRC_COMPOSE) exec mariadb /bin/bash 

.PHONY: all build up down run clean re stop restart