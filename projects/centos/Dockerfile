ARG VERSION="7.5.1804"
ARG CENTOS_BASE_IMAGE=centos:"${VERSION}"

FROM ${CENTOS_BASE_IMAGE}

LABEL maintainer "Ronny Trommer <ronny@opennms.org>"

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
