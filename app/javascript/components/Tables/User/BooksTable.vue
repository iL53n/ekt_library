<template lang="pug">
  div
    div(v-if="loading")
      q-page-container(align="middle")
        q-spinner(color="primary" size="7em" :thickness="10")
    div(v-else)
      div(v-if="error")
        p Error!
      div(v-else)
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
                  use-chips
                  label="Отбор по категории")
                  template(v-if="select_categories" v-slot:append)
                    q-icon(name="cancel" @click.stop="select_categories = null" class="cursor-pointer")
            template(v-slot:top-left)
              div(style="min-width: 250px; max-width: 400px")
                q-input(debounce="300" v-model="filter" label="Поиск")
                  template(v-slot:append)
                    q-icon(v-if="filter !== ''" name="close" @click="filter = ''" class="cursor-pointer")
                    q-icon(name="search")
            template(v-slot:body-cell-title="props")
              q-td(align="left")
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
                  div(v-if="props.row.status == 'available'")
                    q-btn(flat color="white" text-color="primary" size="12px" icon="book" label="Зарезервировать"  @click="bookingBook(props.row)")
                  div(v-if="props.row.status == 'booking'")
                    q-btn(flat color="grey" text-color="grey" size="12px" icon="book" label="Зарезервировать" disable)
                  div(v-if="props.row.status == 'reading'")
                    q-btn(flat color="grey" text-color="grey" size="12px" icon="book" label="Зарезервировать" disable)
            template(v-slot:body-cell-wishlist="props")
              q-td
                q-btn(flat round color="green-5" size="12px" icon="favorite_border" @click="addWish(props.row)")
        router-view
</template>

<script>
  import { backendGetBooks, backendGetCategories, createPost } from '../../../api'
  import NewBook from '../../BooksForm/CreateBook'
  import EditBook from '../../BooksForm/EditBook'
  import ShowBook from '../../BooksForm/ShowBook'
  import { Notify } from 'quasar'

  export default {
    data() {
      return {
        filter: '',
        visibleColumns: ['id', 'image', 'title', 'author', 'rating', 'categories', 'status', 'user', 'booking', 'wishlist'],
        columns: [
          { name: 'id', align: 'left', label: 'ID', field: 'id', sortable: true },
          { name: 'image', align: 'center', label: 'Обложка', field: 'image' },
          { name: 'title', align: 'left', label: 'Наименование', align: 'left', field: 'title', sortable: true },
          { name: 'author', align: 'left', label: 'Автор', align: 'left', field: 'author', sortable: true, hide: true },
          { name: 'rating', label: 'Рейтинг', align: 'center', field: 'rating', sortable: true },
          { name: 'categories', label: 'Категории', align: 'center', field: row => row.categories, format: val => '${val}' },
          { name: 'status', align: 'center', label: 'Статус', field: row => row.status, format: val => '${val}', sortable: true },
          { name: 'user', align: 'center', label: 'Пользователь', field: row => row.user, format: val => '${val}', sortable: true },
          { name: 'booking', align: 'center' },
          { name: 'wishlist', align: 'center' },
        ],
        status_arr: {
          'booking': 'Зарезервирована',
          'reading': 'На руках',
          'available': 'Доступна'
        },
        data: [],
        title: '',
        select_categories: null,
        categories: this.getCategories(),
        loading: true,
        pagination: {
          rowsPerPage: 10
        },
      }
      //error: {}
    },
    created() {
      this.fetchBooks();
    },
    methods: {
      fetchBooks() {
        backendGetBooks({ filter: 'all' })
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
      bookingBook(book) {
        createPost({ title: 'booking', book_id: book.id })
            .then((response) => {
              this.fetchBooks();
              Notify.create({
                message: "Книга '" + book.title + "' зарезервирована!",
                color: 'positive',
                position: 'top'
              })
            })
            .catch((error) => {
              console.log(error);
              this.error = true
            });
      },
      addWish(book) {
        createPost({ title: 'wish', book_id: book.id, active: false })
            .then((response) => {
              this.fetchBooks();
              Notify.create({
                message: "Книга '" + book.title + "' добавлена в избранные!",
                color: 'positive',
                position: 'top'
              })
            })
            .catch((error) => {
              this.error = true
              Notify.create({
                message: "Ошибка: '" + book.errors + "'.",
                color: 'positive',
                position: 'top'
              })
            });
      },
      showBook(book) {
        this.$router.push({ name: 'showBook', params: { id: book.id, url: '/list_books' } })
      },
      getCategories() {
        backendGetCategories()
            .then((response) => {
              this.categories = response.data.categories.map(cat => cat.title)
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