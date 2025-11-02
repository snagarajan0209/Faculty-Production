# ...existing code...
# Makefile for docker-compose based development / CI tasks

COMPOSE ?= docker compose
DC_FILE ?= docker-compose.yml
PROJECT ?= faculty-production
ENV_FILE ?= .env
SERVICE ?= faculty-backend

.PHONY: up up-detach down build pull restart logs logs-follow ps exec shell clean prune


# Start (foreground)
up:
	$(COMPOSE) -f $(DC_FILE) -p $(PROJECT) up -d

# Start detached
up-detach:
	$(COMPOSE) -f $(DC_FILE) -p $(PROJECT) --env-file $(ENV_FILE) up -d

# Stop and remove
down:
	$(COMPOSE) -f $(DC_FILE) -p $(PROJECT) --env-file $(ENV_FILE) down

# Build images
build:
	$(COMPOSE) -f $(DC_FILE) -p $(PROJECT) --env-file $(ENV_FILE) build --pull --no-cache

# Pull images
pull:
	$(COMPOSE) -f $(DC_FILE) -p $(PROJECT) --env-file $(ENV_FILE) pull

# Restart services
restart:
	$(COMPOSE) -f $(DC_FILE) -p $(PROJECT) --env-file $(ENV_FILE) restart

# Logs
logs:
	$(COMPOSE) -f $(DC_FILE) -p $(PROJECT) --env-file $(ENV_FILE) logs --no-color --tail=200

logs-follow:
	$(COMPOSE) -f $(DC_FILE) -p $(PROJECT) --env-file $(ENV_FILE) logs -f --tail=200

# List containers
ps:
	$(COMPOSE) -f $(DC_FILE) -p $(PROJECT) --env-file $(ENV_FILE) ps

# Exec a shell in the service
exec:
	$(COMPOSE) -f $(DC_FILE) -p $(PROJECT) --env-file $(ENV_FILE) exec $(SERVICE) sh

shell: exec

# Bring down and prune images
clean: down
	@echo "Removing stopped containers and unused images..."
	$(COMPOSE) -f $(DC_FILE) -p $(PROJECT) --env-file $(ENV_FILE) rm -f || true
	docker image prune -f

# Aggressive prune (use with caution)
prune:
	docker system prune -af

# ...existing code...