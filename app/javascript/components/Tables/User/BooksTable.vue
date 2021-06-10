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
            :rows-per-page-options="[25, 100]",
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
                  style="max-width: 60px"
                  class="high-scale"
                  @click="showBook(props.row)"
                  )
            // Наименование(название, автор, кол-во коммент)
            template(v-slot:body-cell-title="props")
              q-td(align="left")
                div
                  q-btn(flat color="primary" @click="showBook(props.row)" :label="props.row.title" action="show")
                    q-badge(color="green" icon="edit" floating) {{ props.row.comments.length }}
                    q-tooltip(
                      anchor="center right"
                      self="center left"
                      content-style="font-size: 12px"
                    ) {{ props.row.description }}
                div
                  q-chip(square outline color="blue-grey-6" :label="props.row.author")
            // Рейтинг
            template(v-slot:body-cell-rating="props")
              q-td(align="center")
                q-rating(
                  v-if="props.row.current_rating !== null"
                  readonly
                  size="1.5em"
                  color="orange"
                  icon="star_border"
                  icon-selected="star"
                  v-model="props.row.current_rating"
                )
                q-rating(
                  v-else
                  readonly
                  size="1.5em"
                  color="grey"
                  icon="star_border"
                  icon-selected="star"
                  v-model="null_rating"
                )
            // Категории
            template(v-slot:body-cell-categories="props")
              q-td(align="center")
                div(v-for="category in props.row.categories")
                  q-badge {{ category.title }}
            // Статус
            template(v-slot:body-cell-status="props")
              q-td(align="center")
                div(:class="[status_arr[props.row.status][1]]") {{ status_arr[props.row.status][0] }}
            // Доступно
            template(v-slot:body-cell-count="props")
              q-td(align="center")
                | {{ props.row.all_amount }} шт.
            // Управляющие кнопки
            template(v-slot:body-cell-booking="props")
              q-td
                q-btn-group(flat)
                  div(v-if="props.row.all_amount > 0")
                    q-btn(
                      flat color="white"
                      text-color="primary"
                      size="12px"
                      icon="book"
                      label="Зарезервировать"
                      @click="bookingBook(props.row)"
                    )
                  div(v-else)
                    q-btn(
                      flat
                      color="grey"
                      text-color="grey"
                      size="12px"
                      icon="book"
                      label="Зарезервировать"
                      disable
                    )
            // Добавить в избранное
            template(v-slot:body-cell-wishlist="props")
              q-td
                q-btn(
                  name="add_to_wish"
                  flat
                  round
                  color="green-5"
                  size="12px"
                  icon="favorite_border"
                  @click="addWish(props.row)"
                )
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
        visibleColumns: ['id', 'image', 'title', 'rating', 'categories', 'status', 'count', 'booking', 'wishlist'],
        columns: [
          { name: 'id',         align: 'left',   label: 'ID',           field: 'id',                           sortable: true },
          { name: 'image',      align: 'center', label: 'ОБЛОЖКА',      field: 'image'                                        },
          { name: 'title',      align: 'left',   label: 'НАИМЕНОВАНИЕ', field: row => [row.title, row.author], sortable: true },
          { name: 'rating',     align: 'center', label: 'РЕЙТИНГ',      field: row => row.current_rating,      sortable: true },
          { name: 'categories', align: 'center', label: 'КАТЕГОРИИ',    field: 'categories'                                   },
          { name: 'status',     align: 'center', label: 'СТАТУС',       field: 'status',                       sortable: true },
          { name: 'count',      align: 'center', label: 'ДОСТУПНО',     field: 'all_amount',                   sortable: true },
          { name: 'booking',    align: 'center' },
          { name: 'wishlist',   align: 'center' }
        ],
        status_arr: {
          'not_available': ['НЕ ДОСТУПНА', 'text-grey'],
          'available': ['ДОСТУПНА', 'text-green']
        },
        data: [],
        title: '',
        select_categories: [],
        categories: this.getCategories(),
        null_rating: 0,
        loading: true,
        error: false,
        pagination: {
          rowsPerPage: 10
        },
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
                message: "Ошибка: '" + book.error + "'.",
                color: 'positive',
                position: 'top'
              })
            });
      },
      showBook(book) {
        this.$router.push({ name: 'showBook', params: { id: book.id } })
      },
      getCategories() {
        getCategories()
            .then((response) => {
              this.categories = response.data.categories
            })
            .catch((error) => {
              console.log(error);
              this.error = true
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
  .high-scale {
    transition: 1s;
  }
  .high-scale:hover {
    box-shadow: 0 0 5px;
    transform: scale(2.5);
    z-index: 10;
  }
</style>
