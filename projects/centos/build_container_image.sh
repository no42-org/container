#!/bin/bash -e

set -x

# shellcheck source=projects/horizon/config.sh
source ./config.sh

docker build -t "${CONTAINER_PROJECT}" \
  --build-arg MAJOR_VERSION="${MAJOR_VERSION}" \
  --build-arg VERSION="${VERSION}" \
  --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")" \
  .

docker image save "${CONTAINER_PROJECT}:latest" -o "${CONTAINER_IMAGE}"
