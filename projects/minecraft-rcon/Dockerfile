ARG BASE_IMAGE="ubuntu"
ARG BASE_IMAGE_VERSION="focal"

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION}

ARG MCRCON_VERSION="0.7.1"

RUN apt-get update && \
    apt-get -y install wget && \
    wget "https://github.com/Tiiffi/mcrcon/releases/download/v${MCRCON_VERSION}/mcrcon-${MCRCON_VERSION}-linux-x86-64.tar.gz" && \
    tar xzf mcrcon-*.tar.gz --strip-components 1 && \
    mv mcrcon /usr/local/bin && \
    rm *.tar.gz && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/usr/local/bin/mcrcon" ]

CMD [ "-h" ]

