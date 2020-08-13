ARG BASE_IMAGE="ubuntu"
ARG BASE_IMAGE_VERSION="focal"

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION}

RUN apt-get update && \
    apt-get -y install inotify-tools \
               git-core \
               rsync && \
    rm -rf /var/lib/apt/lists/*

ADD ./container-fs/entrypoint.sh /entrypoint.sh

VOLUME [ "/opt/opennms/etc", "/opt/opennms-overlay" ]

ENTRYPOINT [ "/entrypoint.sh" ]
