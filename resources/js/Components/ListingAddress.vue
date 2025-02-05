<template>
    <span>
    {{ listing.city }} {{ listing.street }} for ${{ listing.price }}
    </span>
</template>

<script setup>
defineProps({
    listing: Object, 
})
</script>