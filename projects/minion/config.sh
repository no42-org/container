#!/bin/bash -e

# shellcheck disable=SC2034

# Base Image Dependency
BASE_IMAGE="opennms/openjdk"
BASE_IMAGE_VERSION="1.8.0.191.b12-b3"
BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")"

# Horizon RPM repository config and version
VERSION="24.0.0-rc"
BUILD_NUMBER="b1"
IMAGE_VERSION=("${VERSION}-${BUILD_NUMBER}"
               "${VERSION}") 

REPO_HOST="yum.opennms.org"
REPO_RELEASE="branches-release-24.0.0"
REPO_RPM="https://${REPO_HOST}/repofiles/opennms-repo-${REPO_RELEASE}-rhel7.noarch.rpm"
REPO_KEY_URL="https://${REPO_HOST}/OPENNMS-GPG-KEY"

# System Package dependencies
PACKAGES="wget
          gettext
          https://yum.opennms.org/stable/rhel7/jicmp/jicmp-2.0.3-1.el7.centos.x86_64.rpm
          https://yum.opennms.org/stable/rhel7/jicmp6/jicmp6-2.0.2-1.el7.centos.x86_64.rpm"

#
# If you want to install packages from the official repository, add your packages here.
# By default the build system will build the RPMS in the ./rpms directory and install from here.
#
# Suggested packages to install OpenNMS Minion packages from repository
MINION_PACKAGES="opennms-minion-container
                 opennms-minion-features-core
                 opennms-minion-features-default"

# Run as user
USER="minion"
GROUP="minion"
