# Build stage for Node
FROM node:20-alpine as node-builder
WORKDIR /app
COPY package*.json ./
COPY vite.config.js ./
COPY resources ./resources
RUN npm install
RUN npm run build

# PHP stage
FROM php:8.2-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip


# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy Laravel files
COPY . .
COPY --from=node-builder /app/public/build ./public/build

# Install Laravel dependencies
RUN composer install --no-dev --optimize-autoloader


RUN mkdir -p /var/www/html/database && \
    touch /var/www/html/database/database.sqlite && \
    chown -R www-data:www-data /var/www/html/database

RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

RUN php artisan migrate --force
