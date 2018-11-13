ARG CENTOS_BASE_IMAGE=centos:7

FROM ${CENTOS_BASE_IMAGE}

ARG VERSION="5.7.2"
ARG BUILD_DATE="1970-01-01T00:00:00"

RUN yum install -y net-snmp-${VERSION} net-snmp-utils-${VERSION} && \
    mkdir -p /etc/snmp/conf.d

COPY config/snmpd.conf /etc/snmp/snmpd.conf
COPY config/conf.d/* /etc/snmp/conf.d/

LABEL maintainer "Ronny Trommer <ronny@opennms.org>" \
      license="AGPLv3" \
      name="Net-SNMP" \
      version="${VERSION}" \
      build.date="${BUILD_DATE}" \
      vendor="OpenNMS Community"

ENTRYPOINT [ "/usr/sbin/snmpd" ]

CMD [ "-f", "-LS0-6d", "-c", "/etc/snmp/snmpd.conf" ]

### Runtime information and not relevant at build time

EXPOSE 161/udp
