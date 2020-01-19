<template lang="pug">
  div(class="q-pa-md")
    q-dialog(
      :value="true"
      @hide="afterShow()"
      :maximized="maximizedToggle"
      transition-show="slide-up"
      transition-hide="slide-down"
    )
      q-card(class="bg-primary text-white")
        q-bar
          div {{ this.book.author }} - {{ this.book.title }}

          q-space

          q-btn(dense flat icon="minimize" @click="maximizedToggle = false" :disable="!maximizedToggle")
          q-btn(dense flat icon="crop_square" @click="maximizedToggle = true" :disable="maximizedToggle")
          q-btn(dense flat icon="close" v-close-popup)

        q-card-section
          div(class="text-h3") {{ this.book.title }}
          div(class="text-h5") {{ this.book.author }}

        q-card-section
          | {{ this.book.description }}
          |
          p Комментарии
          p {{ this.book.comments }}

        q-card-section(class="text-black")
          | {{new_comment}}
          q-editor(v-model="new_comment", flat, text-color="black", toolbar-text-color="white", toolbar-toggle-color="black", toolbar-bg="secondary")
          q-btn(text-color="white" color="secondary" label="Добавить комментарий" @click="addComment")
</template>

<script>
	import { backendGetBook, createComment } from '../../api'

	export default {
		data: function () {
			return {
				book: this.getBook(),
				errors: {},
				hide: true,
        maximizedToggle: false,
        new_comment: ''
			}
		},
		created() {
		},
		methods: {
			getBook() {
				backendGetBook(this.$route.params.id)
					.then((response) => {
						console.log(response.data)
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
      addComment() {
        createComment({body: this.new_comment, book_id: this.$route.params.id})
          .then((response) => {
            Notify.create({
              message: "Комментарий добавлен!",
              color: 'positive',
              position: 'top'
            });
            this.new_comment = ''
          })
          .catch((error) => {
            console.log(error);
            this.errors = true
          })
          .finally(() => {
            this.loading = false
          });
      },
			afterShow() {
				this.$router.push(this.$route.params.url);
			}
		},
		components: {
			backendGetBook
		}
	}
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>