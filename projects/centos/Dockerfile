ARG BASE_IMAGE="centos"
ARG BASE_IMAGE_VERSION="latest"
ARG VERSION=${BASE_IMAGE_VERSION}

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION}

LABEL maintainer "Ronny Trommer <ronny@opennms.org>"

ARG VERSION=${BASE_IMAGE_VERSION}
ARG BUILD_DATE="1970-01-01T00:00:00+0000"

RUN yum-config-manager --enable cr && \
    yum -y --setopt=tsflags=nodocs update && \
    yum clean all && \
    rm -rf /var/cache/yum

LABEL license="AGPLv3" \
      name="CentOS" \
      version="${VERSION}" \
      build.date="${BUILD_DATE}" \
      vendor="OpenNMS Community"
