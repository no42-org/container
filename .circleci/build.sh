#!/bin/bash -e

PROJECT="$(basename "$(pwd)")"

echo "Detect changes in project dir ${PROJECT}"
if git diff --name-only HEAD^...HEAD | grep "^projects/${PROJECT}"; then
  echo "Changes here, run the build"
  if [ "${CIRCLE_BRANCH}" == "master" ]; then
    echo "Publish images for master branch ..."
    make VERSION="$(cat version.txt).${CIRCLE_BUILD_NUM}" push
  else
    echo "Skip publishing for working branches other than master."
    echo "Build images for branches are available in the CircleCI build artifacts."
    make oci
  fi
else
  make VERSION="$(cat version.txt).${CIRCLE_BUILD_NUM}" push
  exit 0
fi
