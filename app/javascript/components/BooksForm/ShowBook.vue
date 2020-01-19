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
          div(class="text-h2") {{ this.book.title }}
          div(class="text-h3") {{ this.book.author }}

        q-card-section
          div(class="text-body1") {{ this.book.description }}

        q-card-section
          q-separator
          div(class="text-h6") Комментарии
          q-intersection(v-for="comment in book.comments", :key="comment", transition="flip-right")
            //q-list(class="q-pa-md bg-white text-black shadow-5 rounded-borders" separator )
            q-list(class="q-pa-md q-gutter-sm ")
              q-item(class="bg-white text-black shadow-5 rounded-borders v-ripple"  separator)
                q-item-section
                  q-item-label(v-html="comment.body")
                  q-item-label(caption lines="1") {{ comment.author }}
                q-item-section(side)
                  | {{ comment.created }}

          q-card-section(class="text-black")
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