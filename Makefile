DOCKER_COMPOSE = docker compose
ENV_FILE = --env-file srcs/.env
COMPOSE = -f ./srcs/docker-compose.yml
COMPOSE_CMD = ${DOCKER_COMPOSE} ${COMPOSE} ${ENV_FILE}

all:
	mkdir -p /home/${USER}/data/wordpress_db
	mkdir -p /home/${USER}/data/mariadb_db
	@${COMPOSE_CMD} build --no-cache

up:
	@${COMPOSE_CMD} up || true

run: all up

down:
	@${COMPOSE_CMD} down

clean: down
	docker system prune -f

fclean:
	@${COMPOSE_CMD} down -v
	docker system prune -f --volumes

fclean-local: fclean
	docker run --rm -v /home/${USER}/data:/parentdir alpine sh -c "rm -rf /parentdir/wordpress_db"
	docker run --rm -v /home/${USER}/data:/parentdir alpine sh -c "rm -rf /parentdir/mariadb_db"

re:	fclean run

.PHONY: all up run down clean fclean re