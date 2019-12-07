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
              | Пользователи(АДМИНИСТРИРОВАНИЕ)
        div(class='q-pa-md')
          q-table(
            name="users",
            :title="title",
            :data="data",
            :columns="columns",
            row-key="id"
            no-data-label="Нет информации о пользователях!")
            template(v-slot:body-cell-action="props")
              q-td(align="right")
                q-btn(text-color="secondary" label="Редактировать"  @click="editUser(props.row)")
                q-btn(text-color="negative" label="Удалить"  @click="deleteUser(props.row)" method="delete")

          q-btn(push color="primary" size="15px" @click="newUser()" label="Новый пользователь")
        router-view(@add-book="fetchUsers" @edit-book="fetchUsers")
</template>

<script>
	import { backendGetUsers } from '../../api'
  import NewUser from '../BooksForm/CreateUser'
  import EditUser from '../BooksForm/EditUser'
  import { Notify } from 'quasar'

  export default {
		data() {
			return {
				columns: [
          { name: 'id', align: 'left', label: 'ID', field: 'id', sortable: true },
          { name: 'first_name', required: true, label: 'Имя',align: 'left', field: 'first_name', sortable: true },
          { name: 'last_name', required: true, label: 'Фамилия', align: 'left', field: 'last_name', sortable: true },
          { name: 'email', required: true, label: 'Email', align: 'left', field: 'email', sortable: true },
          { name: 'admin', required: true, label: 'Администратор', align: 'center', field: 'admin', sortable: true },
					{ name: 'crated_at', align: 'center', label: 'Создано', field: 'created_at', sortable: true },
					{ name: 'action', align: 'center', field: ['edit', 'delete'] }
        ],
				data: [],
				title: '',
				loading: true
			}
			error: {}
		},
    created() {
			this.fetchUsers();
		},
    methods: {
			fetchUsers() {
				backendGetUsers()
					.then((response) => {
						this.data = response.data.users
					})
					.catch((error) => {
						console.log(error);
						this.error = true
					})
					.finally(() => {
						this.loading = false
					});
      },
      newUser() {
				this.$router.push({ name: 'createUser'})
      },
      editUser(book) {
        this.$router.push({ name: 'editUser', params: { id: user.id } })
      },
      deleteUser(user) {
        backendDeleteUser(user.id)
          .then((response) => {
            this.fetchUsers();
            Notify.create({
              message: "Пользователь '" + book.title + "' удален!",
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
      NewUser,
      EditUser,
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