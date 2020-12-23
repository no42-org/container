include ../../_Makefile/defaults.mk
include ../../_Makefile/common-targets.mk

DOCKER_ORG=labmonkeys
GOBGP_VERSION=$(shell cat version.txt)
BASE_IMAGE=centos
BASE_IMAGE_VERSION=8

build:
	docker build $(DOCKER_BUILD_FLAGS) \
		--build-arg BASE_IMAGE=$(BASE_IMAGE) \
		--build-arg BASE_IMAGE_VERSION=$(BASE_IMAGE_VERSION) \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--build-arg VERSION=$(VERSION) \
		--build-arg GOBGP_VERSION=$(GOBGP_VERSION) \
		--build-arg SOURCE=$(VCS_URL) \
		--build-arg REVISION=$(VCS_REF) \
		--build-arg BUILD_JOB_ID=$(CIRCLE_WORKFLOW_JOB_ID) \
		--build-arg BUILD_NUMBER=$(CIRCLE_BUILD_NUM) \
		--build-arg BUILD_URL=$(CIRCLE_BUILD_URL) \
		--build-arg BUILD_BRANCH=$(CIRCLE_BRANCH) \
		-t $(DOCKER_PROJECT) .
