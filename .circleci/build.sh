#!/bin/bash -e

PROJECT="$(basename "$(pwd)")"

echo "Detect changes in projects"
if git diff --name-only HEAD^...HEAD | grep "^projects/${PROJECT}"; then
  echo "Changes here, run the build"
  ./build_container_image.sh
  ~/my-container/.circleci/tag.sh
  ~/my-container/.circleci/publish.sh
else
  echo "No changes detected"
  exit 0
fi