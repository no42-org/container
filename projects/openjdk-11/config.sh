#!/bin/bash -e

# shellcheck disable=SC2034

# Overwrite project name on DockerHub
CONTAINER_PROJECT="openjdk"

# Base Image Dependency
BASE_IMAGE="no42org/confd"
BASE_IMAGE_VERSION="0.16.0-b713"
BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")"

# Specific container config
JDK_MAJOR_VERSION="11"
JDK_VERSION_DETAIL="${JDK_MAJOR_VERSION}.0.2.7"
IMAGE_VERSION=("${JDK_VERSION_DETAIL}"
               "${JDK_MAJOR_VERSION}")

# Most specific tag when it is not build locally and in CircleCI
if [ -n "${CIRCLE_BUILD_NUM}" ]; then
  IMAGE_VERSION+=("${JDK_VERSION_DETAIL}-cb.${CIRCLE_BUILD_NUM}")
fi
