
.PHONY: help
help:
	@echo "Usage:"
	@echo "Makefile commands"
	@echo "    build                Build this project locally"
	@echo "    test                 Perform go test"
	@echo "    clean                Clean this project and database docker volume"
	@echo "Docker commands"
	@echo "    docker               Build all services docker images"
	@echo "    docker-login         Login to docker repository"
	@echo "    docker-push          Push docker image to docker hub"
	@echo "    docker-pull          Pull docker image to docker hub"
	@echo "    docker-up            docker-compose up"
	@echo "    docker-down          docker-compose down"

DIRS ?= gateway whoami
TAG ?= latest
output := whoami

#
# References:
# - https://www.freecodecamp.org/news/build-and-push-docker-images-to-aws-ecr/
#

#
# Makefile commands
#

.PHONY: build
build:
	@for dir in $(DIRS) ; do \
		echo "Building $$dir..." ; \
		make -C $$dir build || exit 1 ; \
	done

.PHONY: test
test:
	@for dir in $(DIRS) ; do \
		echo "Testing $$dir..." ; \
		make -C $$dir test || exit 1 ; \
	done

.PHONY: clean
clean:
	@for dir in $(DIRS) ; do \
		echo "Cleaning $$dir..." ; \
		make -C $$dir clean || exit 1 ; \
	done

#
# Docker commands
#

.PHONY: docker
docker:
	@for dir in $(DIRS); do \
		make -C $$dir docker || exit 1 ; \
	done

# docker login to aws ecr before image can be pushed
.PHONY: docker-login
docker-login:
	aws ecr get-login-password | docker login --username $$DOCKER_USERNAME --password-stdin $$DOCKER_ID

# push docker image to docker hub
.PHONY: docker-push
docker-push:
	@for dir in $(DIRS); do \
		make -C $$dir docker-push || exit 1 ; \
	done

# pull docker image to docker hub
.PHONY: docker-pull
docker-pull:
	@for dir in $(DIRS); do \
		make -C $$dir docker-pull || exit 1 ; \
	done

# docker-compose up
.PHONY: docker-up
docker-up:
	TAG=$(TAG) docker compose -f docker-compose.yml up

# docker-compose down
.PHONY: docker-down
docker-down:
	TAG=$(TAG) docker compose -f docker-compose.yml down
