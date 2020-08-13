# Common targets for all Docker builds

help:
	@echo ""
	@echo "Makefile to build Docker container images, tag them and push them to a registry. The following targets can be used:"
	@echo ""
	@echo "  help:  Show this help and is the default goal"
	@echo "  tag:   Tag an existing image with a registry, organisation name and project name"
	@echo "  oci:   Create an OCI image file in images/image.oci"
	@echo "  push:  Push a tagged image to a registry, default tag: $(DOCKER_TAG)"
	@echo "  clean: Clean all that is actively used"
	@echo "  all:   Run tasks to build the container image, tag it, save it as OCI file to disk and push it to a registry."
	@echo "  build: Just build the container image and tag it with the projects folder name"
	@echo ""
	@echo "Arguments to modify the build:"
	@echo ""
	@echo "  BASE_IMAGE:         The base image to build this container image, default: $(BASE_IMAGE)"
	@echo "  BASE_IMAGE_VERSION: The version of the base image to build this project, default: $(BASE_IMAGE_VERSION)"
	@echo "  DOCKER_BUILD_FLAGS: Flags for the docker build command, .e.g. DOCKER_BUILD_FLAGS=--no-cache to force rebuild."
	@echo "  DOCKER_REGISTRY:    Registry to push the image to, default is set to docker.io"
	@echo "  DOCKER_ORG:         Organisation where the image should pushed in the registry, default is set to opennms."
	@echo "  DOCKER_PROJECT:     Name of the project in the registry, the default is set to the folder name."
	@echo ""
	@echo "Example:"
	@echo ""
	@echo "  make tag DOCKER_REGISTRY=myregistry.com DOCKER_ORG=myorg DOCKER_BUILD_FLAGS=--no-cache"
	@echo ""

build:
	docker build $(DOCKER_BUILD_FLAGS) \
		--build-arg BASE_IMAGE=$(BASE_IMAGE) \
		--build-arg BASE_IMAGE_VERSION=$(BASE_IMAGE_VERSION) \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--build-arg VERSION=$(VERSION) \
		--build-arg SOURCE=$(VCS_URL) \
		--build-arg REVISION=$(VCS_REF) \
		--build-arg BUILD_JOB_ID=$(CIRCLE_WORKFLOW_JOB_ID) \
		--build-arg BUILD_NUMBER=$(CIRCLE_BUILD_NUM) \
		--build-arg BUILD_URL=$(CIRCLE_BUILD_URL) \
		--build-arg BUILD_BRANCH=$(CIRCLE_BRANCH) \
		-t $(DOCKER_PROJECT) .

tag: build
	docker tag $(DOCKER_PROJECT) $(DOCKER_TAG)

oci: tag
	mkdir -p images
	docker image save $(CONTAINER_PROJECT) -o images/image.oci

push: oci
	docker push $(DOCKER_TAG)

clean:
	docker system prune -af

all: push

.PHONY: help tag oci push clean all

.DEFAULT_GOAL := tag
