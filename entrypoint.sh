#!/bin/bash
# Verificar se o Vite está instalado corretamente
echo "Verificando instalação do Vite..."
if ! command -v vite &> /dev/null
then
    echo "Vite não encontrado! Instalando..."
    npm install vite --save-dev
else
    echo "Vite encontrado!"
fi

# Rodando as migrações do Laravel
echo "Rodando migrações..."
php artisan migrate --force

# Iniciando o Apache
echo "Iniciando o Apache..."
apache2-foreground