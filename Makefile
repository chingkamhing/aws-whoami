output := whoami

.PHONY: help
help:
	@echo "Usage:"
	@echo "Makefile commands"
	@echo "    build                Build this project locally"
	@echo "    test                 Perform go test"
	@echo "    clean                Clean this project and database docker volume"
	@echo "Docker commands"
	@echo "    docker               Build all services docker images"
	@echo "    docker-push          Push docker image to docker hub"
	@echo "    docker-pull          Pull docker image to docker hub"
	@echo "    docker-up            docker-compose up"
	@echo "    docker-down          docker-compose down"

#
# Makefile commands
#

.PHONY: build
build:
	make -C gateway build
	make -C whoami build

.PHONY: test
test:
	make -C gateway test
	make -C whoami test

.PHONY: clean
clean:
	make -C gateway clean
	make -C whoami clean

#
# Docker commands
#

.PHONY: docker
docker:
	docker compose -f docker-compose.yml build

# push docker image to docker hub
.PHONY: docker-push
docker-push:
	docker compose -f docker-compose.yml push

# pull docker image to docker hub
.PHONY: docker-pull
docker-pull:
	docker compose -f docker-compose.yml pull

# docker-compose up
.PHONY: docker-up
docker-up:
	docker compose -f docker-compose.yml up

# docker-compose down
.PHONY: docker-down
docker-down:
	docker compose -f docker-compose.yml down
