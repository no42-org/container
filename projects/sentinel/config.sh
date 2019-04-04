#!/bin/bash -e

# shellcheck disable=SC2034

# Base Image Dependency
BASE_IMAGE="no42org/openjdk"
BASE_IMAGE_VERSION="1.8.0.201.b09-b728"
BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")"

# Sentinel RPM repository config and version
VERSION="24.0.0-rc"

# Floating tags
IMAGE_VERSION=("${VERSION}")

# Most specific tag when it is not build locally and in CircleCI
if [ -n "${CIRCLE_BUILD_NUM}" ]; then
  IMAGE_VERSION+=("${VERSION}-b${CIRCLE_BUILD_NUM}")
fi

REPO_HOST="yum.opennms.org"
REPO_RELEASE="branches-release-24.0.0"
REPO_RPM="https://${REPO_HOST}/repofiles/opennms-repo-${REPO_RELEASE}-rhel7.noarch.rpm"
REPO_KEY_URL="https://${REPO_HOST}/OPENNMS-GPG-KEY"

# System Package dependencies
PACKAGES="wget
          gettext"

#
# If you want to install packages from the official repository, add your packages here.
# By default the build system will build the RPMS in the ./rpms directory and install from here.
#
# Suggested packages to install OpenNMS Minion packages from repository
SENTINEL_PACKAGES="opennms-sentinel"

# Run as user
USER="sentinel"
GROUP="sentinel"
