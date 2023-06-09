FROM php:8.2-fpm

# Copy composer.lock and composer.json
COPY composer.json composer.lock /var/www/html/

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    libpng-dev \
    zip \
    unzip \
    curl \
    zlib1g-dev \
    libicu-dev \
    g++

# Install ext intl
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . /var/www/html

#COPY . /var/www
#WORKDIR /var/www
#RUN cp .env.example .env
#RUN composer install
#RUN php artisan key:generate
#RUN php artisan config:clear
#RUN chmod 777 ./migration.sh
#CMD ["sh", "migration.sh"]
#
#EXPOSE 9000

