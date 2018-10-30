#!/bin/bash -e

set -x

# shellcheck source=projects/horizon/config.sh
source ./config.sh

docker build -t "${CONTAINER_PROJECT}" \
  --build-arg JDK_BASE_IMAGE="${JDK_BASE_IMAGE}" \
  --build-arg PACKAGES="${PACKAGES}" \
  --build-arg VERSION="${VERSION}" \
  --build-arg REPO_RELEASE="${REPO_RELEASE}" \
  --build-arg MIRROR_HOST="${MIRROR_HOST}" \
  --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")" \
  .

docker image save "${CONTAINER_PROJECT}:latest" -o "${CONTAINER_IMAGE}"
