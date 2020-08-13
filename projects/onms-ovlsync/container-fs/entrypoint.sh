#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset

# Startup delay for monitoring directories
STARTUP_DELAY="60"

OPENNMS_ETC_DIR="/opt/opennms/etc"

OVERLAY_ETC_DIR="/opt/opennms-overlay/etc"
OVERLAY_ETC_IMPORTS="${OVERLAY_ETC_DIR}/imports"
OVERLAY_ETC_FOREIGN_SOURCES="${OVERLAY_ETC_DIR}/foreign-sources"

# Check if OpenNMS directories exist for monitoring
if [[ ! -d "${OPENNMS_ETC_DIR}" ]]; then
  echo "Couldn't find OpenNMS config directory in ${OPENNMS_ETC_DIR}."
  exit 1
fi

# Ensure the etc, imports and foreign-sources directory exist in overlay
mkdir -p ${OVERLAY_ETC_DIR} ${OVERLAY_ETC_IMPORTS} ${OVERLAY_ETC_FOREIGN_SOURCES}

# Make sure inotifywait and rsync is installed
command -v inotifywait
command -v rsync

# We monitor files from /opt/opennms/etc so we have a relative path for file names
cd ${OPENNMS_ETC_DIR}

# Handle modified and deleted files
# Arg is: "MODIFY ./foreign-sources/test.txt"
action() {
  echo "Notified: ${1}"
  IFS=" " read -r -a FILE <<< "${1}"
  case ${FILE[0]} in
    "MODIFY")
      # We have to strip the ./ for copy, keep running on error
      echo "cp -r ${FILE[1]} ${OVERLAY_ETC_DIR}/${FILE[1]/.\//}"
      cp -r "${FILE[1]}" "${OVERLAY_ETC_DIR}/${FILE[1]/.\//}" || :
      ;;
    "DELETE")
      # Same here strip the ./ for deleting the file in the overlay dir, keep running on error
      echo "rm ${OVERLAY_ETC_DIR}/${FILE[1]/.\//}"
      rm "${OVERLAY_ETC_DIR}/${FILE[1]/.\//}" || :
      ;;
    *)
      echo "No action for ${1}"
      ;;
  esac
}

# function running inotifywait for modify and delete file events. In case files gets created, 
# the MODIFY event is triggered as well.
monitor() {
  echo "Start monitoring directory $(pwd) and sync changes to ${OVERLAY_ETC_DIR}."
  inotifywait -r -m -e modify,delete --format '%e %w%f' "${1}" | while read -r NOTIFIED; do
    action "${NOTIFIED}"
  done
}

# If we run in a side car we need to wait OpenNMS is started.
echo "Delay startup for ${STARTUP_DELAY} seconds."
sleep ${STARTUP_DELAY}
monitor "./" &
