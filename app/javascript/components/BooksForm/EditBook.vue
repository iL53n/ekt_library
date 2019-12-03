<template lang="pug">
  div
    q-dialog(
      :value="true"
      @hide="afterShow()"
      :position="right"
      transition-show="flip-right"
    )
      q-card(style="width: 500px")
        q-form
          q-card-section(class="q-gutter-y-md column")
            q-item-section
            q-input(
              filled
              ref="title"
              label="Наименование *"
              placeholder="Наименование книги"
              v-model="book.title"
              type="text"
            )
            q-input(
              filled
              ref="author"
              label="Автор *"
              placeholder="Автор(-ы) книги"
              v-model="book.author"
              type="text"
            )
            q-input(
              filled
              ref="image"
              label="Изображение *"
              placeholder="ВРЕМЕННОЕ поле_изм_статусы - реализация в другой итерации"
              v-model="book.image"
              type="text"
            )
            q-input(
              filled
              ref="description"
              label="Описание *"
              placeholder="Описание книги"
              v-model="book.description"
              type="textarea"
            )
            q-input(
              filled
              ref="status"
              label="Статус *"
              placeholder="ВРЕМЕННОЕ поле_удл_статусы - реализация в другой итерации"
              v-model="book.status"
              type="text"
            )
            q-btn(
              color="primary"
              label="СОХРАНИТЬ"
              @click="updateBook"
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
	import { backendGetBook, backendPatchBook } from '../../api'
	import { Notify } from 'quasar'

	export default {
		data: function () {
			return {
				book: this.getBook(),
				errors: {},
				hide: true
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
			updateBook() {
				backendPatchBook(this.book)
					.then((response) => {
						Notify.create({
							message: "Книга '" + this.book.title + "' отредактирована!",
							color: 'positive',
							position: 'right'
						});
						this.$emit('edit-book');
						this.book = {};
						this.errors = {};
						// this.$refs.title.resetValidation();
					})
					.catch((error) => {
						this.errors = error.response.data.errors;
					});
			},
			afterShow() {
				this.$router.push("/admin_books");
			}
		},
		components: {
			backendGetBook,
			backendPatchBook
		}
	}
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
