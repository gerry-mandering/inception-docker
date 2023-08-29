GREEN=\033[0;32m
RED=\033[0;31m
BLUE=\033[0;34m
END=\033[0m

# Docker Compose command
DOCKER_COMPOSE := docker-compose

# Targets
.PHONY: all up down restart stop build clean fclean bash logs show make-dirs help

# Start services
all: up

# Start services
up: make-dirs
	@echo "$(GREEN)Starting docker-compose services...$(END)"
	@$(DOCKER_COMPOSE) -f srcs/docker-compose.yml up -d | tail -n +1

# Stop services and remove containers and networks
down:
	@echo "$(GREEN)Stopping docker-compose services...$(END)"
	@echo "$(GREEN)Remove containers and networks$(END)"
	@$(DOCKER_COMPOSE) -f srcs/docker-compose.yml down | tail -n +1

# Restart services
restart:
	@echo "$(GREEN)Restarting docker-compose services...$(END)"
	@$(DOCKER_COMPOSE) -f srcs/docker-compose.yml restart | tail -n +1

# Stop services
stop:
	@echo "$(GREEN)Stopping docker-compose services...$(END)"
	@$(DOCKER_COMPOSE) -f srcs/docker-compose.yml stop | tail -n +1

# Build docker images
build:
	@echo "$(GREEN)Building docker-compose images...$(END)"
	@$(DOCKER_COMPOSE) -f srcs/docker-compose.yml build | tail -n +1

# Stop services and remove containers, networks and volumes
clean:
	@echo "$(GREEN)Stopping docker-compose services...$(END)"
	@echo "$(GREEN)Remove containers, networks and volumes$(END)"
	@$(DOCKER_COMPOSE) -f srcs/docker-compose.yml down -v | tail -n +1
	@sudo rm -rf /home/$(USER)/data > /dev/null 2>&1

# Stop services and remove containers, networks, volumes and images
fclean:
	@echo "$(GREEN)Stopping docker-compose services...$(END)"
	@echo "$(GREEN)Remove containers, networks, volumes and images$(END)"
	@$(DOCKER_COMPOSE) -f srcs/docker-compose.yml down -v --rmi all | tail -n +1
	@sudo rm -rf /home/$(USER)/data > /dev/null 2>&1

# Execute bash on specific container
bash:
	@echo "$(GREEN)Executing $(SERVICE) container's bash...$(END)"
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml exec -it $(SERVICE) /bin/bash

# Print logs of specific container
logs:
	@echo "$(GREEN)Printing $(SERVICE) container's logs...$(END)"
	@$(DOCKER_COMPOSE) -f srcs/docker-compose.yml logs $(SERVICE) | tail -n +1

# Show current state of docker
show:
	@echo "$(BLUE)List of containers:$(END)"
	@docker ps -a | tail -n +1
	@echo "$(BLUE)\nList of images:$(END)"
	@docker images | tail -n +1
	@echo "$(BLUE)\nList of volumes:$(END)"
	@docker volume ls | tail -n +1
	@echo "$(BLUE)\nList of networks:$(END)"
	@docker network ls | tail -n +1

# Make directories for volume
make-dirs:
	@mkdir -p /home/$(USER)/data/wordpress_data /home/$(USER)/data/mariadb_data > /dev/null 2>&1

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
	@echo "  show    	- Show current state of docker"
	@echo "  make-dirs    	- Make directories for volume"
	@echo "  help    	- Display help message"
