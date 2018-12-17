#!/bin/bash

RESULT=$(/opt/minion/bin/client health:check | grep "Everything is awesome")

if [ "${RESULT}" == "0" ]; then
  echo "Healthcheck OK"
  exit 0
else
  echo "Healthcheck FAILED"
  exit 1
fi
