#!/bin/bash
# Atribuindo permissão ao diretório de armazenamento
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Rodando as migrações do Laravel
echo "Rodando migrações..."
php artisan migrate --force

# Iniciando o servidor Vite
echo "Iniciando o servidor Vite..."
npm run dev &  # Isso vai rodar o servidor Vite em segundo plano

# Iniciando o Apache
echo "Iniciando o Apache..."
apache2-foreground
