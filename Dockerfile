FROM php:5.6-fpm

RUN apt-get update && apt-get install -y \
    sudo \
    gnupg2 \
    cron \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/testArena/bin
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/var/www/testArena/bin --filename=composer

RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    libicu-dev \
    libpng-dev \
    libjpeg-dev \
&& docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install -j$(nproc) zip intl exif gd pdo pdo_mysql

COPY ./docker/arena/conf/php.ini /usr/local/etc/php/
COPY ./docker/arena/conf/www.conf /usr/local/etc/php-fpm.d/


COPY ./docker/arena/entrypoint /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint
ENTRYPOINT ["entrypoint"]

WORKDIR /var/www/testArena


COPY composer.json /var/www/testArena/
COPY composer.lock /var/www/testArena/
RUN php -d memory_limit=-1 bin/composer install --no-autoloader


COPY . /var/www/testArena/
