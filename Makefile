PROJECT_NAME=test-container
DOCKERFILE_DIR ?= ./images
REGISTRY ?= quay.io
REGISTRY_ORGANIZATION ?= strimzi-test-container
IMAGE_TAG ?= main
DOCKER_VERSION_ARG ?= latest
ARCHS ?= amd64

all: prepare docker_build docker_tag_push clean

docker_build:
	./images/build_push_images.sh $(DOCKER_VERSION_ARG) $(PROJECT_NAME) $(DOCKERFILE_DIR) "$(ARCHS)"

docker_tag_push:
	./images/tag_push_images.sh $(PROJECT_NAME) $(REGISTRY) $(REGISTRY_ORGANIZATION) $(QUAY_USER) $(QUAY_PASS) "$(ARCHS)"

prepare: clean
	./images/download_kafka.sh

clean:
	rm -rf images/kafka_binaries
	rm -rf images/kafka_tars