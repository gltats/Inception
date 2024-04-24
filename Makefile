# Makefile

# Variables
DOCKER_COMPOSE = @docker compose
LOCATION =  -f ./srcs/docker-compose.yaml

# Rules
all: build

build:
	@echo "Building all the containers"
	$(DOCKER_COMPOSE) $(LOCATION) build

up:
	$(DOCKER_COMPOSE) $(LOCATION) up -d

down:
	$(DOCKER_COMPOSE) $(LOCATION) down

reload:
	$(DOCKER_COMPOSE) $(LOCATION) down
	$(DOCKER_COMPOSE) $(LOCATION) up -d

start:
	$(DOCKER_COMPOSE) $(LOCATION) start

stop:
	@echo "Stopping all the containers"
	$(DOCKER_COMPOSE) $(LOCATION) down --rmi local

clean:
	@echo "Cleaning up the docker"
	@docker system prune -a
	rm -rf ~/data/mysql/*

fclean:
	@echo "Pruning all the docker data"
	@docker system prune --all --force --volumes
	rm -rf ~/data/mysql/*

re:	stop all
	@echo "Restarted all the containers"

.PHONY: all up start down stop clean fclean build re