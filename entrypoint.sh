#!/bin/bash
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache


echo "Rodando migrações..."
php artisan migrate --force


echo "Iniciando o Apache..."
apache2-foreground
