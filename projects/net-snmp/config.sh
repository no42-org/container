#!/bin/bash -e

# shellcheck disable=SC2034

# Dependencies
CENTOS_VERSION="7.5.1804-b1"
CENTOS_BASE_IMAGE="no42org/centos:${CENTOS_VERSION}"

# Configure base image dependency
VERSION="5.7.2"
BUILD_NUMBER="b1"
IMAGE_VERSION="${VERSION}-${BUILD_NUMBER}"

# Container registry and tags
CONTAINER_PROJECT="$(basename "$(pwd)")"
CONTAINER_REGISTRY="docker.io"
CONTAINER_REGISTRY_REPO="no42org"
CONTAINER_VERSION_TAGS=("${IMAGE_VERSION}"
                        "latest")

# Container Image Artifact
CONTAINER_IMAGE="images/image.oci"
