# Estágio de Build para o Node.js
FROM node:20-alpine as node-builder

WORKDIR /app
COPY package*.json ./
COPY vite.config.js ./
COPY resources ./resources

RUN npm install
RUN npm run build


FROM php:8.2-apache


RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libsqlite3-dev  

# Instalar Node.js e npm
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs    

RUN a2enmod rewrite


RUN docker-php-ext-install pdo pdo_sqlite mbstring exif pcntl bcmath gd


ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf


COPY --from=composer:latest /usr/bin/composer /usr/bin/composer


WORKDIR /var/www/html


COPY . .


COPY --from=node-builder /app/public/build ./public/build


RUN composer install --no-dev --optimize-autoloader


RUN mkdir -p /var/www/html/database && \
    touch /var/www/html/database/database.sqlite && \
    chown -R www-data:www-data /var/www/html/database


COPY entrypoint.sh /entrypoint.sh


RUN chmod +x /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]
