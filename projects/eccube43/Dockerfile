FROM php:8.3-fpm

# Install system dependencies
RUN apt update && apt upgrade -y \
    && apt install --no-install-recommends -y \
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
    libzip-dev \
    locales \
    ssl-cert \
    unzip \
    zlib1g-dev \
    libwebp-dev \
    net-tools \
    inkscape \
    imagemagick \
    openssh-client \
    && apt upgrade -y ca-certificates \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo "en_US.UTF-8 UTF-8" >/etc/locale.gen \
    && locale-gen

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) zip gd mysqli pdo_mysql opcache intl \
    && pecl install apcu \
    && echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini


# Install Xdebug (latest version compatible with PHP 8.3)
RUN pecl install xdebug && docker-php-ext-enable xdebug


# Install Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer


# Install Node.js 20 and npm for vscode prettier
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g prettier

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

# Source the .bashrc file
RUN echo "source /var/www/.bashrc" >> /var/www/.bash_profile

# Set ownership and permissions for /var/www
RUN chown www-data:www-data /var/www \
    && chmod 750 /var/www

# Set permissions for /tmp
RUN chmod -R 777 /tmp

# Add global error logging
RUN echo "[global]\nerror_log = /var/log/php-fpm-error.log" >> /usr/local/etc/php-fpm.conf

# Set working directory
WORKDIR /var/www/html
