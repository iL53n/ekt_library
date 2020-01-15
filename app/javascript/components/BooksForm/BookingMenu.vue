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
            q-select(
              filled
              label="Пользователь"
              placeholder="Выберите пользователя"
              v-model="book.active_user"
              :options="users"
              option-value="id"
              :option-label="(user) => [user.last_name, user.first_name]"
            )
            q-btn(
              color="primary"
              label="ВЫДАТЬ"
              @click="giveOutBook"
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
  import { backendGetBook, backendGetUsers, createPost } from '../../api'
  import { Notify } from 'quasar'

  export default {
    data: function () {
      return {
        book: this.getBook(),
        users: this.getUsers(),
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
        backendGetBook(this.$route.params.id)
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
      getUsers() {
        backendGetUsers()
          .then((response) => {
            // console.log(response.data.users)
            this.users = response.data.users
          })
          .catch((error) => {
            console.log(error);
            this.errors = true
          })
          .finally(() => {
            this.loading = false
          });
      },
      giveOutBook() {
        createPost({ title: 'reading', book_id: this.book.id, user_id: this.book.active_user.id })
          .then((response) => {
            // console.log(response.data.book)
            Notify.create({
              message: "Книга '" + this.book.title + "' выдана!",
              color: 'positive',
              position: 'top'
            });
            this.$emit('give-out-book');
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
