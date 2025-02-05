<template>
    <MainLayout>
        <div>
            Show
        </div>
    </MainLayout>


</template>

<script setup>
let count = ref(0)

function increment(){
    count++
}
import { ref } from 'vue';
import MainLayout from '../../Layouts/MainLayout.vue';
import { Link } from '@inertiajs/vue3';
</script>
