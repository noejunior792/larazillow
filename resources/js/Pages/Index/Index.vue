<template>
  <MainLayout>
    <div>
      the message is {{ message }}
    </div>
  </MainLayout>
</template>

<script setup>
defineProps ({
    message: String
})
import { Link } from '@inertiajs/vue3';
import MainLayout from '../../Layouts/MainLayout.vue';
</script>