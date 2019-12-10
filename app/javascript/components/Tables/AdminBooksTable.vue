<template lang="pug">
  div
    div(v-if="loading")
      q-page-container(align="middle")
        q-spinner(color="primary" size="7em" :thickness="10")
    div(v-else)
      div(v-if="error")
        p Error!
      div(v-else)
        q-page-sticky(expand position="top")
          q-toolbar(class="bg-negative glossy text-white")
            q-toolbar-title(align="middle")
              | Книги(АДМИНИСТРИРОВАНИЕ)
        div(class='q-pa-md')
          q-table(
            name="books",
            :title="title",
            :data="data",
            :columns="columns",
            row-key="id"
            no-data-label="Нет информации о книгах!")
            template(v-slot:body-cell-title="props")
              q-td(align="left")
                q-btn(flat color="primary" @click="showBook(props.row)" :label="props.row.title" action="show")
                div
                  q-badge(color="blue-grey-4" :label="props.row.author")
            template(v-slot:body-cell-description="props")
              div(class="book-description") {{ props.row.description }}
            template(v-slot:body-cell-action="props")
              q-td(align="right")
                q-btn(push color="white" text-color="secondary" label="Редактировать"  @click="editBook(props.row)")
                q-btn(push color="white" text-color="negative" label="Удалить"  @click="deleteBook(props.row)" method="delete")

          q-btn(push color="primary" size="15px" @click="newBook()" label="Новая книга")
        router-view(@add-book="fetchBooks" @edit-book="fetchBooks")
</template>

<script>
	import { backendDeleteBook, backendGetBooks } from '../../api'
  import NewBook from '../BooksForm/CreateBook'
  import EditBook from '../BooksForm/EditBook'
  import ShowBook from '../BooksForm/ShowBook'
  import { Notify } from 'quasar'

  export default {
		data() {
			return {
				columns: [
          { name: 'id', align: 'left', label: 'ID', field: 'id', sortable: true },
          { name: 'image', align: 'center', label: 'Обложка', field: 'image' },
          { name: 'title', required: true, label: 'Наименование', align: 'left', field: row => row.title, format: val => '${val}', sortable: true },
          { name: 'description', required: true, label: 'Описание', align: 'left', field: row => row.description, format: val => '${val}' },
					//{ name: 'title', align: 'center', label: 'Наименование', field: 'title', sortable: true },
					//{ name: 'author', align: 'center', label: 'Автор', field: 'author', sortable: true },
					{ name: 'status', align: 'center', label: 'Статус', field: 'status', sortable: true },
					{ name: 'action', align: 'center', field: ['edit', 'delete'] }
        ],
				data: [],
				title: '',
				loading: true
			}
			error: {}
		},
    created() {
			this.fetchBooks();
		},
    methods: {
			fetchBooks() {
				backendGetBooks()
					.then((response) => {
						this.data = response.data.books
					})
					.catch((error) => {
						console.log(error);
						this.error = true
					})
					.finally(() => {
						this.loading = false
					});
      },
      newBook() {
				this.$router.push({ name: 'createBook'})
      },
      editBook(book) {
        this.$router.push({ name: 'editBook', params: { id: book.id } })
      },
      showBook(book) {
        this.$router.push({ name: 'showBook', params: { id: book.id } })
      },
      deleteBook(book) {
        backendDeleteBook(book.id)
          .then((response) => {
            this.fetchBooks();
            Notify.create({
              message: "Книга '" + book.title + "' удалена!",
              color: 'negative'
            })
          })
					.catch((error) => {
						console.log(error);
						this.error = true
					});
      }
    },
    components: {
      NewBook,
      EditBook,
      ShowBook,
      Notify
    }
	}
</script>

<style>
  .book-description {
    font-size: 0.85em;
    font-style: italic;
    max-width: 400px;
    /*width: auto;*/
    /*overflow: hidden;*/
    /*text-overflow: ellipsis;*/
    white-space: normal;
    color: #555;
    margin-top: 4px;
  }
</style>