#!/bin/bash

# Verificar se o Vite está instalado corretamente
echo "Verificando instalação do Vite..."
vite --version || { echo "Vite não encontrado! Instalando..."; npm install -g vite; }

# Rodar o servidor Vite
echo "Iniciando o servidor Vite..."
cd /var/www/html
npm run dev &  # Inicia o Vite em segundo plano

# Iniciar o Apache
echo "Iniciando o Apache..."
apache2-foreground
