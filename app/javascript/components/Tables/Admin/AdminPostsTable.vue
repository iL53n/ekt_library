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
          div(class='q-pa-md')
            q-table(
              separator="cell"
              name="books",
              :title="title",
              :data="data",
              :columns="columns",
              :pagination.sync="pagination",
              :rows-per-page-options="[10, 25, 100]",
              row-key="id"
              no-data-label="НЕТ ЗАПИСЕЙ ")
              template(v-slot:body-cell-book="props")
                q-td(align="center")
                  | {{ props.row.book.title }}
              template(v-slot:body-cell-user="props")
                q-td(align="center")
                  | {{ props.row.user.email }}
</template>

<script>
  import { indexPosts, getCategories } from '../../../api'
  import { Notify } from 'quasar'

  export default {
    data() {
      return {
        columns: [
          { name: 'id', align: 'left', label: 'ID', field: 'id', sortable: true },
          { name: 'title', align: 'left', label: 'Title', field: 'title', sortable: true },
          { name: 'book', label: 'Наименование книги', align: 'center', format: val => '${val}', sortable: true },
          { name: 'user', label: 'Пользователь', align: 'center', format: val => '${val}', sortable: true },
          { name: 'start_date', align: 'left', label: 'Start', field: 'start_date', sortable: true },
          { name: 'end_date', align: 'left', label: 'End', field: 'end_date', sortable: true },
        ],
        data: [],
        title: '',
        loading: true,
        ratingModel: 3,
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
      this.fetchPosts();
    },
    methods: {
      fetchPosts() {
        indexPosts()
            .then((response) => {
              console.log(response.data.posts)
              this.data = response.data.posts
            })
            .catch((error) => {
              console.log(error);
              this.error = true
            })
            .finally(() => {
              this.loading = false
            });
      },
    },
    components: {
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