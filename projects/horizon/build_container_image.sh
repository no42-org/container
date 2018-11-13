#!/bin/bash -e

# shellcheck source=projects/horizon/config.sh
source ./config.sh

docker build -t "${CONTAINER_PROJECT}" \
  --build-arg BASE_IMAGE="${BASE_IMAGE}" \
  --build-arg BASE_IMAGE_VERSION="${BASE_IMAGE_VERSION}" \
  --build-arg LOCAL_RPMS="${LOCAL_RPMS}" \
  --build-arg REPO_RELEASE="${REPO_RELEASE}" \
  --build-arg VERSION="${VERSION}" \
  --build-arg REPO_RPM_URL="${REPO_RPM_URL}" \
  --build-arg REPO_KEY_URL="${REPO_KEY_URL}" \
  --build-arg REPO_URL="${REPO_URL}" \
  --build-arg BUILD_DATE="${BUILD_DATE}" \
  --build-arg PACKAGES="${PACKAGES}" \
  --build-arg OPENNMS_PACKAGES="${OPENNMS_PACKAGES}" \
  .

docker image save "${CONTAINER_PROJECT}:latest" -o "${CONTAINER_IMAGE}"
