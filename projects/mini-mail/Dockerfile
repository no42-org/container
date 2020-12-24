ARG BASE_IMAGE="ubuntu"
ARG BASE_IMAGE_VERSION="latest"

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION} AS s6-overlay

ARG S6_OVERLAY_VERSION="v2.1.0.2"

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND="noninteractive"

# Set some defaults for Postfix mail server
ENV MAILDOMAIN="example.org"
ENV MESSAGE_SIZE_LIMIT="52428800"

ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer /

# Install package here for cache
RUN apt-get update && \
    apt-get -y install --no-install-recommends inetutils-syslogd \
                                               postfix \
                                               dovecot-common \
                                               dovecot-imapd \
                                               whois && \
    mv /etc/dovecot/conf.d /etc/dovecot/conf.d-example && \
    rm -rf /var/lib/apt/lists/*

COPY container-fs/etc/s6/services /etc/s6/services
COPY container-fs/etc/cont-init.d /etc/cont-init.d
COPY container-fs/etc/syslog.conf /etc/syslog.conf
COPY --chown=root:dovecot container-fs/etc/dovecot/conf.d /etc/dovecot/conf.d

ARG BUILD_DATE="1970-01-01T00:00:00+0000"
ARG SOURCE
ARG REVISION
ARG BUILD_JOB_ID
ARG BUILD_NUMBER
ARG BUILD_URL
ARG BUILD_BRANCH

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.title="Net-SNMP ${NETSNMP_VERSION}" \
      org.opencontainers.image.source="${SOURCE}" \
      org.opencontainers.image.revision="${REVISION}" \
      org.opencontainers.image.version="${NETSNMP_VERSION}" \
      org.opencontainers.image.vendor="No42" \
      org.opencontainers.image.authors="Ronny Trommer" \
      org.opencontainers.image.licenses="AGPLv3" \
      org.opennms.image.base="${BASE_IMAGE}:${BASE_IMAGE_VERSION}" \
      org.opennme.cicd.jobid="${BUILD_JOB_ID}" \
      org.opennms.cicd.buildnumber="${BUILD_NUMBER}" \
      org.opennms.cicd.buildurl="${BUILD_URL}" \
      org.opennms.cicd.branch="${BUILD_BRANCH}"

ENTRYPOINT ["/init"]

CMD ["/usr/lib/postfix/sbin/master", "-d"]

VOLUME ["/var/mail","/home"]

EXPOSE 25 143
