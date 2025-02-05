<template>
    <a href="/">Main page</a> &nbsp;
    <Link href="/show">Show page</Link>
   <div>the page with time {{ timer }}</div>
<slot>Default</slot>

</template>

<script setup>

import { ref } from 'vue';
import { Link } from '@inertiajs/vue3';
const timer = ref(0)

setInterval(() => timer.value++, 1000);
</script>