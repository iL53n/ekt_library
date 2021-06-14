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
          q-card-section(class="bg-primary text-white")
            div(class="text-h6") {{ book.title }}
            div(class="text-subtitle2") {{ book.author }}
          q-separator
          q-card-section(align="center")
            div(class="text-h6" v-show="book.booking.length !== 0") Резервы({{ book.booking.length }}):
            div(v-for="post in book.booking")
              q-chip(removable size="md" icon="perm_identity" @remove="deletePost(post)")
                | {{ (users.find(user => user.id === post.user_id)).full_name_str }} -- {{ new Date(post.created_at).toDateString() }}
            br
            q-separator
            br
            q-select(
              id="Пользователь"
              filled
              label="Пользователь"
              placeholder="Выберите пользователя"
              v-model="user"
              :options="users"
              option-value="id"
              :option-label="(user) => [user.last_name + ' ' + user.first_name]"
            )
          q-card-actions
            q-btn(
              color="primary"
              label="Выдать"
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
import {getBook, getUsers, createPost, deletePost, deleteBook} from '../../api'
  import { Notify } from 'quasar'

  export default {
    data: function () {
      return {
        book: this.getBook(),
        user: null,
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
      getUsers() {
        getUsers()
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
      deletePost(post) {
        this.$q.dialog({
          title: "Удалить резервирование?",
          message: "Вы собираетесь безвозвратно удалить резервирование!",
          ok: {
            outline: true,
            color: 'negative',
            label: 'Да'
          },
          cancel: {
            flat: true,
            color: 'black',
            label: 'Нет'
          }
        }).onOk(() => {
          deletePost(post.id)
              .then((response) => {
                this.getBook();
                Notify.create({
                  message: "Резервирование удалено!",
                  color: 'negative'
                });
                this.$emit('give-out-book');
              })
              .catch((error) => {
                console.log(error);
                this.error = true
              });
        }).onCancel(() => {
          // console.log('Cancel')
        }).onDismiss(() => {
          // console.log('I am triggered on both OK and Cancel')
        })
      },
      giveOutBook() {
        createPost({ title: 'reading', book_id: this.book.id, user_id: this.user.id })
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
