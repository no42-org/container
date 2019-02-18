ARG BASE_IMAGE="centos"
ARG BASE_IMAGE_VERSION="latest"
ARG VERSION=${BASE_IMAGE_VERSION}

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION}

ARG VERSION=${BASE_IMAGE_VERSION}
ARG BUILD_DATE="1970-01-01T00:00:00+0000"

RUN dnf --nodocs -y update; \
    dnf clean all

LABEL maintainer="ronny@no42.org" \
      license="AGPLv3" \
      name="Fedora" \
      version="${VERSION}" \
      build.date="${BUILD_DATE}" \
      vendor="no42.org" \
      org.opennms.container.image.os.name="Fedora" \
      org.opennms.container.image.os.version="${VERSION}" \
      org.opennms.container.image.os.build-date="${BUILD_DATE}"
