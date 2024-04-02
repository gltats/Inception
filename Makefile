# Makefile

# Variables
DOCKER_COMPOSE = docker-compose
LOCATION =  -f ./srcs/docker-compose.yml

# Rules
all: up

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
	$(DOCKER_COMPOSE) $(LOCATION) stop

re: down
	$(DOCKER_COMPOSE) $(LOCATION) up --build

.PHONY: up down reload