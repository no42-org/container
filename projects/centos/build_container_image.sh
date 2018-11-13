#!/bin/bash -e

set -x

# shellcheck source=projects/centos/config.sh
source ./config.sh

docker build -t "${CONTAINER_PROJECT}" \
  --build-arg VERSION="${CENTOS_VERSION}" \
  --build-arg CENTOS_BASE_IMAGE="${CENTOS_BASE_IMAGE}" \
  --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")" \
  .

docker image save "${CONTAINER_PROJECT}:latest" -o "${CONTAINER_IMAGE}"
