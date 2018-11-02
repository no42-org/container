#!/bin/bash -e

# shellcheck disable=SC2034

# Dependencies
JDK_VERSION="1.8.0.191.b12-b1"
JDK_BASE_IMAGE="no42org/openjdk:${JDK_VERSION}"
BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")"

# Horizon RPM repository config and version
LOCAL_RPMS="false"
REPO_HOST="yum.opennms.org"
REPO_RELEASE="stable"
VERSION="23.0.0"
BUILD_NUMBER="b2"
IMAGE_VERSION="${VERSION}-${BUILD_NUMBER}"

REPO_RPM_URL="https://${REPO_HOST}/repofiles/opennms-repo-${REPO_RELEASE}-rhel7.noarch.rpm"
REPO_KEY_URL="https://${REPO_HOST}/OPENNMS-GPG-KEY"
REPO_URL="https://${REPO_HOST}/${REPO_RELEASE}/common/opennms"

# Container registry and tags
CONTAINER_PROJECT="$(basename "$(pwd)")"
CONTAINER_REGISTRY="docker.io"
CONTAINER_REGISTRY_REPO="no42org"
CONTAINER_VERSION_TAGS=("${IMAGE_VERSION}"
                        "latest")

# Container image artifact
CONTAINER_IMAGE="images/image.oci"

# System Package dependencies
PACKAGES="wget
          gettext"

# Packages
OPENNMS_PACKAGES="opennms-minion-${VERSION}-1.noarch.rpm"

# Run as user
USER="minion"
GROUP="minion"
