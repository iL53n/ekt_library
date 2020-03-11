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
            transition-prev="scale"
            transition-next="scale"
            control-color="primary"
            padding
            height="323px"
            class="bg-white text-primary"
            )
            q-carousel-slide(:name="1" class="column no-wrap flex-center")
              div(class="row fit justify-start items-center q-gutter-xs q-col-gutter no-wrap")
                q-img(class="rounded-borders col-2 full-height scale",
                  src="https://cache3.youla.io/files/images/720_720_out/5c/bb/5cbb6cbb80e08e40e62bf842.jpg")
                q-item(align="middle")
                  q-item-section
                    div(class="text-h2") Здесь могла быть ваша цитата, объявление, ну или картинка...
                    div(class="text-h5 text-grey-9") ...и еще много, много, много текста... пусть Татьяна Михайловна придумает :)
            q-carousel-slide(:name="2" class="column no-wrap flex-center")
              div(class="row fit justify-start items-center q-gutter-xs q-col-gutter no-wrap")
                q-img(class="rounded-borders col-2 full-height scale",
                  src="https://cache3.youla.io/files/images/720_720_out/5c/bb/5cbb6cbb80e08e40e62bf842.jpg")
                q-item(align="middle")
                  q-item-section
                    div(class="text-h2") Еще поле для творчества... таких может быть бесконечно много!
                    div(class="text-h5 text-grey-9") ...текст, текст, еще текст... думаем, девочки, думаем! :)

          q-toolbar(class="bg-green-3")
            q-toolbar-title(align="middle") Новинки
          div(class="q-pa-md row justify-center q-gutter-sm")
            q-intersection(v-for="book in new_data", :key="book", class="card", once, transition="scale")
              q-card
                q-img(:src="book.image_src", clickable, class="scale", @click="showBook(book)")
                  q-badge(color="green" floating) NEW
                  div(class="absolute-bottom text-body1 text-center") {{ book.title }}
                  q-tooltip(:delay="700" anchor="center right" self="center left" content-style="font-size: 12px")
                    div(class="text-h6") {{ book.title }}
                    div(class="text-body2") {{ book.description }}

          q-toolbar(class="bg-blue-3")
            q-toolbar-title(align="middle") Популярные книги
          div(class="q-pa-md row justify-center q-gutter-sm")
            q-intersection(v-for="book in popular_data", :key="book", class="card", once, transition="scale")
              q-card
                q-img(:src="book.image_src", clickable, class="scale", @click="showBook(book)")
                  q-badge(color="blue" floating) HIT
                  div(class="absolute-bottom text-body1 text-center") {{ book.title }}
                  q-tooltip(:delay="700" anchor="center right" self="center left" content-style="font-size: 12px")
                    div(class="text-h6") {{ book.title }}
                    div(class="text-body2") {{ book.description }}

          q-toolbar(class="bg-orange-3")
            q-toolbar-title(align="middle") Лучшие оценки
          div(class="q-pa-md row justify-center q-gutter-sm")
            q-intersection(v-for="book in top_data", :key="book", class="card", once, transition="scale")
              q-card
                q-img(:src="book.image_src", clickable, class="scale", @click="showBook(book)")
                  q-badge(color="orange" floating) {{ book.current_rating }}
                    q-icon(name="star")
                    //q-rating(readonly, size="1.5em", color="orange", icon="star_border", icon-selected="star" v-model="book.current_rating")
                  div(class="absolute-bottom text-body1 text-center") {{ book.title }}
                  q-tooltip(:delay="700" anchor="center right" self="center left" content-style="font-size: 12px")
                    div(class="text-h6") {{ book.title }}
                    div(class="text-body2") {{ book.description }}

          q-toolbar(class="bg-grey-4")
            q-toolbar-title(align="middle") Самые обсуждаемые
          div(class="q-pa-md row justify-center q-gutter-sm")
            q-intersection(v-for="book in commented_data", :key="book", class="card", once, transition="scale")
              q-card
                q-img(:src="book.image_src", clickable, class="scale", @click="showBook(book)")
                  q-badge(color="grey" floating) {{ book.comments.length }}
                    q-icon(name="chat_bubble_outline")
                  div(class="absolute-bottom text-body1 text-center") {{ book.title }}
                  q-tooltip(:delay="700" anchor="center right" self="center left" content-style="font-size: 12px")
                    div(class="text-h6") {{ book.title }}
                    div(class="text-body2") {{ book.description }}
        router-view(@add-comment="fetchBooks" @add-vote="fetchBooks")

</template>

<script>
  import { getBooks } from '../api'
  import ShowBook from './BooksForm/ShowBook'

  export default {
    data() {
      return {
        slide: 1,
        new_data: [],
        popular_data: [],
        top_data: [],
        commented_data: []
      }
    },
    created() {
      this.fetchBooks();
    },
    methods: {
      fetchBooks() {
        getBooks({ filter: 'new' })
            .then((response) => {
              this.new_data = response.data.books
            })
            .catch((error) => {
              console.log(error);
              this.error = true
            })
            .finally(() => {
              this.loading = false
            });
        getBooks({ filter: 'popular' })
            .then((response) => {
              this.popular_data = response.data.books
            })
            .catch((error) => {
              console.log(error);
              this.error = true
            })
            .finally(() => {
              this.loading = false
            });
        getBooks({ filter: 'top' })
            .then((response) => {
              this.top_data = response.data.books
            })
            .catch((error) => {
              console.log(error);
              this.error = true
            })
            .finally(() => {
              this.loading = false
            });
        getBooks({ filter: 'commented' })
            .then((response) => {
              this.commented_data = response.data.books
            })
            .catch((error) => {
              console.log(error);
              this.error = true
            })
            .finally(() => {
              this.loading = false
            });
      },
      showBook(book) {
        this.$router.push({ name: 'showBookIndex', params: { id: book.id } })
      },
    },
    components: {
      ShowBook
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