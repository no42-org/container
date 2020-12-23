ARG BASE_IMAGE="alpine"
ARG BASE_IMAGE_VERSION="latest"

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION}

ARG NETSNMP_VERSION="5.7.3-r11"
ARG BUILD_DATE="1970-01-01T00:00:00+0000"

RUN apk --no-cache add net-snmp>${NETSNMP_VERSION} && \
    mkdir -p /etc/snmp/conf.d

COPY config/snmpd.conf /etc/snmp/snmpd.conf
COPY config/conf.d/* /etc/snmp/conf.d/

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.title="Net-SNMP ${NETSNMP_VERSION}" \
      org.opencontainers.image.source="${SOURCE}" \
      org.opencontainers.image.revision="${REVISION}" \
      org.opencontainers.image.version="${NETSNMP_VERSION}" \
      org.opencontainers.image.vendor="No42" \
      org.opencontainers.image.authors="Ronny Trommer" \
      org.opencontainers.image.licenses="MIT" \
      org.opennms.image.base="${BASE_IMAGE}:${BASE_IMAGE_VERSION}" \
      org.opennme.cicd.jobid="${BUILD_JOB_ID}" \
      org.opennms.cicd.buildnumber="${BUILD_NUMBER}" \
      org.opennms.cicd.buildurl="${BUILD_URL}" \
      org.opennms.cicd.branch="${BUILD_BRANCH}"

ENTRYPOINT [ "/usr/sbin/snmpd" ]

CMD [ "-f", "-Le", "-LS0-6d", "-c", "/etc/snmp/snmpd.conf" ]

### Runtime information and not relevant at build time

EXPOSE 161/udp
