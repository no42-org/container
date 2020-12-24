
ARG BASE_IMAGE="alpine"
ARG BASE_IMAGE_VERSION="3.12"

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION}

ARG MURMUR_VERSION="1.3.3"
ARG MURMUR_URL="https://github.com/mumble-voip/mumble/releases/download/${MURMUR_VERSION}/murmur-static_x86-${MURMUR_VERSION}.tar.bz2"

RUN mkdir -p /opt/murmur && \
    mkdir /data && \
    addgroup -g 1000 murmur && \
    adduser -Ss /bin/false -u 1000 -G murmur -h /opt/murmur murmur && \
    chown 1000:1000 /opt/murmur /data

WORKDIR /opt/murmur

USER 1000

RUN wget ${MURMUR_URL} && \
    tar xjf murmur-static_*.tar.bz2 --strip-components 1 && \
    rm *.tar.bz2

ARG BUILD_DATE="1970-01-01T00:00:00+0000"
ARG SOURCE
ARG REVISION
ARG BUILD_JOB_ID
ARG BUILD_NUMBER
ARG BUILD_URL
ARG BUILD_BRANCH

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.title="Mumble Murmur Server ${MURMUR_VERSION}" \
      org.opencontainers.image.source="${SOURCE}" \
      org.opencontainers.image.revision="${REVISION}" \
      org.opencontainers.image.version="${MURMUR_VERSION}" \
      org.opencontainers.image.vendor="No42" \
      org.opencontainers.image.authors="Ronny Trommer" \
      org.opencontainers.image.licenses="AGPLv3" \
      org.opennms.image.base="${BASE_IMAGE}:${BASE_IMAGE_VERSION}" \
      org.opennme.cicd.jobid="${BUILD_JOB_ID}" \
      org.opennms.cicd.buildnumber="${BUILD_NUMBER}" \
      org.opennms.cicd.buildurl="${BUILD_URL}" \
      org.opennms.cicd.branch="${BUILD_BRANCH}"

ENTRYPOINT [ "/opt/murmur/murmur.x86" ]

CMD [ "-h" ]

EXPOSE 64738/tcp 64738/udp

VOLUME [ "/data" ]
