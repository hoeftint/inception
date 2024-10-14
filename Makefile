
run:
	docker compose -f srcs/docker-compose.yaml up -d

down:
	docker compose -f srcs/docker-compose.yaml down

.PHONY: run