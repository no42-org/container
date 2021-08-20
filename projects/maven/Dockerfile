ARG BASE_IMAGE="ubuntu"
ARG BASE_IMAGE_VERSION="focal"

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION}

ARG MAVEN_VERSION="3.8.2"

ARG MAVEN_HOST="https://mirror.informatik.hs-fulda.de"
ARG MAVEN_URL="${MAVEN_HOST}//dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"
ARG MAVEN_HOME="/opt/apache-maven-${MAVEN_VERSION}"

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${MAVEN_HOME}/bin

WORKDIR /opt

RUN apt-get update && apt-get -y install --no-install-recommends curl gzip && \
    apt-get clean && \
    curl ${MAVEN_URL} | tar xz && \
    rm -rf /var/lib/apt/lists/* 

ARG BUILD_DATE="1970-01-01T00:00:00+0000"
ARG VERSION
ARG SOURCE
ARG REVISION
ARG BUILD_JOB_ID
ARG BUILD_NUMBER
ARG BUILD_URL
ARG BUILD_BRANCH

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.title="Apache Maven ${MAVEN_VERSION}" \
      org.opencontainers.image.source="${SOURCE}" \
      org.opencontainers.image.revision="${REVISION}" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.vendor="No42" \
      org.opencontainers.image.authors="Ronny Trommer" \
      org.opencontainers.image.licenses="GNU General Public License 3" \
      org.opennms.image.base="${BASE_IMAGE}:${BASE_IMAGE_VERSION}" \
      org.opennme.cicd.jobid="${BUILD_JOB_ID}" \
      org.opennms.cicd.buildnumber="${BUILD_NUMBER}" \
      org.opennms.cicd.buildurl="${BUILD_URL}" \
      org.opennms.cicd.branch="${BUILD_BRANCH}"
