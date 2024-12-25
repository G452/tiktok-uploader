ACTIVE_PROFILE = prod

OS = Linux
VERSION = 0.0.1
MODULE = tiktok-uploader
TAG ?= $(shell git log -1 --pretty=format:"%h")
IMG ?= gabby/${MODULE}:${TAG}

docker-build:
	docker build --platform linux/amd64 -t ${IMG} --build-arg ACTIVE_PROFILE=${ACTIVE_PROFILE} .

docker-push:
	docker push ${IMG}

docker-clean:
	docker rmi ${IMG}

docker: docker-build docker-push

build:
	docker-compose -p ${MODULE} up -d --build --remove-orphans
up:
	docker-compose -p ${MODULE} up -d --remove-orphans
ps:
	docker-compose -p ${MODULE} ps
stop:
	docker-compose -p ${MODULE} stop
restart:
	docker-compose -p ${MODULE} restart
rm:
	docker-compose -p ${MODULE} rm -f
reload: stop up
rebuild: stop build
clean: stop rm
