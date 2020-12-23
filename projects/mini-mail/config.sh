#!/bin/bash -e

# shellcheck disable=SC2034

# Base Image Dependency
BASE_IMAGE="ubuntu"
BASE_IMAGE_VERSION="focal"
S6_OVERLAY_VERSION="v2.1.0.2"

# Version information
VERSION="2.0"
FLOATING_VERSION="latest"
IMAGE_VERSION=("${VERSION}"
               "${FLOATING_VERSION}")
# Most specific tag when itcd is not build locally and in CircleCI
if [ -n "${CIRCLE_BUILD_NUM}" ]; then
  IMAGE_VERSION+=("${VERSION}-b${CIRCLE_BUILD_NUM}")
fi
