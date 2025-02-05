import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
        vue({
            template: {
                transformAssetUrls: {
                    base: null,  // Permite que os arquivos de ativos sejam reescritos pelo Vite
                    includeAbsolute: false,  // Deixa URLs absolutas inalteradas
                },
            },
        }),
    ],
    build: {
        outDir: 'public/build',  // Gera o build na pasta public/build
        manifest: true,  // Gera um arquivo de manifesto para que o Laravel consiga identificar os arquivos gerados
        rollupOptions: {
            input: {
                app: 'resources/js/app.js',  // Arquivo principal de entrada do seu JS
            },
        },
    },
});
