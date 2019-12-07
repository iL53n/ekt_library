<template lang="pug">
  div(class="q-pa-md")
    q-layout(view="lhh lpR lff" container style="height: 95vh" class="shadow-5 rounded-borders")
      q-layout(view="hHh lpR fFf")
        header-component

        q-page-container
          q-page(padding style="padding-top: 66px")

            router-view

          q-page-scroller(position="bottom")
            q-btn(fab icon="keyboard_arrow_up" color="red")
        footer-component
</template>

<script>
  import HeaderComponent from './components/Header'
  import BooksTable from './components/Tables/BooksTable'
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
			BooksTable,
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
