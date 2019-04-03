#!/bin/bash -e

# shellcheck disable=SC2034

# Base Image Dependency
BASE_IMAGE="alpine"
BASE_IMAGE_VERSION="edge"
BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")"

VERSION="3.2d22"

# Allow a manual build number which allows to overwrite an existing image
BUILD_NUMBER="b1"

# Floating tags
IMAGE_VERSION=("${VERSION}-${BUILD_NUMBER}"
               "${VERSION}")

# Most specific tag when it is not build locally and in CircleCI
if [ -n "${CIRCLE_BUILD_NUM}" ]; then
  IMAGE_VERSION+=("${VERSION}-${BUILD_NUMBER}.${CIRCLE_BUILD_NUM}")
fi

SHAIRPORT_SYNC_URL=https://github.com/mikebrady/shairport-sync.git
SHAIRPORT_GIT_REF=master
