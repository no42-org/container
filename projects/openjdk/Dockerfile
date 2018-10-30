FROM centos:7

LABEL maintainer "Ronny Trommer <ronny@opennms.org>"

ARG MAJOR_VERSION=1.8.0
ARG VERSION=${MAJOR_VERSION}.191.b12
ENV JAVA_HOME /usr/lib/jvm/java

RUN yum -y install java-${MAJOR_VERSION}-openjdk-devel-${VERSION} && \
    yum -y clean all && \
    rm -rf /var/cache/yum

LABEL org.opennms.java.version="OpenJDK Java Development Kit ${VERSION}"
