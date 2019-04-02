#!/bin/bash -e

# shellcheck source=projects/sentinel/config.sh
source ./config.sh

# shellcheck source=projects/registry-config.sh
source ../registry-config.sh

docker build -t "${CONTAINER_PROJECT}:${IMAGE_VERSION[0]}" \
  --build-arg BUILD_DATE="${BUILD_DATE}" \
  --build-arg BASE_IMAGE="${BASE_IMAGE}" \
  --build-arg BASE_IMAGE_VERSION="${BASE_IMAGE_VERSION}" \
  --build-arg REPO_HOST="${REPO_HOST}" \
  --build-arg REPO_RELEASE="${REPO_RELEASE}" \
  --build-arg REPO_RPM="${REPO_RPM}" \
  --build-arg REPO_KEY_URL="${REPO_KEY_URL}" \
  --build-arg VERSION="${VERSION}" \
  --build-arg PACKAGES="${PACKAGES}" \
  --build-arg SENTINEL_PACKAGES="${SENTINEL_PACKAGES}" \
  .

docker image save "${CONTAINER_PROJECT}:${IMAGE_VERSION[0]}" -o "${CONTAINER_IMAGE}"
