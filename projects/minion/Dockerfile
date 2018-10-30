ARG JDK_BASE_IMAGE=opennms/openjdk:latest

FROM ${JDK_BASE_IMAGE}

LABEL maintainer "Ronny Trommer <ronny@opennms.org>"

ARG REPO_RELEASE="stable"
ARG VERSION="stable"
ARG MIRROR_HOST="yum.opennms.org"
ARG PACKAGES="opennms-minion"
ARG JICMP_RPM="https://yum.opennms.org/stable/rhel7/jicmp/jicmp-2.0.3-1.el7.centos.x86_64.rpm"
ARG JICMP6_RPM="https://yum.opennms.org/stable/rhel7/jicmp6/jicmp6-2.0.2-1.el7.centos.x86_64.rpm"
ARG BUILD_DATE="1970-01-01T00:00:00"

ENV MINION_HOME /opt/minion
ENV MINION_CONFIG /opt/minion/etc/org.opennms.minion.controller.cfg

ENV MINION_ID 00000000-0000-0000-0000-deadbeef0001
ENV MINION_LOCATION MINION

ENV OPENNMS_BROKER_URL tcp://127.0.0.1:61616
ENV OPENNMS_HTTP_URL http://127.0.0.1:8980/opennms

ENV OPENNMS_HTTP_USER minion
ENV OPENNMS_HTTP_PASS minion
ENV OPENNMS_BROKER_USER minion
ENV OPENNMS_BROKER_PASS minion

RUN rpm -Uvh "https://${MIRROR_HOST}/repofiles/opennms-repo-${REPO_RELEASE}-rhel7.noarch.rpm" && \
    rpm --import "https://${MIRROR_HOST}/OPENNMS-GPG-KEY" && \
    curl "${JICMP_RPM}" -o /tmp/jicmp.rpm && \
    curl "${JICMP6_RPM}" -o /tmp/jicmp6.rpm && \
    yum -y install /tmp/jicmp.rpm && \
    yum -y install /tmp/jicmp6.rpm && \
    for PKG in ${PACKAGES}; do yum -y install "${PKG}"; done && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    rm -rf /tmp && \
    chown minion:minion /opt/minion && \
    sed -r -i '/RUNAS/s/.*/export RUNAS=minion/' /etc/sysconfig/minion

USER minion

COPY ./entrypoint.sh /

VOLUME [ "/opt/minion/etc", "/opt/minion/etc/featuresBoot.d", "/opt/minion/data" ]

LABEL license="AGPLv3" \
      org.opennms.horizon.minion.version="${VERSION}" \
      org.opennms.repo.release="${REPO_RELEASE}" \
      org.opennms.repo.packages.installed="${PACKAGES}" \
      org.opennms.build.date="${BUILD_DATE}" \
      vendor="OpenNMS Community" \
      name="Minion"

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "-h" ]

##------------------------------------------------------------------------------
## EXPOSED PORTS
##------------------------------------------------------------------------------
## -- OpenNMS KARAF SSH   8201/TCP
## -- OpenNMS JMX        18980/TCP
## -- SNMP Trapd           162/UDP
## -- Syslog               514/UDP
EXPOSE 8201 18980 162/udp 514/udp
