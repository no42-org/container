#!/bin/bash -e

set -x

# shellcheck source=projects/tomcat/config.sh
source ./config.sh

docker build -t "${CONTAINER_PROJECT}" \
  --build-arg BASE_IMAGE="${BASE_IMAGE}" \
  --build-arg BASE_IMAGE_VERSION="${BASE_IMAGE_VERSION}" \
  --build-arg BUILD_DATE="${BUILD_DATE}" \
  --build-arg VERSION="${BASE_IMAGE_VERSION}" \
  .

docker image save "${CONTAINER_PROJECT}:latest" -o "${CONTAINER_IMAGE}"
