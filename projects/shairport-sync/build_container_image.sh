#!/bin/bash -e

set -x

# shellcheck source=projects/sentinel/config.sh
source ./config.sh

docker build -t "${CONTAINER_PROJECT}:${IMAGE_VERSION}" \
  --build-arg BASE_IMAGE="${BASE_IMAGE}" \
  --build-arg BASE_IMAGE_VERSION="${BASE_IMAGE_VERSION}" \
  --build-arg VERSION="${VERSION}" \
  --build-arg BUILD_DATE="${BUILD_DATE}" \
  --build-arg SHAIRPORT_SYNC_URL="${SHAIRPORT_SYNC_URL}" \
  --build-arg SHAIRPORT_GIT_REF="${SHAIRPORT_GIT_REF}" \
  .

docker image save "${CONTAINER_PROJECT}:${IMAGE_VERSION}" -o "${CONTAINER_IMAGE}"
