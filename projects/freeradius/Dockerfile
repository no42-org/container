ARG BASE_IMAGE="alpine"
ARG BASE_IMAGE_VERSION="latest"

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION}

RUN apk add --no-cache freeradius=3.0.23-r0 \
                       freeradius-sqlite=3.0.23-r0 \
                       freeradius-radclient=3.0.23-r0 \
                       freeradius-rest=3.0.23-r0 \
                       sqlite=3.35.5-r0 \
                       openssl-dev=1.1.1k-r0 && \
    chgrp radius /usr/sbin/radiusd && \
    chmod g+rwx /usr/sbin/radiusd

ARG BUILD_DATE="1970-01-01T00:00:00+0000"
ARG VERSION
ARG SOURCE
ARG REVISION
ARG BUILD_JOB_ID
ARG BUILD_NUMBER
ARG BUILD_URL
ARG BUILD_BRANCH

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.title="FreeRADIUS" \
      org.opencontainers.image.source="${SOURCE}" \
      org.opencontainers.image.revision="${REVISION}" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.vendor="No42" \
      org.opencontainers.image.authors="Ronny Trommer" \
      org.opencontainers.image.licenses="GNU General Public License 3" \
      org.opennms.image.base="${BASE_IMAGE}:${BASE_IMAGE_VERSION}" \
      org.opennme.cicd.jobid="${BUILD_JOB_ID}" \
      org.opennms.cicd.buildnumber="${BUILD_NUMBER}" \
      org.opennms.cicd.buildurl="${BUILD_URL}" \
      org.opennms.cicd.branch="${BUILD_BRANCH}"

VOLUME [ "/opt/db", "/etc/freeradius/certs" ]

EXPOSE 1812/udp 1813/udp 18120/tcp

ENTRYPOINT [ "/usr/sbin/radiusd" ]

CMD [ "--help" ]
