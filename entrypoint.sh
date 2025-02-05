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

# Rodar o servidor Vite
echo "Iniciando o servidor Vite..."
cd /var/www/html
npm run dev &  # Inicia o Vite em segundo plano

# Iniciar o Apache
echo "Iniciando o Apache..."
apache2-foreground
