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
            :pagination.sync="pagination",
            :rows-per-page-options="[10, 25, 100]",
            row-key="id"
            no-data-label="Нет информации о пользователях!")
            template(v-slot:body-cell-action="props")
              q-td(align="right")
                q-btn-group(flat)
                  q-btn(flat color="white" text-color="secondary" size="12px" icon="edit" label="Редактировать"  @click="editUser(props.row)")
                  q-btn(flat color="white" text-color="negative" size="12px" icon="delete_forever" label="Удалить"  @click="deleteUser(props.row)" method="delete")
          q-page-sticky(position="bottom-left" :offset="[18, 18]")
            q-btn(fab color="primary" @click="newUser()" icon="add" name="Новый пользователь")
        router-view(@add-user="fetchUsers" @edit-user="fetchUsers")
</template>

<script>
	import { getUsers, deleteUser } from '../../../api'
  import NewUser from '../../UsersForm/CreateUser'
  import EditUser from '../../UsersForm/EditUser'
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
        pagination: {
          rowsPerPage: 10
        },
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
				getUsers()
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
      editUser(user) {
        this.$router.push({ name: 'editUser', params: { id: user.id } })
      },
      deleteUser(user) {
        deleteUser(user.id)
          .then((response) => {
            this.fetchUsers();
            Notify.create({
              message: "Пользователь '" + user.email + "' удален!",
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