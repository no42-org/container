ARG BASE_IMAGE="centos"
ARG BASE_IMAGE_VERSION="latest"
ARG VERSION=${BASE_IMAGE_VERSION}

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION}

ARG VERSION=${BASE_IMAGE_VERSION}
ARG BUILD_DATE="1970-01-01T00:00:00+0000"

ARG CONFD_URL="https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64"

RUN yum-config-manager --enable cr && \
    yum -y --setopt=tsflags=nodocs update && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    curl -L ${CONFD_URL} -o /usr/bin/confd && \
    chmod +x /usr/bin/confd

LABEL maintainer="ronny@no42.org" \
      license="AGPLv3" \
      name="CentOS" \
      version="${VERSION}" \
      build.date="${BUILD_DATE}" \
      vendor="no42.org" \
      org.opennms.container.image.os.name="CentOS" \
      org.opennms.container.image.os.version="${VERSION}" \
      org.opennms.container.image.os.build-date="${BUILD_DATE}"
