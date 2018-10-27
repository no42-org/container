#!/bin/bash -e

# shellcheck disable=SC2034

# Dependencies
JDK_VERSION="8u191-jdk"
JDK_BASE_IMAGE="opennms/openjdk:${JDK_VERSION}"
JICMP_RPM="https://yum.opennms.org/stable/rhel7/jicmp/jicmp-2.0.3-1.el7.centos.x86_64.rpm"
JICMP6_RPM="https://yum.opennms.org/stable/rhel7/jicmp6/jicmp6-2.0.2-1.el7.centos.x86_64.rpm"

# Horizon RPM repository config and version
MIRROR_HOST="yum.opennms.org"
REPO_RELEASE="stable"
VERSION="23.0.0"

# Container registry and tags
CONTAINER_PROJECT="$(basename "$(pwd)")"
CONTAINER_REGISTRY="docker.io"
CONTAINER_REGISTRY_REPO="no42org"
CONTAINER_VERSION_TAGS=("${VERSION}" "latest")

# Container Image Artifact
CONTAINER_IMAGE="images/image.oci"

# Packages
PACKAGES="opennms-minion"
