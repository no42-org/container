ARG JDK_BASE_IMAGE="opennms/openjdk:latest"

FROM ${JDK_BASE_IMAGE}

ARG BUILD_DATE="1970-01-01T00:00:00+0000"
ARG LOCAL_RPMS="false"

ARG VERSION="23.0.0"
ARG REPO_RELEASE="stable"
ARG REPO_HOST="yum.opennms.org"

ARG REPO_URL="https://${REPO_HOST}/${REPO_RELEASE}/common/opennms"
ARG REPO_RPM_URL="https://${REPO_HOST}/repofiles/opennms-repo-${REPO_RELEASE}-rhel7.noarch.rpm"
ARG REPO_KEY_URL="https://${REPO_HOST}/OPENNMS-GPG-KEY"

ARG PACKAGES="gettext wget"

# This can be unset if LOCAL_RPMS is set to "true"
ARG OPENNMS_PACKAGES="opennms-minion-${VERSION}-1.noarch.rpm"

COPY ./rpms /tmp/rpms

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
    chown minion:minion /opt/minion && \
    sed -r -i '/RUNAS/s/.*/export RUNAS=minion/' /etc/sysconfig/minion

USER minion

COPY ./entrypoint.sh /

VOLUME [ "/opt/minion/etc", "/opt/minion/etc/featuresBoot.d", "/opt/minion/data" ]

LABEL maintainer "Ronny Trommer <ronny@opennms.org>" \
      license="AGPLv3" \
      org.opennms.horizon.minion.version="${VERSION}" \
      org.opennms.repo.release="${REPO_RELEASE}" \
      org.opennms.repo.packages.installed="${PACKAGES}" \
      org.opennms.build.date="${BUILD_DATE}" \
      vendor="OpenNMS Community" \
      name="Minion"

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "-h" ]

### Runtime information and not relevant at build time

ENV MINION_ID 00000000-0000-0000-0000-deadbeef0001
ENV MINION_LOCATION MINION

ENV OPENNMS_BROKER_URL tcp://127.0.0.1:61616
ENV OPENNMS_HTTP_URL http://127.0.0.1:8980/opennms

ENV OPENNMS_HTTP_USER minion
ENV OPENNMS_HTTP_PASS minion
ENV OPENNMS_BROKER_USER minion
ENV OPENNMS_BROKER_PASS minion

##------------------------------------------------------------------------------
## EXPOSED PORTS
##------------------------------------------------------------------------------
## -- OpenNMS KARAF SSH   8201/TCP
## -- OpenNMS JMX        18980/TCP
## -- SNMP Trapd           162/UDP
## -- Syslog               514/UDP
EXPOSE 8201 18980 162/udp 514/udp
