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
              :rows-per-page-options="[50, 100, 150]",
              row-key="id"
              no-data-label="Нет информации о книгах!")
              // Отбор по категории
              template(v-slot:top-right)
                q-space
                div(style="min-width: 250px; max-width: 400px")
                  q-select(
                    id="Отбор"
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
              // Поиск
              template(v-slot:top-left)
                div(style="width: 250px; max-width: 400px")
                  q-input(debounce="300" v-model="filter" label="Поиск")
                    template(v-slot:append)
                      q-icon(v-if="filter !== ''" name="close" @click="filter = ''" class="cursor-pointer")
                      q-icon(name="search")
              // Обложка
              template(v-slot:body-cell-image="props")
                q-td(align="center")
                  //q-img(v-bind:src="props.row.image_url" style="height: 140px; max-width: 150px")
                  q-img(
                    :src="props.row.image_src"
                    style="max-width: 40px; box-shadow: 0 0 3px;"
                    @click="showBook(props.row)"
                  )
              // Наименование
              template(v-slot:body-cell-title="props")
                q-td(align="center")
                  div
                    q-btn(
                      size="11px"
                      flat
                      color="primary"
                      @click="showBook(props.row)"
                      :label="props.row.title"
                      action="show"
                    )
              // Автор
              template(v-slot:body-cell-author="props")
                q-td(align="left")
                  div
                    | {{ props.row.author }}
              // Описание
              template(v-slot:body-cell-description="props")
                q-td(align="center")
                  div
                    | {{ props.row.description !== '' }}
              // Рейтинг
              template(v-slot:body-cell-rating="props")
                q-td(align="center")
                  div
                    | {{ props.row.current_rating }}
              // Комментарии(кол-во)
              template(v-slot:body-cell-comments="props")
                q-td(align="center")
                  div
                    | {{ props.row.comments.length }}
              // Категории
              template(v-slot:body-cell-categories="props")
                q-td(align="center")
                  div(v-for="category in props.row.categories")
                    | {{ category.title }}
              // Всего книг
              template(v-slot:body-cell-all_count="props")
                q-td(align="center")
                  div
                    | {{ props.row.number_of }}
              // Зарезервировано
              template(v-slot:body-cell-booked_count="props")
                q-td(align="center")
                  div
                    | {{ props.row.booking.length }}
              // На руках
              template(v-slot:body-cell-reading_count="props")
                q-td(align="center")
                  div
                    | {{ props.row.reading.length }}
              // Доступно для выдачи(
              template(v-slot:body-cell-all_available="props")
                q-td(align="center")
                  div
                    | {{ props.row.all_amount }}
              // Управляющие кнопки
              template(v-slot:body-cell-booking="props")
                q-td
                  q-btn-group(flat)
                    div
                      q-btn(
                        flat
                        color="white"
                        text-color="primary"
                        size="11px"
                        icon="eject"
                        label="Выдать"
                        @click="giveOutBook(props.row)"
                        :disabled="props.row.all_amount === 0"
                      )
                      q-btn(
                        flat
                        color="white"
                        text-color="primary"
                        size="11px"
                        icon="get_app"
                        label="Вернуть"
                        @click="returnBook(props.row)"
                        :disabled="props.row.reading.length === 0"
                      )
              // Подменю - редактирование, удаление
              template(v-slot:body-cell-action="props")
                q-td
                  q-btn(name="Подменю" flat dense color="blue-grey-6" icon="menu_open")
                    q-menu(auto-close transition-show="scale" transition-hide="scale")
                      q-item(v-close-popup)
                        q-item-section(align="left")
                          q-btn(
                            name="Редактировать"
                            flat color="white"
                            text-color="secondary"
                            size="11px"
                            icon="edit"
                            label="Редактировать"
                            @click="editBook(props.row)"
                          )
                          q-btn(
                            name="Удалить"
                            flat
                            color="white"
                            text-color="negative"
                            size="11px"
                            icon="delete_forever"
                            label="Удалить"
                            @click="deleteBook(props.row)"
                            method="delete"
                          )
          // Новая книга
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
        visibleColumns: ['id', 'image', 'title', 'author', 'description', 'rating', 'comments', 'categories', 'all_count', 'booked_count', 'reading_count', 'available', 'booking', 'action'],
				columns: [
          { name: 'id',            align: 'center', label: 'ID',                                  field: 'id',                         sortable: true },
          { name: 'image',         align: 'center', label: '',                                    field: 'image'                                      },
          { name: 'title',         align: 'center', label: 'НАИМЕНОВНИЕ',                         field: 'title',                      sortable: true },
          { name: 'author',        align: 'center', label: 'АВТОР',                               field: 'author',                     sortable: true },
          { name: 'description',   align: 'center', label: 'ОПИСАНИЕ',                            field: 'description',                sortable: true },
          { name: 'rating',        align: 'center', label: 'РЕЙТИНГ',                             field: row => row.current_rating,    sortable: true },
          { name: 'comments',      align: 'center', label: 'КОММЕНТ.(кол-во)',                    field: row => row.comments.length,   sortable: true },
          { name: 'categories',    align: 'center', label: 'КАТЕГОРИИ',                           field: 'categories'                                 },
          { name: 'all_count',     align: 'center', label: 'ВСЕГО КНИГ',                          field: row => row.number_of,         sortable: true },
          { name: 'booked_count',  align: 'center', label: 'В РЕЗЕРВЕ',                           field: row => row.booking.length,    sortable: true },
          { name: 'reading_count', align: 'center', label: 'НА РУКАХ',                            field: row => row.reading.length,    sortable: true },
          { name: 'available',     align: 'center', label: 'ДОСТУПНО к выдаче(с учетом резерва)', field: row => row.all_amount,        sortable: true },
          { name: 'booking', align: 'center',       label: '',                                                                                        },
					{ name: 'action',  align: 'center',       label: '',                                    field: ['edit', 'delete']                           }
        ],
				data: [],
				title: '',
        select_categories: [],
        categories: this.getCategories(),
        loading: true,
        error: false,
        pagination: {
          rowsPerPage: 50
        },
			}
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
        this.$router.push({ name: 'voteBook', params: { id: book.id } })
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
      voteBook(book) {
        this.$router.push({ name: 'voteBook', params: { id: book.id } })
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
  .q-table thead th {
    width: 40px;
    white-space: normal;
  }

  .q-table tbody td {
    width: 40px;
    white-space: normal;
  }
</style>
