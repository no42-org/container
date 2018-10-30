#!/bin/bash -e

# shellcheck disable=SC2034

# Configure base image dependency
MAJOR_VERSION="7"
VERSION="${MAJOR_VERSION}.5.1804"
CENTOS_BASE_IMAGE="centos:${VERSION}"

# Container registry and tags
CONTAINER_PROJECT="$(basename "$(pwd)")"
CONTAINER_REGISTRY="docker.io"
CONTAINER_REGISTRY_REPO="no42org"
CONTAINER_VERSION_TAGS=("${VERSION}" "latest")

# Container Image Artifact
CONTAINER_IMAGE="images/image.oci"
