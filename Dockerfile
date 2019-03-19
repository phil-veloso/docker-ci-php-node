FROM ubuntu:18.04

ENV TZ=UTC

RUN export LC_ALL=C.UTF-8
RUN DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install -y \
    sudo \
    # wget \
    zip \
    unzip \
    curl \
    rsync \
    git \
    build-essential \
    apt-utils \
    software-properties-common

# git-ftp
RUN add-apt-repository -y ppa:git-ftp/ppa && apt-get update && apt-get install -y git-ftp

# PHP
RUN add-apt-repository ppa:ondrej/php && apt-get update && apt-get install -y php7.3
RUN apt-get install -y \
    php7.3-mbstring
RUN command -v php

# Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    composer self-update --preview
RUN command -v composer

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_11.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install nodejs -y
RUN npm install npm@6.8.0 -g
RUN command -v node
RUN command -v npm

# NPM install GULP
RUN /usr/bin/npm install -g gulp

# PHPUnit
# RUN wget https://phar.phpunit.de/phpunit.phar
# RUN chmod +x phpunit.phar
# RUN mv phpunit.phar /usr/local/bin/phpunit
# RUN command -v phpunit

# PHPCodeSniffer
# RUN wget https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
# RUN chmod +x phpcs.phar
# RUN mv phpcs.phar /usr/local/bin/phpcs
# RUN command -v phpcs

# Display versions installed
RUN php -v
RUN composer --version
RUN node -v
RUN npm -v