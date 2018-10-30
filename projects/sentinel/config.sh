#!/bin/bash -e

# shellcheck disable=SC2034

# Dependencies
JDK_VERSION="1.8.0.191.b12"
JDK_BASE_IMAGE="no42org/openjdk:${JDK_VERSION}"

# Configure container specifics
MIRROR_HOST="yum.opennms.org"
REPO_RELEASE="stable"
VERSION="23.0.0"

# Packages
PACKAGES="opennms-sentinel"

# Container registry and tags
CONTAINER_PROJECT="$(basename "$(pwd)")"
CONTAINER_REGISTRY="docker.io"
CONTAINER_REGISTRY_REPO="no42org"
CONTAINER_VERSION_TAGS=("${VERSION}" "latest")

# Container Image Artifact
CONTAINER_IMAGE="images/image.oci"
