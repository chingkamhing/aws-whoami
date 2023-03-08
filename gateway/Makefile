output := gateway

.PHONY: help
help:
	@echo "Usage:"
	@echo "Makefile commands"
	@echo "    build                Build this project locally"
	@echo "    update               Update go modules"
	@echo "    test                 Perform go test"
	@echo "    docker               Build all services docker images"
	@echo "    docker-push          Push docker image to docker hub"
	@echo "    docker-pull          Pull docker image to docker hub"
	@echo "    clean                Clean this project and database docker volume"

TAG ?= latest

#
# Makefile commands
#

.PHONY: build
build:
	go build -o ${output} *.go

.PHONY: update
update:
	go get -u ./... && go mod tidy -go=1.20

.PHONY: test
test:
	@echo No test implemented yet.

.PHONY: docker
docker:
	docker build --tag ${DOCKER_ID}/${output}:${TAG} .

# Push docker image to docker hub
.PHONY: docker-push
docker-push:
	docker push $(DOCKER_ID)/$(output):$(TAG)

# Pull docker image to docker hub
.PHONY: docker-pull
docker-pull:
	docker pull $(DOCKER_ID)/$(output):$(TAG)

.PHONY: clean
clean:
	rm -f ${output}
