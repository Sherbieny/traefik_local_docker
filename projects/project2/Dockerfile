FROM php:7.4-fpm

# Set environment variables to force using port 9001 for php7.4-fpm
RUN sed -i "s|listen = 9000|listen = 9001|g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i 's/9000/9001/' /usr/local/etc/php-fpm.d/zz-docker.conf



# Install system dependencies and required PHP extensions
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    apt-transport-https \
    apt-utils \
    build-essential \
    curl \
    debconf-utils \
    gcc \
    git \
    vim \
    gnupg2 \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libpq-dev \
    libzip-dev \
    locales \
    ssl-cert \
    unzip \
    zlib1g-dev \
    net-tools \
    inkscape \
    imagemagick \
    openssh-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install -j$(nproc) zip gd mysqli pdo_mysql opcache intl pgsql pdo_pgsql \
    && pecl install apcu \
    && echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini \
    && pecl install xdebug-3.1.6 \
    && docker-php-ext-enable xdebug 

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer \
    && composer self-update --1 # Downgrade Composer to version 1

# Install sudo
RUN apt-get update \
    && apt-get install --no-install-recommends -y sudo \
    && echo "www-data ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the default shell for www-data to bash
RUN chsh -s /bin/bash www-data

# Copy .bashrc from ../../global-configs/.bashrc to /var/www/.bashrc
COPY ../../global-configs/.bashrc /var/www/.bashrc

# set the .bashrc file to www-data user
RUN chown www-data:www-data /var/www/.bashrc

# Source the .bashrc file
RUN echo "source /var/www/.bashrc" >> /var/www/.bash_profile

# Set ownership and permissions for /var/www
RUN chown www-data:www-data /var/www \
    && chmod 750 /var/www

# Set permissions for /tmp
RUN chmod -R 777 /tmp

# Set working directory
WORKDIR /var/www/html
