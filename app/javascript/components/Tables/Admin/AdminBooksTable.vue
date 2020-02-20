<template lang="pug">
  div
    div(v-if="loading")
      q-page-container(align="middle")
        q-spinner(color="primary" size="7em" :thickness="10")
    div(v-else)
      div(v-if="error")
        p Error!
      div(v-else)
        div(v-if="user.admin == true")
          q-page-sticky(expand position="top")
            q-toolbar(class="bg-negative glossy text-white")
              q-toolbar-title(align="middle")
                | Книги(АДМИНИСТРИРОВАНИЕ)
          div(class='q-pa-md')
            q-table(
              separator="cell"
              name="books",
              :title="title",
              :data="data",
              :filter="filter",
              :columns="columns",
              :visible-columns="visibleColumns"
              :pagination.sync="pagination",
              :rows-per-page-options="[10, 25, 100]",
              row-key="id"
              no-data-label="Нет информации о книгах!")
              template(v-slot:top-right)
                q-space
                div(style="min-width: 250px; max-width: 400px")
                  q-select(
                    v-model="select_categories"
                    multiple
                    :options="categories"
                    option-value="id"
                    option-label="title"
                    emit-value
                    map-options
                    use-chips
                    label="Отбор по категории")
                    template(v-if="select_categories" v-slot:append)
                      q-icon(name="cancel" @click.stop="select_categories = null" class="cursor-pointer")
              template(v-slot:top-left)
                div(style="width: 250px; max-width: 400px")
                  q-input(debounce="300" v-model="filter" label="Поиск")
                    template(v-slot:append)
                      q-icon(v-if="filter !== ''" name="close" @click="filter = ''" class="cursor-pointer")
                      q-icon(name="search")
              template(v-slot:body-cell-title="props")
                q-td(align="left")
                  div
                    q-btn(flat color="primary" @click="showBook(props.row)" :label="props.row.title" action="show")
                      q-badge(color="green" icon="edit" floating) {{ props.row.comments.length }}
                      q-tooltip(anchor="center right" self="center left" content-style="font-size: 12px") {{ props.row.description }}
                  div
                    q-chip(square outline color="blue-grey-6" :label="props.row.author")
              template(v-slot:body-cell-rating="props")
                q-td(align="center")
                  q-rating(readonly, size="1.5em", color="orange", icon="star_border", icon-selected="star" v-model="props.row.current_rating")
              template(v-slot:body-cell-categories="props")
                q-td(align="center")
                  div(v-for="category in props.row.categories")
                    q-badge {{ category.title }}
              template(v-slot:body-cell-status="props")
                q-td(align="center")
                  | {{ status_arr[props.row.status] }}
              template(v-slot:body-cell-user="props")
                q-td(align="center")
                  div(v-if="props.row.active_user")
                    | {{ props.row.active_user.last_name }} {{ props.row.active_user.first_name }}
              template(v-slot:body-cell-booking="props")
                q-td
                  q-btn-group(flat)
                    div(v-if="props.row.status == 'available' || props.row.status == 'booking' ")
                      q-btn(flat color="white" text-color="primary" size="12px" icon="eject" label="Выдать" @click="giveOutBook(props.row)")
                      q-btn(flat color="white" text-color="grey" size="12px" icon="get_app" label="Вернуть книгу" disable)
                    div(v-if="props.row.status == 'reading'")
                      q-btn(flat color="white" text-color="grey" size="12px" icon="eject" label="Выдать" disable)
                      q-btn(flat color="white" text-color="primary" size="12px" icon="get_app" label="Вернуть книгу" @click="returnBook(props.row)")
              template(v-slot:body-cell-action="props")
                q-td
                  q-btn(name="Подменю" flat dense color="blue-grey-6" icon="menu_open")
                    q-menu(auto-close transition-show="scale" transition-hide="scale")
                      q-item(v-close-popup)
                        q-item-section(align="left")
                          q-btn(name="Редактировать" flat color="white" text-color="secondary" size="12px" icon="edit" label="Редактировать"  @click="editBook(props.row)")
                          q-btn(name="Удалить" flat color="white" text-color="negative" size="12px" icon="delete_forever" label="Удалить"  @click="deleteBook(props.row)" method="delete")

            q-page-sticky(position="bottom-left" :offset="[18, 18]")
              q-btn(fab color="primary" @click="newBook()" icon="add" name="Новая книга")
          router-view(@add-book="fetchBooks" @edit-book="fetchBooks" @give-out-book="fetchBooks" @refresh-list="fetchBooks")
</template>

<script>
	import { deleteBook, getBooks, getCategories, closeBook } from '../../../api'
  import NewBook from '../../BooksForm/CreateBook'
  import EditBook from '../../BooksForm/EditBook'
  import ShowBook from '../../BooksForm/ShowBook'
  import { Notify } from 'quasar'

  export default {
		data() {
			return {
        filter: '',
        visibleColumns: ['id', 'image', 'title', 'author', 'rating', 'categories', 'status', 'user', 'booking', 'action'],
				columns: [
          { name: 'id', align: 'left', label: 'ID', field: 'id', sortable: true },
          { name: 'image', align: 'center', label: 'Обложка', field: 'image' },
          { name: 'title', align: 'left', label: 'Наименование', field: row => [row.title, row.author], sortable: true },
          { name: 'rating', label: 'Рейтинг', align: 'center', field: row => row.rating, format: val => '${val}', sortable: true },
          { name: 'categories', label: 'Категории', align: 'center', field: 'categories' },
          { name: 'status', align: 'center', label: 'Статус', field: 'status', sortable: true },
          { name: 'user', align: 'center', label: 'Пользователь', field: 'user', sortable: true },
          { name: 'booking', align: 'center' },
					{ name: 'action', align: 'center', field: ['edit', 'delete'] }
        ],
        status_arr: {
          'booking': 'Зарезервирована',
          'reading': 'На руках',
          'available': 'Доступна'
        },
				data: [],
				title: '',
        select_categories: [],
        categories: this.getCategories(),
        loading: true,
        pagination: {
          rowsPerPage: 10
        },
			}
			// error: {}
		},
    computed: {
      user: {
        get() {
          return this.$store.state.currentUser
        }
      }
    },
    created() {
			this.fetchBooks();
		},
    watch: {
      select_categories() {
        this.fetchBooks();
      }
    },
    methods: {
			fetchBooks() {
        getBooks({ filter: 'all', category_ids: this.select_categories })
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
      returnBook(book) {
        closeBook(book)
          .then((response) => {
            this.fetchBooks();
            Notify.create({
              message: "Книга '" + book.title + "' возвращена!",
              color: 'positive',
              position: 'top'
            })
          })
          .catch((error) => {
            console.log(error);
            this.error = true
          });
      },
      newBook() {
				this.$router.push({ name: 'createBook'})
      },
      editBook(book) {
        this.$router.push({ name: 'editBook', params: { id: book.id } })
      },
      showBook(book) {
        this.$router.push({ name: 'showBookAdmin', params: { id: book.id } })
      },
      giveOutBook(book) {
        this.$router.push({ name: 'giveOutBook', params: { id: book.id } })
      },
      deleteBook(book) {
        this.$q.dialog({
          title: "Удалить книгу '" + book.title + "' ?",
          message: "Вы собираетесь безвозвратно удалить книгу '" + book.title + "' !",
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
          deleteBook(book.id)
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
        }).onCancel(() => {
          // console.log('Cancel')
        }).onDismiss(() => {
          // console.log('I am triggered on both OK and Cancel')
        })
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