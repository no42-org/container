#!/bin/bash -e

# shellcheck disable=SC2034

# Base Image Dependency
BASE_IMAGE="opennms/confd"
BASE_IMAGE_VERSION="0.16.0-b1.655"
BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")"

# Specific container config
JDK_MAJOR_VERSION="1.8.0"
JDK_VERSION_DETAIL="${JDK_MAJOR_VERSION}.201.b09"

# Allow a manual build number which allows to overwrite an existing image
BUILD_NUMBER="b4"

# Floating tags
IMAGE_VERSION=("${JDK_VERSION_DETAIL}-${BUILD_NUMBER}"
               "${JDK_VERSION_DETAIL}")

# Most specific tag when it is not build locally and in CircleCI
if [ -n "${CIRCLE_BUILD_NUM}" ]; then
  IMAGE_VERSION+=("${JDK_VERSION_DETAIL}-${BUILD_NUMBER}.${CIRCLE_BUILD_NUM}")
fi
