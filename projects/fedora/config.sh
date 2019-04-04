#!/bin/bash -e

# shellcheck disable=SC2034

# Configure base image dependency
BASE_IMAGE="fedora"
BASE_IMAGE_VERSION="30"
BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")"

# Floating tags
IMAGE_VERSION=("${BASE_IMAGE_VERSION}")

# Most specific tag when it is not build locally and in CircleCI
if [ -n "${CIRCLE_BUILD_NUM}" ]; then
  IMAGE_VERSION+=("${BASE_IMAGE_VERSION}-cb.${CIRCLE_BUILD_NUM}")
fi
