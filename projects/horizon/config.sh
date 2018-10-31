#!/bin/bash -e

# shellcheck disable=SC2034

# Dependencies
JDK_VERSION="1.8.0.191.b12-b146"
JDK_BASE_IMAGE="no42org/openjdk:${JDK_VERSION}"
BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")"

# Horizon RPM repository config and version
LOCAL_RPMS="false"
REPO_HOST="yum.opennms.org"
REPO_RELEASE="stable"
VERSION="23.0.0"
BUILD_NUMBER="b1"
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

# Container Image Artifact
CONTAINER_IMAGE="images/image.oci"

# System Packages
PACKAGES="wget
          gettext"

# OpenNMS specific dependencies
PACKAGES="${PACKAGES}
          rrdtool
          iplike
          jicmp
          jicmp6
          jrrd2
          R-core"

# OpenNMS Horizon Packages
OPENNMS_PACKAGES="opennms-core-${VERSION}-1.noarch.rpm
                  opennms-webapp-jetty-${VERSION}-1.noarch.rpm
                  opennms-plugin-protocol-cifs-${VERSION}-1.noarch.rpm
                  opennms-webapp-hawtio-${VERSION}-1.noarch.rpm"
