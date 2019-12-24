<template lang="pug">
  div
    q-dialog(
      :value="true"
      @hide="afterShow()"
      position="left"
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
            q-select(
              filled
              multiple
              label="Категории"
              placeholder="Выберите категорию"
              v-model="selectCategories"
              :options="categories"
              use-chips
              stack-label
              option-value="id"
              option-label="title"
            )
            q-select(
              filled
              label="Статус"
              placeholder="Выберите статус"
              v-model="book.status"
              :options="statuses"
            )
            q-btn(
              color="primary"
              label="СОХРАНИТЬ"
              @click="addBook"
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
  import { backendPostBook, backendGetCategories } from '../../api'
  import { Notify } from 'quasar'

	export default {
		data: function () {
			return {
				book: {
				  status: 'В наличии'
        },
        categories: this.getCategories(),
        selectCategories: [],
        statuses: ['В наличии', 'Зарезервирована', 'На руках'],
        errors: {},
        hide: true
      }
		},
		created() {
		},
    watch: {
      book() {
        this.selectCategories = this.book.categories
      }
    },
		methods: {
			addBook() {
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
      },
      getCategories() {
        backendGetCategories()
            .then((response) => {
              console.log(response.data.categories)
              this.categories = response.data.categories
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
				this.$router.push("/admin_books");
      }
		},
		components: {
			backendPostBook,
      backendGetCategories
		}
	}
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
