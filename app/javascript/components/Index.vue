<template lang="pug">
  div
    div(v-if="loading")
      q-page-container(align="middle")
        q-spinner(color="primary" size="7em" :thickness="10")
    div(v-else)
      div(v-if="error")
        p Error!
      div(v-else)
        div
          q-carousel(
          animated
          v-model="slide"
          navigation
          infinite
          autoplay
          arrows
          transition-prev="slide-right"
          transition-next="slide-left")
            q-carousel-slide(:name="1" img-src="https://cdn.quasar.dev/img/mountains.jpg")
              div(class="absolute-bottom custom-caption")
                div(class="text-h2") Third stop
                div(class="text-subtitle1") Famous Bridge
            q-carousel-slide(:name="2" img-src="https://cdn.quasar.dev/img/parallax1.jpg")
              div(class="absolute-bottom custom-caption")
                div(class="text-h2") Third stop
                div(class="text-subtitle1") Famous Bridge
            q-carousel-slide(:name="3" img-src="https://cdn.quasar.dev/img/parallax2.jpg")
              div(class="absolute-bottom custom-caption")
                div(class="text-h2") Third stop
                div(class="text-subtitle1") Famous Bridge
            q-carousel-slide(:name="4" img-src="https://cdn.quasar.dev/img/quasar.jpg")
              div(class="absolute-bottom custom-caption")
                div(class="text-h2") Third stop
                div(class="text-subtitle1") Famous Bridge
</template>

<script>
  export default {
    data() {
      return {
        slide: 1
      }
    }
  }
      // error: {}
</script>

<style>
  .book-description {
    font-size: 0.85em;
    font-style: italic;
    max-width: 400px;
    /*width: auto;*/
    /*overflow: hidden;*/
    /*text-overflow: ellipsis;*/
    white-space: normal;
    color: #555;
    margin-top: 4px;
  }
  .custom-caption {
    text-align: right;
    padding: 24px;
    color: white;
    background-color: rgba(0, 0, 0, .3)
  }
</style>