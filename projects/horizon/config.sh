#!/bin/bash -e

# shellcheck disable=SC2034

# Base Image Dependency
BASE_IMAGE="no42org/openjdk"
BASE_IMAGE_VERSION="11.0.2.7-cb.792"
BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")"

# Horizon RPM repository config and version
VERSION="24.0.0-rc"

# Floating tags
IMAGE_VERSION=("${VERSION}")

# Most specific tag when it is not build locally and in CircleCI
if [ -n "${CIRCLE_BUILD_NUM}" ]; then
  IMAGE_VERSION+=("${VERSION}-cb.${CIRCLE_BUILD_NUM}")
fi

REPO_HOST="yum.opennms.org"
REPO_RELEASE="branches-release-24.0.0"
REPO_RPM="https://${REPO_HOST}/repofiles/opennms-repo-${REPO_RELEASE}-rhel7.noarch.rpm"
REPO_KEY_URL="https://${REPO_HOST}/OPENNMS-GPG-KEY"

# System Package dependencies
PACKAGES="wget
          gettext"

# OpenNMS Horizon dependencies
PACKAGES="${PACKAGES}
          rrdtool
          https://yum.opennms.org/stable/rhel7/jicmp/jicmp-2.0.3-1.el7.centos.x86_64.rpm
          https://yum.opennms.org/stable/rhel7/jicmp6/jicmp6-2.0.2-1.el7.centos.x86_64.rpm
          jrrd2
          R-core"

#
# If you want to install packages from the official repository, add your packages here.
# By default the build system will build the RPMS in the ./rpms directory and install from here.
#
# Suggested packages to install OpenNMS Horizon packages from repository
#
ONMS_PACKAGES="opennms-core
               opennms-webapp-jetty
               opennms-webapp-hawtio
               opennms-webapp-remoting
               opennms-plugin-protocol-cifs
               opennms-plugin-protocol-radius"

