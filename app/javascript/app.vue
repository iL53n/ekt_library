<template lang="pug">
  div(class="q-pa-md q-gutter-y-sm")
    q-toolbar(class="bg-grey-3")
      q-btn(flat round dense icon="menu")
      q-toolbar-title
       | Test Quasar
      q-btn(flat round dense icon="more_vert")
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
