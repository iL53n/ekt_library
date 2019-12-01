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
        .q-pa-md
          q-table(
            name="books",
            :title="title",
            :data="data",
            :columns="columns",
            row-key="id"
            no-data-label="Нет информации о книгах!")
        new-book
</template>

<script>
  import { backendGetBooks } from '../api/index'
  import NewBook from './CreateBook'

  export default {
		data() {
			return {
				columns: [
					{ name: 'id', align: 'center', label: 'ID', field: 'id', sortable: true },
					{ name: 'image', align: 'center', label: 'Обложка', field: 'image' },
					{ name: 'title', align: 'center', label: 'Наименование', field: 'title', sortable: true },
					{ name: 'author', align: 'center', label: 'Автор', field: 'author', sortable: true },
					{ name: 'status', label: 'Статус', field: 'status', sortable: true },
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
      }
    },
    components: {
			backendGetBooks,
      NewBook
    }
	}
</script>