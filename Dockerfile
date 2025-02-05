# Estágio de Build para o Node.js
FROM node:20-alpine as node-builder

WORKDIR /app
COPY package*.json ./
COPY vite.config.js ./
COPY resources ./resources

RUN npm install
RUN npm run build

# Estágio PHP
FROM php:8.2-apache

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libsqlite3-dev  # Adicionando suporte ao SQLite

# Habilitar mod_rewrite do Apache
RUN a2enmod rewrite

# Instalar extensões PHP
RUN docker-php-ext-install pdo pdo_sqlite mbstring exif pcntl bcmath gd

# Definir diretório raiz do Apache
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Instalar o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Definir diretório de trabalho
WORKDIR /var/www/html

# Copiar arquivos do Laravel para o container
COPY . .

# Copiar o build do frontend do estágio node-builder
COPY --from=node-builder /app/public/build ./public/build

# Instalar dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Configuração do SQLite
RUN mkdir -p /var/www/html/database && \
    touch /var/www/html/database/database.sqlite && \
    chown -R www-data:www-data /var/www/html/database

RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Rodar as migrações do Laravel
RUN php artisan migrate --force
