/PHONY: up down reload build

COMPOSE_FILES=-f docker-compose.yml

up:
	docker compose ${COMPOSE_FILES} up -d

down:
	docker compose ${COMPOSE_FILES} down

reload:
	make down
	make up

build:
	docker compose ${COMPOSE_FILES} build

logs:
	docker compose ${COMPOSE_FILES_DEV} logs -f $(filter-out $@, $(MAKECMDGOALS))

default:
	up