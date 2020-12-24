ARG BASE_IMAGE="ubuntu"
ARG BASE_IMAGE_VERSION="focal"

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION}

RUN apt-get update && \
    apt-get -y install bzflag-server && \
    rm -rf /var/lib/apt/lists/*

RUN addgroup --uid 1000 bzflag && \
    adduser --uid 1000 --gid 1000 --no-create-home --disabled-login bzflag

USER 1000

ENTRYPOINT [ "/usr/games/bzfs" ]

CMD [ "--help" ]

ARG BUILD_DATE="1970-01-01T00:00:00+0000"
ARG VERSION
ARG SOURCE
ARG REVISION
ARG BUILD_JOB_ID
ARG BUILD_NUMBER
ARG BUILD_URL
ARG BUILD_BRANCH

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.title="BZFlag Server" \
      org.opencontainers.image.source="${SOURCE}" \
      org.opencontainers.image.revision="${REVISION}" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.vendor="No42" \
      org.opencontainers.image.authors="Ronny Trommer" \
      org.opencontainers.image.licenses="AGPLv3" \
      org.opennms.image.base="${BASE_IMAGE}:${BASE_IMAGE_VERSION}" \
      org.opennme.cicd.jobid="${BUILD_JOB_ID}" \
      org.opennms.cicd.buildnumber="${BUILD_NUMBER}" \
      org.opennms.cicd.buildurl="${BUILD_URL}" \
      org.opennms.cicd.branch="${BUILD_BRANCH}"
