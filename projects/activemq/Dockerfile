ARG BASE_IMAGE="openjdk"
ARG BASE_IMAGE_VERSION="11-jre-slim-buster"

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION}

ARG ACTIVEMQ_VERSION="5.16.0"
ARG SHA512_VAL="999928176e57b0805e8a53834e7f4eb648baf271a0c60de31ebd95fa63f2b089aa41c2ef7353790835e2e8cc39c4b778f535b38e6dc0c67a79c3c1da335c4a0a"
ARG ACTIVEMQ_HOME="/opt/activemq"

RUN mkdir -p ${ACTIVEMQ_HOME}

WORKDIR ${ACTIVEMQ_HOME}

RUN curl -L "http://www.apache.org/dyn/closer.cgi?filename=/activemq/${ACTIVEMQ_VERSION}/apache-activemq-${ACTIVEMQ_VERSION}-bin.tar.gz&action=download" -o activemq-bin.tar.gz && \
    echo "${SHA512_VAL} *activemq-bin.tar.gz" > activemq-bin.tar.gz.sha512 && \
    sha512sum -c activemq-bin.tar.gz.sha512 && \
    tar xzf activemq-bin.tar.gz --strip-components 1 && \
    useradd -r -M -d ${ACTIVEMQ_HOME} activemq && \
    chown -R activemq:activemq ${ACTIVEMQ_HOME} && \
    chown -h activemq:activemq ${ACTIVEMQ_HOME} && \
    rm activemq-bin.tar.gz activemq-bin.tar.gz.sha512

USER activemq

ARG BUILD_DATE="1970-01-01T00:00:00+0000"
ARG VERSION
ARG SOURCE
ARG REVISION
ARG BUILD_JOB_ID
ARG BUILD_NUMBER
ARG BUILD_URL
ARG BUILD_BRANCH

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.title="ActiveMQ ${ACTIVEMQ_VERSION}" \
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

# MQTT:         1883/tcp
# AMQP:         5672/tcp
# UI:           8161/tcp
# STOMP:        61613/tcp
# WS:           61614/tcp
# ActiveMQ TCP: 61616/tcp
EXPOSE 1883/tcp 5672/tcp 8161/tcp  61613/tcp 61614/tcp 61616/tcp

ENTRYPOINT [ "bin/activemq" ]

CMD [ "console" ]
