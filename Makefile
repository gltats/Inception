# Makefile

# Variables
DOCKER_COMPOSE = @docker compose
LOCATION =  -f ./srcs/docker-compose.yaml

# Rules
all: build

build:
	@echo "Building all the containers"
	$(DOCKER_COMPOSE) $(LOCATION) build

nginx:
	@echo "Building nginx container"
	$(DOCKER_COMPOSE) $(LOCATION) build nginx

mariadb:
	@echo "Building mariadb container"
	$(DOCKER_COMPOSE) $(LOCATION) build mariadb

wordpress:
	@echo "Building wordpress container"
	$(DOCKER_COMPOSE) $(LOCATION) build wordpress

up:
	@echo "Starting all the containers"
	$(DOCKER_COMPOSE) $(LOCATION) up -d

up-nginx:
	@echo "Starting nginx container"
	$(DOCKER_COMPOSE) $(LOCATION) up -d nginx

up-mariadb:
	@echo "Starting mariadb container"
	$(DOCKER_COMPOSE) $(LOCATION) up -d mariadb

up-wordpress:
	@echo "Starting wordpress container"
	$(DOCKER_COMPOSE) $(LOCATION) up -d wordpress

down:
	@echo "Stopping all the containers"
	$(DOCKER_COMPOSE) $(LOCATION) down

reload:
	@echo "Reloading all the containers"
	$(DOCKER_COMPOSE) $(LOCATION) down
	$(DOCKER_COMPOSE) $(LOCATION) up -d

stop:
	@echo "Stopping all the containers"
	$(DOCKER_COMPOSE) $(LOCATION) down --rmi local

logs:
	$(DOCKER_COMPOSE) $(LOCATION) logs -f

clean:
	@echo "Cleaning up the docker"
	@docker system prune -a
	rm -rf ~/data/mysql/*

clean-database:
	@echo "Removing all the databases data"
	rm -rf /Users/gltats/data/mariadb_data/*
	rm -rf /Users/gltats/data/wordpress_data/*
	
fclean: stop clean-database
	@echo "Pruning all the docker data"
	@docker system prune --all --force --volumes
	rm -rf ~/data/mysql/*

re:	stop all
	@echo "Restarted all the containers"

.PHONY: all up start down stop clean clean-database fclean build re nginx mariadb wordpress up-nginx up-mariadb up-wordpress