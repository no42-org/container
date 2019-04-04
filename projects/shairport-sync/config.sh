#!/bin/bash -e

# shellcheck disable=SC2034

# Base Image Dependency
BASE_IMAGE="alpine"
BASE_IMAGE_VERSION="edge"
BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")"

VERSION="3.2d22"

# Floating tags
IMAGE_VERSION=("${VERSION}")

# Most specific tag when it is not build locally and in CircleCI
if [ -n "${CIRCLE_BUILD_NUM}" ]; then
  IMAGE_VERSION+=("${VERSION}-b${CIRCLE_BUILD_NUM}")
fi

SHAIRPORT_SYNC_URL=https://github.com/mikebrady/shairport-sync.git
SHAIRPORT_GIT_REF=master
