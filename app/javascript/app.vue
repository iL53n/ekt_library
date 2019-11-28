<template lang="pug">
  div(class="q-pa-md")
    q-layout(view="lhh lpR lff" container style="height: 95vh" class="shadow-5 rounded-borders")
      header-component
      footer-component
</template>

<script>
  import HeaderComponent from './components/Header'
  import FooterComponent from './components/Footer'

  export default {
    data: function () {
      return {

      }
    },
    created() {
    },
    methods: {
    },
    components: {
			HeaderComponent,
      FooterComponent
    }
  }
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
