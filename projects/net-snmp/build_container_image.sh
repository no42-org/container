#!/bin/bash -e

set -x

# shellcheck source=projects/net-snmp/config.sh
source ./config.sh

docker build -t "${CONTAINER_PROJECT}" \
  --build-arg CENTOS_BASE_IMAGE="${CENTOS_BASE_IMAGE}" \
  --build-arg VERSION="${VERSION}" \
  --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%S%z")" \
  .

docker image save "${CONTAINER_PROJECT}:latest" -o "${CONTAINER_IMAGE}"
