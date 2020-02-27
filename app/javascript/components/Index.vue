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
          q-toolbar(class="bg-grey-3")
            q-toolbar-title(align="middle") Новинки
          div(class="q-pa-md row justify-center q-gutter-sm")
            q-intersection(v-for="book in data", :key="book", class="card", transition="scale")
              q-card
                q-img(:src="book.image_src" clickable @click="fetchBooks")
                  div(class="absolute-bottom text-body1 text-center") {{ book.title }}
                  q-tooltip(anchor="center right" self="center left" content-style="font-size: 12px")
                    div(class="text-h6") {{ book.title }}
                    div(class="text-body2") {{ book.description }}

          q-toolbar(class="bg-grey-3")
            q-toolbar-title(align="middle") Популярные книги
          div(class="q-pa-md row justify-center q-gutter-sm")
            q-intersection(v-for="book in data", :key="book", class="card", transition="scale")
              q-card
                q-img(:src="book.image_src")
                  div(class="absolute-bottom text-body1 text-center") {{ book.title }}
                  q-tooltip(anchor="center right" self="center left" content-style="font-size: 12px")
                    div(class="text-h6") {{ book.title }}
                    div(class="text-body2") {{ book.description }}

          q-toolbar(class="bg-grey-3")
            q-toolbar-title(align="middle") Лучшие оценки
          div(class="q-pa-md row justify-center q-gutter-sm")
            q-intersection(v-for="book in data", :key="book", class="card", transition="scale")
              q-card
                q-img(:src="book.image_src")
                  div(class="absolute-bottom text-body1 text-center") {{ book.title }}
                  q-tooltip(anchor="center right" self="center left" content-style="font-size: 12px")
                    div(class="text-h6") {{ book.title }}
                    div(class="text-body2") {{ book.description }}

          q-toolbar(class="bg-grey-3")
            q-toolbar-title(align="middle") Популярные книги
          div(class="q-pa-md row justify-center q-gutter-sm")
            q-intersection(v-for="book in data", :key="book", class="card", transition="scale")
              q-card
                q-img(:src="book.image_src")
                  div(class="absolute-bottom text-body1 text-center") {{ book.title }}
                  q-tooltip(anchor="center right" self="center left" content-style="font-size: 12px")
                    div(class="text-h6") {{ book.title }}
                    div(class="text-body2") {{ book.description }}

</template>

<script>
  import { getBooks } from '../api'

  export default {
    data() {
      return {
        slide: 1,
        data: []
      }
    },
    created() {
      this.fetchBooks();
    },
    methods: {
      fetchBooks() {
        getBooks({filter: 'all', category_ids: this.select_categories})
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
    }
  }
</script>

<style>
  .slider {
    text-align: right;
    padding: 24px;
    color: white;
    background-color: rgba(0, 0, 0, .3)
  }
  .title-book {
    text-align: center;
    padding: 12px;
    color: white;
    background-color: rgba(0, 0, 0, .3)
  }
  .card {
    width: 200px;
    height: 323px
  }
</style>