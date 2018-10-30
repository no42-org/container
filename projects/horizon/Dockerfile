ARG JDK_BASE_IMAGE="opennms/openjdk:latest"

FROM ${JDK_BASE_IMAGE}

LABEL maintainer "Ronny Trommer <ronny@opennms.org>"

#
# Required docker build parameters
#
ARG BUILD_DATE="1970-01-01T00:00:00+0000"
ARG LOCAL_RPMS="false"

ARG VERSION="23.0.0"
ARG REPO_RELEASE="stable"
ARG REPO_HOST="yum.opennms.org"

ARG REPO_URL="https://${REPO_HOST}/${REPO_RELEASE}/common/opennms"
ARG REPO_RPM_URL="https://${REPO_HOST}/repofiles/opennms-repo-${REPO_RELEASE}-rhel7.noarch.rpm"
ARG REPO_KEY_URL="https://${REPO_HOST}/OPENNMS-GPG-KEY"

ARG PACKAGES="wget gettext"
ARG OPENNMS_PACKAGES="opennms-core-${VERSION}-1.noarch.rpm opennms-webapp-jetty-${VERSION}-1.noarch.rpm"

ENV OPENNMS_KARAF_SSH_HOST 0.0.0.0
ENV OPENNMS_KARAF_SSH_PORT 8101

COPY ./rpms /tmp/rpms
COPY ./config.sh /tmp/config.sh

SHELL ["/bin/bash", "-c"]

# Install repositories, system and OpenNMS packages and do some cleanup
RUN yum -y install epel-release && \
    yum -y install "${REPO_RPM_URL}" && \
    rpm --import "${REPO_KEY_URL}" && \
    yum -y install ${PACKAGES} && \
    if [ "${LOCAL_RPMS}" == "false" ]; then for OPENNMS_PKG in ${OPENNMS_PACKAGES}; do wget -q --no-clobber "${REPO_URL}/${OPENNMS_PKG}" -P /tmp/rpms; done fi && \
    cd /tmp/rpms && yum -y localinstall *.rpm && cd - && \
    rm -rf /tmp/rpms && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    rm -rf /opt/opennms/logs \
           /var/opennms/rrd \
           /var/opennms/reports && \
    mkdir -p /opennms-data/logs \
             /opennms-data/rrd \
             /opennms-data/reports && \
    ln -s /opennms-data/logs /opt/opennms/logs && \
    ln -s /opennms-data/rrd /var/opennms/rrd && \
    ln -s /opennms-data/reports /var/opennms/reports

COPY ./assets/opennms-datasources.xml.tpl /root
COPY ./assets/org.apache.karaf.shell.cfg.tpl /root
COPY ./assets/newts.properties.tpl /root

COPY ./entrypoint.sh /

## Volumes for storing data outside of the container
VOLUME [ "/opt/opennms/etc", "/opt/opennms-etc-overlay", "/opennms-data" ]

LABEL license="AGPLv3" \
      org.opennms.repo.release="${REPO_RELEASE}" \
      org.opennms.horizon.version="${VERSION}" \
      org.opennms.build.date="${BUILD_DATE}" \
      vendor="OpenNMS Community" \
      name="Horizon"

WORKDIR /opt/opennms

# ENTRYPOINT [ "/entrypoint.sh" ]

# CMD [ "-h" ]

##------------------------------------------------------------------------------
## EXPOSED PORTS
##------------------------------------------------------------------------------
## -- OpenNMS HTTP        8980/TCP
## -- OpenNMS JMX        18980/TCP
## -- OpenNMS KARAF RMI   1099/TCP
## -- OpenNMS KARAF SSH   8101/TCP
## -- OpenNMS MQ         61616/TCP
## -- OpenNMS Eventd      5817/TCP
## -- SNMP Trapd           162/UDP
## -- Syslog Receiver      514/UDP
EXPOSE 8980 18980 1099 8101 61616 5817 162/udp 514/udp
