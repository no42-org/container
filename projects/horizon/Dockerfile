ARG JDK_BASE_IMAGE=opennms/openjdk:latest

FROM ${JDK_BASE_IMAGE}

LABEL maintainer "Ronny Trommer <ronny@opennms.org>"

ARG REPO_RELEASE="stable"
ARG VERSION="stable"
ARG MIRROR_HOST=yum.opennms.org
ARG PACKAGES="gettext iplike iplike rrdtool jrrd2 opennms-core opennms-webapp-jetty opennms-plugin-protocol-cifs opennms-webapp-hawtio"
ARG JICMP_RPM="https://yum.opennms.org/stable/rhel7/jicmp/jicmp-2.0.3-1.el7.centos.x86_64.rpm"
ARG JICMP6_RPM="https://yum.opennms.org/stable/rhel7/jicmp6/jicmp6-2.0.2-1.el7.centos.x86_64.rpm"
ARG BUILD_DATE="1970-01-01T00:00:00+0000"

ENV OPENNMS_KARAF_SSH_HOST 0.0.0.0
ENV OPENNMS_KARAF_SSH_PORT 8101

RUN rpm -Uvh "https://${MIRROR_HOST}/repofiles/opennms-repo-${REPO_RELEASE/\//-}-rhel7.noarch.rpm" && \
    rpm --import "https://${MIRROR_HOST}/OPENNMS-GPG-KEY" && \
    curl "${JICMP_RPM}" -o /tmp/jicmp.rpm && \
    curl "${JICMP6_RPM}" -o /tmp/jicmp6.rpm && \
    yum -y install /tmp/jicmp.rpm && \
    yum -y install /tmp/jicmp6.rpm && \
    yum -y install epel-release && \
    for PKG in ${PACKAGES}; do yum -y install "${PKG}"; done && \
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

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "-h" ]

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
