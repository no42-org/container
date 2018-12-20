ARG BASE_IMAGE="alpine"
ARG BASE_IMAGE_VERSION="latest"

FROM ${BASE_IMAGE}:${BASE_IMAGE_VERSION}

ARG BUILD_DATE="1970-01-01T00:00:00+0000"

# Environment variables
ENV APP_NAME My Polr
ENV APP_PROTOCOL https://
ENV DB_PORT 3306
ENV DB_DATABASE polr
ENV DB_USERNAME polr
ENV POLR_BASE 62

ARG VERSION=2.2.0
ARG PACKAGES="tar gettext php7 php7-fpm php7-pdo php7-mysqli php7-json php7-openssl php7-curl php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype php7-mbstring php7-gd php7-xmlwriter php7-tokenizer php7-pdo_mysql php7-memcached nginx supervisor curl"

# Install packages
RUN apk --no-cache add ${PACKAGES}

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/zzz_custom.conf
COPY config/php.ini /etc/php7/conf.d/zzz_custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy start.sh script
COPY start.sh /start.sh

RUN mkdir -p /src && \
    cd /src && \
    curl -L "https://github.com/cydrobolt/polr/archive/${VERSION}.tar.gz" | tar xz && \
    cd "polr-${VERSION}" && \
    curl -sS https://getcomposer.org/installer | php && \
    php composer.phar install --no-dev -o && \
    mkdir -p storage/logs && \
    touch storage/logs/lumen.log && \
    chmod -R go+w storage

WORKDIR "/src/polr-${VERSION}"

# Copy env file and setup values
COPY config/.env_polr .env_polr

# Copy admin seeder
COPY seeders/AdminSeeder.php AdminSeeder_withoutEnv.php

ENTRYPOINT ["/start.sh"]

EXPOSE 80
