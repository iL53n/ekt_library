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
              | Категории(АДМИНИСТРИРОВАНИЕ)
        div(class='q-pa-md')
          q-table(
            name="categories",
            :title="title",
            :data="data",
            :columns="columns",
            :pagination.sync="pagination",
            :rows-per-page-options="[10, 25, 100]",
            row-key="id"
            no-data-label="Нет информации о категориях!")
            template(v-slot:body-cell-action="props")
              q-td(align="right")
                q-btn(push color="white" text-color="secondary" label="Редактировать"  @click="editCategory(props.row)")
                q-btn(push color="white" text-color="negative" label="Удалить"  @click="deleteCategory(props.row)" method="delete")

          q-btn(push color="primary" size="15px" @click="newCategory()" label="Новая категория")
        router-view(@add-category="fetchCategories" @edit-category="fetchCategories")
</template>

<script>
	import { backendGetCategories, backendDeleteCategory } from '../../api'
  import NewCategory from '../CategoriesForm/CreateCategory'
  // import EditCategory from '../CategoriesForm/EditCategory'
  import { Notify } from 'quasar'

  export default {
		data() {
			return {
				columns: [
          { name: 'id', align: 'left', label: 'ID', field: 'id', sortable: true },
          { name: 'title', required: true, label: 'Наименование', align: 'left', field: 'title', sortable: true },
					{ name: 'action', align: 'center', field: ['edit', 'delete'] }
        ],
				data: [],
        pagination: {
          rowsPerPage: 10
        },
				title: '',
				loading: true
			}
			error: {}
		},
    created() {
			this.fetchCategories();
		},
    methods: {
			fetchCategories() {
				backendGetCategories()
					.then((response) => {
						this.data = response.data.categories
					})
					.catch((error) => {
						console.log(error);
						this.error = true
					})
					.finally(() => {
						this.loading = false
					});
      },
      newCategory() {
				this.$router.push({ name: 'createCategory'})
      },
      editCategory(category) {
        // this.$router.push({ name: 'editCategory', params: { id: category.id } })
      },
      deleteCategory(category) {
        backendDeleteCategory(category.id)
          .then((response) => {
            this.fetchCategories();
            Notify.create({
              message: "Категория '" + category.title + "' удалена!",
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
      NewCategory,
      // EditCategory,
      Notify
    }
	}
</script>

<style>
  .category-description {
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