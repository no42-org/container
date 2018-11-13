ARG CENTOS_BASE_IMAGE=centos:7

FROM ${CENTOS_BASE_IMAGE}

LABEL maintainer "Ronny Trommer <ronny@opennms.org>"

ARG MAJOR_VERSION=1.8.0
ARG VERSION=${MAJOR_VERSION}.191.b12
ARG BUILD_DATE="1970-01-01T00:00:00"

ENV JAVA_HOME /usr/lib/jvm/java

RUN yum -y install java-${MAJOR_VERSION}-openjdk-devel-${VERSION} && \
    yum -y clean all && \
    rm -rf /var/cache/yum

LABEL maintainer "Ronny Trommer <ronny@opennms.org>" \
      license="AGPLv3" \
      name="OpenJDK Development Kit" \
      version="${VERSION}" \
      build.date="${BUILD_DATE}" \
      vendor="OpenNMS Community"
