#!/bin/bash -e

# shellcheck disable=SC2034

MAJOR_VERSION="1.8.0"
VERSION="${MAJOR_VERSION}.191.b12"

# Container registry and tags
CONTAINER_PROJECT="$(basename "$(pwd)")"
CONTAINER_REGISTRY="docker.io"
CONTAINER_REGISTRY_REPO="no42org"
CONTAINER_VERSION_TAGS=("${VERSION}" "latest")

# Container Image Artifact
CONTAINER_IMAGE="images/image.oci"
