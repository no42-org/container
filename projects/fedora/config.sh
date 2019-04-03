#!/bin/bash -e

# shellcheck disable=SC2034

# Configure base image dependency
BASE_IMAGE="fedora"
BASE_IMAGE_VERSION="30"
BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")"
BUILD_NUMBER="b1"
IMAGE_VERSION="${BASE_IMAGE_VERSION}-${BUILD_NUMBER}"
