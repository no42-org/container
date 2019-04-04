#!/bin/bash -e

# shellcheck disable=SC2034

# Configure base image dependency
BASE_IMAGE="centos"
BASE_IMAGE_VERSION="7.6.1810"
BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")"
VERSION="7.6.1810"

# Floating tags
IMAGE_VERSION=("${VERSION}")

# Most specific tag when it is not build locally and in CircleCI
if [ -n "${CIRCLE_BUILD_NUM}" ]; then
  IMAGE_VERSION+=("${VERSION}-cb.${CIRCLE_BUILD_NUM}")
fi
