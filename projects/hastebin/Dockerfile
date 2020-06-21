ARG BASE_IMAGE="node"
ARG BASE_IMAGE_VERSION="lts-alpine"

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION}

RUN apk add --no-cache git

RUN git clone https://github.com/seejohnrun/haste-server.git /app

WORKDIR /app

RUN npm install

ADD ./container-fs/entrypoint.sh ./entrypoint.sh

ARG BUILD_DATE="1970-01-01T00:00:00+0000"
ARG VERSION
ARG SOURCE
ARG REVISION
ARG BUILD_JOB_ID
ARG BUILD_NUMBER
ARG BUILD_URL
ARG BUILD_BRANCH

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.title="Hastebin Server" \
      org.opencontainers.image.source="${SOURCE}" \
      org.opencontainers.image.revision="${REVISION}" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.vendor="No42" \
      org.opencontainers.image.authors="Ronny Trommer" \
      org.opencontainers.image.licenses="MIT" \
      org.opennms.image.base="${BASE_IMAGE}:${BASE_IMAGE_VERSION}" \
      org.opennme.cicd.jobid="${BUILD_JOB_ID}" \
      org.opennms.cicd.buildnumber="${BUILD_NUMBER}" \
      org.opennms.cicd.buildurl="${BUILD_URL}" \
      org.opennms.cicd.branch="${BUILD_BRANCH}"

EXPOSE 7777

ENV STORAGE_TYPE file

ENTRYPOINT [ "./entrypoint.sh" ]
