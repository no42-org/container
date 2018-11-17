#!/bin/bash -e

# shellcheck disable=SC2034

# Base Image Dependency
BASE_IMAGE="no42org/oraclejdk"
BASE_IMAGE_VERSION="8u191-b12-b1"
BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")"

# Version information
VERSION="3.6.0"
BUILD_NUMBER="b1"
IMAGE_VERSION="${VERSION}-${BUILD_NUMBER}"

MAVEN_URL="https://mirror.netcologne.de/apache.org/"
MAVEN_PKG="${MAVEN_URL}/maven/maven-3/${VERSION}/binaries/apache-maven-${VERSION}-bin.tar.gz"
MAVEN_HOME="/opt/apache-maven-${VERSION}"

# Container registry and tags
CONTAINER_PROJECT="$(basename "$(pwd)")"
CONTAINER_REGISTRY="docker.io"
CONTAINER_REGISTRY_REPO="no42org"
CONTAINER_VERSION_TAGS=("${IMAGE_VERSION}"
                        "latest")

# Container Image Artifact
CONTAINER_IMAGE="images/image.oci"
