ARG CENTOS_BASE_IMAGE=centos:7

FROM ${CENTOS_BASE_IMAGE}

LABEL maintainer "Ronny Trommer <ronny@opennms.org>"

ARG MAJOR_VERSION=7
ARG VERSION="${MAJOR_VERSION}.5.1804"
ARG BUILD_DATE="1970-01-01T00:00:00+0000"

RUN yum-config-manager --enable cr && \
    yum -y --setopt=tsflags=nodocs update && \
    yum clean all && \
    rm -rf /var/cache/yum

LABEL license="AGPLv3" \
      org.centos.version="${VERSION}" \
      org.centos.build.date="${BUILD_DATE}" \
      vendor="OpenNMS Community" \
      name="CentOS"
