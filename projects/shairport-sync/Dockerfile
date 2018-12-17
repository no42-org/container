ARG BASE_IMAGE="alpine"
ARG BASE_IMAGE_VERSION="edge"

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION}

ARG VERSION=${BASE_IMAGE_VERSION}
ARG BUILD_DATE="1970-01-01T00:00:00+0000"

ARG SHAIRPORT_SYNC_URL=https://github.com/mikebrady/shairport-sync.git
ARG SHAIRPORT_GIT_REF=master

RUN apk --no-cache add git \
                       build-base \
                       autoconf \
                       automake \
                       libtool \
                       alsa-lib-dev \
                       libdaemon-dev \
                       popt-dev \
                       libressl-dev \
                       soxr-dev \
                       avahi-dev \
                       libconfig-dev && \
    cd /root && \
    git clone ${SHAIRPORT_SYNC_URL} && \
    cd shairport-sync && \
    if [ "${SHAIRPORT_GIT_REF}" != "master" ]; then git checkout -b ${SHAIRPORT_GIT_REF} ${SHAIRPORT_GIT_REF}; fi && \
    autoreconf -i -f && \
    ./configure \
        --with-alsa \
        --with-pipe \
        --with-avahi \
        --with-ssl=openssl \
        --with-soxr \
        --with-metadata && \
    make && \
    make install && \
    cd / && \
    apk --purge del git \
                    build-base \
                    autoconf \
                    automake \
                    libtool \
                    alsa-lib-dev \
                    libdaemon-dev \
                    popt-dev \
                    libressl-dev \
                    soxr-dev \
                    avahi-dev \
                    libconfig-dev && \
    apk add dbus \
            alsa-lib \
            libdaemon \
            popt \
            libressl \
            soxr \
            avahi \
            libconfig && \
    rm -rf /etc/ssl \
           /var/cache/apk/* \
           /lib/apk/db/* \
           /root/shairport-sync

COPY start.sh /start

LABEL maintainer "Ronny Trommer <ronny@no42.org>"

ENV AIRPLAY_NAME Docker

ENTRYPOINT [ "/start" ]
