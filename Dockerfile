# Imagem base do PHP
FROM php:8.2-fpm

# Instala dependências necessárias
RUN apt-get update && apt-get install -y \
    zip unzip curl libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libxml2-dev sqlite3 libsqlite3-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Instala o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Define o diretório de trabalho
WORKDIR /var/www/html

# Copia os arquivos para o container
COPY . .

# Instala as dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Define permissões para a pasta de cache do Laravel
RUN chmod -R 777 storage bootstrap/cache

# Define o comando padrão para rodar o PHP-FPM
CMD ["php-fpm"]
