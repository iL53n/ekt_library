<template lang="pug">
  div
    q-dialog(
      :value="true"
      @hide="afterShow()"
      position="left"
      transition-show="flip-right"
    )
      q-card(style="width: 500px")
        q-form(enctype="multipart/form-data")
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
            q-uploader(
              filled
              ref="cover"
              style="width: auto"
              label="Обложка книги *")
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
  import { postBook, getCategories } from '../../api'
  import { Notify } from 'quasar'

	export default {
		data: function () {
			return {
				book: {
				  status: 'available'
        },
        categories: this.getCategories(),
        selectCategories: [],
        statuses: ['available', 'booking', 'reading'],
        errors: {},
        hide: true,
        inputPicture: null
      }
		},
		created() {
		},
		methods: {
      uploadFile: function() {
        this.book.image = this.$refs.cover.files[0]
        console.log(this.book.image)
      },
			addBook() {
			  // console.log(this.$refs.cover.files)
        // this.book.image = this.$refs.cover.files[0]
        this.book.category_ids = this.selectCategories.map(cat => cat.id)
        // let formData = new FormData()
        // Object.entries(this.book).forEach(
        //     ([key, value]) => formData.append(key, value)
        // )
        postBook(this.book)
					.then((response) => {
						Notify.create({
							message: "Книга '" + this.book.title + "' создана!",
							color: 'positive',
							position: 'top'
						});
						this.$emit('add-book');
						this.book = {};
						this.errors = {};
						 this.$refs.title.resetValidation();
					})
					.catch((error) => {
						this.errors = error.response.data.errors;
					});
      },
      getCategories() {
        getCategories()
            .then((response) => {
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
			postBook,
      getCategories
		}
	}
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
