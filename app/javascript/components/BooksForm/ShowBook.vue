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
</template>

<script>
	import { backendGetBook } from '../../api'

	export default {
		data: function () {
			return {
				book: this.getBook(),
				errors: {},
				hide: true,
        maximizedToggle: false
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
			afterShow() {
				this.$router.push("/list_books");
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