SHELL              := /bin/bash -o pipefail
PROJECT_DIR         = $(shell pwd)
CONTAINER_PROJECT   = $(shell basename $(PROJECT_DIR))
BUILD_DATE          = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
DOCKER_BUILD_FLAGS  = 
DOCKER_REGISTRY    := docker.io
DOCKER_ORG         := labmonkeys
DOCKER_PROJECT      = $(CONTAINER_PROJECT)
VCS_URL            := $(CIRCLE_REPOSITORY_URL)
VCS_REF            := $(shell git describe --always)
VERSION            := latest
DOCKER_TAG          = $(DOCKER_REGISTRY)/$(DOCKER_ORG)/$(DOCKER_PROJECT):$(VERSION)
