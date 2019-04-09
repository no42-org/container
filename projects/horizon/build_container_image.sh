#!/bin/bash -e

# shellcheck source=projects/horizon/config.sh
source ./config.sh

# shellcheck source=projects/registry-config.sh
source ../registry-config.sh

docker build -t "${CONTAINER_PROJECT}:${IMAGE_VERSION[0]}" \
  --build-arg BUILD_DATE="${BUILD_DATE}" \
  --build-arg BASE_IMAGE="${BASE_IMAGE}" \
  --build-arg BASE_IMAGE_VERSION="${BASE_IMAGE_VERSION}" \
  --build-arg REPO_RPM="${REPO_RPM}" \
  --build-arg REPO_KEY_URL="${REPO_KEY_URL}" \
  --build-arg VERSION="${VERSION}" \
  --build-arg PACKAGES="${PACKAGES}" \
  --build-arg ONMS_PACKAGES="${ONMS_PACKAGES}" \
  .

docker image save "${CONTAINER_PROJECT}:${IMAGE_VERSION[0]}" -o "${CONTAINER_IMAGE}"
