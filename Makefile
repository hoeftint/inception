
run:
	docker compose -f ./srcs/docker-compose.yaml up -d

down:
	docker compose -f ./srcs/docker-compose.yaml down

rm_network:
	docker network prune -f

rm_container:
	docker container prune -f

rm_image:
	docker image prune -f

rm_system:
	docker system prune -af

clean: down rm_image rm_container rm_network rm_system

.PHONY: run down