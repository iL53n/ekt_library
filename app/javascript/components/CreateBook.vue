<template lang="pug">
  div
    q-btn(color='primary' rounded label="Новая книга")
      q-menu(anchor="center right" self="center left")
        q-card(style="width: 300px")
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
                @click="addClient"
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
  import { backendPostBook } from '../api'
  import { Notify } from 'quasar'

	export default {
		data: function () {
			return {
				book: {},
        errors: {},
        hide: true
      }
		},
		created() {
		},
		methods: {
			addClient() {
        backendPostBook(this.book)
					.then((response) => {
						Notify.create({
							message: "Книга '" + this.book.title + "' создана!",
							color: 'positive',
							position: 'top'
						});
						this.$emit('add-book');
						this.book = {};
						this.errors = {};
						// this.$refs.title.resetValidation();
					})
					.catch((error) => {
						this.errors = error.response.data.errors;
					});
      }
		},
		components: {
			backendPostBook
		}
	}
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
