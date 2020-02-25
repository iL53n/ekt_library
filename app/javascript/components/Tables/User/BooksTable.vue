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
            template(v-slot:top-left)
              div(style="width: 250px; max-width: 400px")
                q-input(debounce="300" v-model="filter" label="Поиск")
                  template(v-slot:append)
                    q-icon(v-if="filter !== ''" name="close" @click="filter = ''" class="cursor-pointer")
                    q-icon(name="search")
            template(v-slot:body-cell-image="props")
              q-td(align="left")
                //q-img(v-bind:src="props.row.image_url" style="height: 140px; max-width: 150px")
                q-img(:src="props.row.image_src" style="max-width: 150px" class="scale")
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
                div(:class="[status_arr[props.row.status][1]]") {{ status_arr[props.row.status][0] }}
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
                q-btn(name="add_to_wish" flat round color="green-5" size="12px" icon="favorite_border" @click="addWish(props.row)")
        router-view(@refresh-list="fetchBooks")
</template>

<script>
  import { getBooks, getCategories, createPost } from '../../../api'
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
          { name: 'title', align: 'left', label: 'Наименование', field: row => [row.title, row.author], sortable: true },
          { name: 'rating', label: 'Рейтинг', align: 'center', field: row => row.rating, format: val => '${val}', sortable: true },
          { name: 'categories', label: 'Категории', align: 'center', field: 'categories' },
          { name: 'status', align: 'center', label: 'Статус', field: 'status', sortable: true },
          { name: 'user', align: 'center', label: 'Пользователь', field: 'user', sortable: true },
          { name: 'booking', align: 'center' },
          { name: 'wishlist', align: 'center' },
        ],
        status_arr: {
          'booking': ['Зарезервирована', 'text-blue-grey'],
          'reading': ['На руках', 'text-grey'],
          'available': ['Доступна', 'text-green text-weight-bolder']
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
      //error: {}
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
  .scale {
    transition: 1s; /* Время эффекта */
  }
  .scale:hover {
    transform: scale(1.3); /* Увеличиваем масштаб */
  }
</style>