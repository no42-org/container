
ARG BASE_IMAGE="alpine"
ARG BASE_IMAGE_VERSION="3.12"

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION}

ARG MURMUR_VERSION="1.3.2"
ARG MURMUR_URL="https://github.com/mumble-voip/mumble/releases/download/${MURMUR_VERSION}/murmur-static_x86-${MURMUR_VERSION}.tar.bz2"

RUN mkdir -p /opt/murmur && \
    mkdir /data && \
    addgroup -g 1000 murmur && \
    adduser -Ss /bin/false -u 1000 -G murmur -h /opt/murmur murmur && \
    chown 1000:1000 /opt/murmur /data

WORKDIR /opt/murmur

USER 1000

RUN wget ${MURMUR_URL} && \
    tar xjf murmur-static_*.tar.bz2 --strip-components 1 && \
    rm *.tar.bz2

EXPOSE 64738/tcp 64738/udp

VOLUME [ "/data" ]

ENTRYPOINT [ "/opt/murmur/murmur.x86" ]

CMD [ "-h" ]

