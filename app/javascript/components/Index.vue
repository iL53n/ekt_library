<template lang="pug">
  div
    div(v-if="loading")
      q-page-container(align="middle")
        q-spinner(color="primary" size="7em" :thickness="10")
    div(v-else)
      div(v-if="error")
        p Error!
      div(v-else)
        div(class="q-pa-md")
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
            q-carousel-slide(:name="2" img-src="https://cdn.quasar.dev/img/parallax1.jpg")
            q-carousel-slide(:name="3" img-src="https://cdn.quasar.dev/img/parallax2.jpg")
            q-carousel-slide(:name="4" img-src="https://cdn.quasar.dev/img/quasar.jpg")

</template>

<script>
  import { getBooks, getCategories} from '../../../api'
  import { Notify } from 'quasar'

  export default {
    data() {
      return {
        slide: 1
      }
      // error: {}
    },
    created() {
      this.fetchBooks();
    },
    methods: {
      fetchBooks() {
        getBooks({ filter: 'wishes' })
            .then((response) => {
              this.data = response.data.books
            })
            .catch((error) => {
              console.log(error);
              this.error = true
            })
            .finally(() => {
              this.loading = false
            });
      },
      getCategories() {
        getCategories()
            .then((response) => {
              this.categories = response.data.categories.map(cat => cat.title)
            })
            .catch((error) => {
              console.log(error);
              this.errors = true
            })
            .finally(() => {
              this.loading = false
            });
      },
      showBook(book) {
        this.$router.push({ name: 'showBook', params: { id: book.id, url: '/wish_list' } })
      },
    },
    components: {
      Notify
    }
  }
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
</style>