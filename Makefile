GREEN=\033[0;32m
RED=\033[0;31m
BLUE=\033[0;34m
END=\033[0m

# Docker Compose command
DOCKER_COMPOSE := docker-compose

# Targets
.PHONY: all up down restart stop build clean fclean bash logs show help

# Start services
all: up

# Start services
up:
	@echo "$(GREEN)Starting docker-compose services...$(END)"
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml up -d

# Stop services and remove containers and networks
down:
	@echo "$(GREEN)Stopping docker-compose services...$(END)"
	@echo "$(GREEN)Remove containers and networksEND)"
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml down

# Restart services
restart:
	@echo "$(GREEN)Restarting docker-compose services...$(END)"
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml restart

# Stop services
stop:
	@echo "$(GREEN)Stopping docker-compose services...$(END)"
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml stop

# Build docker images
build:
	@echo "$(GREEN)Building docker-compose images...$(END)"
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml build

# Stop services and remove containers, networks and volumes
clean:
	@echo "$(GREEN)Stopping docker-compose services...$(END)"
	@echo "$(GREEN)Remove containers, networks and volumes$(END)"
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml down -v

# Stop services and remove containers, networks, volumes and images
fclean:
	@echo "$(GREEN)Stopping docker-compose services...$(END)"
	@echo "$(GREEN)Remove containers, networks, volumes and images$(END)"
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml down -v --rmi all

# Execute bash on specific container
bash:
	@echo "$(GREEN)Executing $(SERVICE) container's bash...$(END)"
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml exec -it $(SERVICE) /bin/bash

# Print logs of specific container
logs:
	@echo "$(GREEN)Printing $(SERVICE) container's logs...$(END)"
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml logs $(SERVICE)

# Show current state of docker-compose
show:
	@echo "$(BLUE)List of containers:$(END)"
	@$(DOCKER_COMPOSE) -f srcs/docker-compose.yml ps -a | tail -n +1
	@echo "$(BLUE)\nList of images:$(END)"
	@$(DOCKER_COMPOSE) -f srcs/docker-compose.yml images | tail -n +1
	@echo "$(BLUE)\nList of volumes:$(END)"
	@docker volume ls | tail -n +1
	@echo "$(BLUE)\nList of networks:$(END)"
	@docker network ls | tail -n +1

# Display help message
help:
	@echo "$(GREEN)Available targets:$(END)"
	@echo "  all		- Start services"
	@echo "  up		- Start services"
	@echo "  down     	- Stop services and Remove containers and networks"
	@echo "  restart  	- Restart services"
	@echo "  stop     	- Stop services"
	@echo "  build    	- Build docker images"
	@echo "  clean    	- Stop services and Remove containers, networks and volumes"
	@echo "  fclean	- Stop services and Remove containers, networks, volumes and images"
	@echo "  bash    	- Execute bash on specific container"
	@echo "  logs    	- Show logs of specific container"
	@echo "  show    	- Show current state of docker-compose"
	@echo "  help    	- Display help message"
