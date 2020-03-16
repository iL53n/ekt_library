<template lang="pug">
  div
    q-dialog(
      :value="true"
      @hide="afterShow()"
      position="right"
      transition-show="flip-left"
    )
      q-card(style="width: 500px")
        q-form
          q-card-section(class="q-gutter-y-md column")
            q-item-section
            h2 {{ this.book.title }}
            div(align="center")
              q-rating(
                size="4em"
                color="orange"
                icon="star_border"
                icon-selected="star"
                v-model="input_rating"
              )
              div(class="text-subtitle1")
                | Оценка пользователя:
                | {{ this.book.active_user.last_name }} {{ this.book.active_user.first_name }}
              div(v-if="input_rating != ''" )
                q-btn(
                  flat
                  color="orange"
                  label="Добавить оценку"
                  @click="addVote()"
                  type="submit"
                )
            q-btn(
              color="primary"
              label="Вернуть книгу в библиотеку"
              @click="returnBook()"
              type="submit"
              v-close-popup="hide"
            )
            q-btn(
              flat
              color="primary"
              label="Закрыть"
              v-close-popup
            )
</template>

<script>
  import {getBook, closeBook, createRating} from '../../api'
  import { Notify } from 'quasar'

  export default {
    data: function () {
      return {
        book: this.getBook(),
        input_rating: '',
        errors: {},
        hide: true
      }
    },
    created() {
    },
    watch: {
    },
    methods: {
      getBook() {
        getBook(this.$route.params.id)
          .then((response) => {
            // console.log(response.data)
            this.book = response.data.book
          })
          .catch((error) => {
            console.log(error);
            this.errors = true
          })
          .finally(() => {
            this.loading = false
          });
      },
      addVote() {
        createRating({ value: this.input_rating, book_id: this.book.id, user_id: this.book.active_user.id })
          .then((response) => {
            Notify.create({
              message: "Добавлена оценка: " + this.input_rating,
              color: 'positive',
              position: 'top'
            });
            this.$emit('refresh-list');
          })
          .catch((error) => {
            console.log(error)
            Notify.create({
              message: "Оценка не добавлена! Пользователь уже голосовал! ",
              color: 'negative',
              position: 'top'
            });
            this.input_rating = ''
          })
          .finally(() => {
            this.loading = false
          });
      },
      returnBook() {
        closeBook(this.book)
          .then((response) => {
            Notify.create({
              message: "Книга '" + this.book.title + "' возвращена!",
              color: 'positive',
              position: 'top'
            })
            this.$emit('refresh-list');
          })
          .catch((error) => {
            console.log(error);
            this.error = true
          });
      },
      afterShow() {
        this.$router.push("/admin_books");
      }
    },
    components: {
    }
  }
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
