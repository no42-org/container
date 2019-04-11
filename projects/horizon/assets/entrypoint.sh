#!/bin/bash -e
# =====================================================================
# Build script running OpenNMS in Docker environment
#
# Source: https://github.com/opennms-forge/docker-horizon-core-web
# Web: https://www.opennms.org
#
# =====================================================================

# Cause false/positives
# shellcheck disable=SC2086

OPENNMS_HOME="/opt/opennms"
OPENNMS_OVERLAY="/opt/opennms-overlay"
JAVA_HOME="/usr/lib/jvm/java-11"

# Error codes
E_ILLEGAL_ARGS=126
E_INIT_CONFIG=127

# Help function used in error messages and -h option
usage() {
  echo ""
  echo "Docker entry script for OpenNMS service container"
  echo ""
  echo "Overlay Config file:"
  echo "If you want to overwrite the default configuration with your custom config, you can use an overlay"
  echo "folder in which needs to be mounted to ${OPENNMS_OVERLAY}."
  echo "Every file in this folder is overwriting files in ${OPENNMS_HOME}."
  echo ""
  echo "-f: Start OpenNMS in foreground with an existing configuration."
  echo "-h: Show this help."
  echo "-i: Initialize or update the database and OpenNMS configuration files. OpenNMS will be *NOT* started"
  echo "-t: options: Run the config-tester, default is -h to show usage."
  echo ""
}

install() {
  ${JAVA_HOME}/bin/java -Dopennms.home="${OPENNMS_HOME}" -Dlog4j.configurationFile="${OPENNMS_HOME}"/etc/log4j2-tools.xml -cp "${OPENNMS_HOME}/lib/opennms_bootstrap.jar" org.opennms.bootstrap.InstallerBootstrap "${@}" || exit ${E_INIT_CONFIG}
}

configTester() {
  ${JAVA_HOME}/bin/java -Dopennms.manager.class="org.opennms.netmgt.config.tester.ConfigTester" -Dopennms.home="${OPENNMS_HOME}" -Dlog4j.configurationFile="$OPENNMS_HOME"/etc/log4j2-tools.xml -jar $OPENNMS_HOME/lib/opennms_bootstrap.jar "${@}" || exit ${E_INIT_CONFIG}
}

processConfdTemplates() {
  echo "Processing confd templates from ..."
  confd -onetime -backend "${CONFD_BACKEND}"
}

# Initialize database and configure Karaf
initOrUpgrade() {
  if [ ! -d ${OPENNMS_HOME} ]; then
    echo "OpenNMS home directory doesn't exist in ${OPENNMS_HOME}."
    exit ${E_ILLEGAL_ARGS}
  fi

  if [ ! "$(ls --ignore .git --ignore .gitignore --ignore ${OPENNMS_DATASOURCES_CFG} --ignore ${OPENNMS_KARAF_CFG} -A ${OPENNMS_HOME}/etc)"  ]; then
    echo "No existing configuration in ${OPENNMS_HOME}/etc found. Initialize from etc-pristine."
    cp -r ${OPENNMS_HOME}/share/etc-pristine/* ${OPENNMS_HOME}/etc/ || exit ${E_INIT_CONFIG}
  fi
  processConfdTemplates
  echo "Initialize database and Karaf configuration and do install or upgrade the database schema."
  install "-dis"
}

applyOverlayConfig() {
  # Overlay relative to the root of the install dir
  if [ -d "${OPENNMS_OVERLAY}" ] && [ -n "$(ls -A ${OPENNMS_OVERLAY})" ]; then
    echo "Apply custom configuration from ${OPENNMS_OVERLAY}."
    cp -r ${OPENNMS_OVERLAY}/* ${OPENNMS_HOME}/ || exit ${E_INIT_CONFIG}
  else
    echo "No custom config found in ${OPENNMS_OVERLAY}. Use default configuration."
  fi
}

# Start opennms in foreground
start() {
  local OPENNMS_JAVA_OPTS="--add-modules=java.base,java.compiler,java.datatransfer,java.desktop,java.instrument,java.logging,java.management,java.management.rmi,java.naming,java.prefs,java.rmi,java.scripting,java.security.jgss,java.security.sasl,java.sql,java.sql.rowset,java.xml,jdk.attach,jdk.httpserver,jdk.jdi,jdk.sctp,jdk.security.auth,jdk.xml.dom \
  -Dorg.apache.jasper.compiler.disablejsr199=true
  -Dopennms.home=/opt/opennms
  -XX:+HeapDumpOnOutOfMemoryError
  -Dcom.sun.management.jmxremote.authenticate=true
  -Dcom.sun.management.jmxremote.login.config=opennms
  -Dcom.sun.management.jmxremote.access.file=/opt/opennms/etc/jmxremote.access
  -DisThreadContextMapInheritable=true
  -Dgroovy.use.classvalue=true
  -Djava.io.tmpdir=/opt/opennms/data/tmp
  -XX:+StartAttachListener"
  exec ${JAVA_HOME}/bin/java ${OPENNMS_JAVA_OPTS} ${JAVA_MEM_OPTS} ${JAVA_OPTS} -jar /opt/opennms/lib/opennms_bootstrap.jar start
}

testConfig() {
  if [ -n "${OPENNMS_DBNAME}" ]; then
    echo "WARNING: The OPENNMS_DBNAME is deprecated use OPENNMS_DATABASE_NAME instead."
    export OPENNMS_DATABASE_NAME=${OPENNMS_DBNAME}
  fi

  if [ -n "${OPENNMS_DBUSER}" ]; then
    echo "WARNING: The OPENNMS_DBUSER is deprecated use OPENNMS_DATABASE_USER instead."
    export OPENNMS_DATABASE_USER=${OPENNMS_DBUSER}
  fi

  if [ -n "${OPENNMS_DBPASS}" ]; then
    echo "WARNING: The OPENNMS_DBPASS is deprecated use OPENNMS_DATABASE_PASSWORD instead."
    export OPENNMS_DATABASE_PASSWORD=${OPENNMS_DBPASS}
  fi

  shift
  if [ "${#}" == "0" ]; then
    configTester -h
  else
    configTester "${@}"
  fi
}

# Evaluate arguments for build script.
if [[ "${#}" == 0 ]]; then
  usage
  exit ${E_ILLEGAL_ARGS}
fi

# Evaluate arguments for build script.
while getopts "fhit" flag; do
  case ${flag} in
    f)
      applyOverlayConfig
      processConfdTemplates
      testConfig -t -a
      start
      exit
      ;;
    h)
      usage
      exit
      ;;
    i)
      initOrUpgrade
      applyOverlayConfig
      testConfig -t -a
      exit
      ;;
    t)
      processConfdTemplates
      applyOverlayConfig
      testConfig "${@}"
      exit
      ;;
    *)
      usage
      exit ${E_ILLEGAL_ARGS}
      ;;
  esac
done

# Strip of all remaining arguments
shift $((OPTIND - 1));

# Check if there are remaining arguments
if [[ "${#}" -gt 0 ]]; then
  echo "Error: To many arguments: ${*}."
  usage
  exit ${E_ILLEGAL_ARGS}
fi
