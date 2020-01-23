<template lang="pug">
  div
    div(v-if="user.admin == true")
      //q-toggle(
        v-model="show_admin"
        checked-icon="check"
        color="red"
        label="Admin mode"
        left-label
        unchecked-icon="clear")
    | {{ user.email }}
    q-btn(flat round dense icon="account_circle")
      q-menu(auto-close transition-show="scale" transition-hide="scale")
        q-list(style="min-width: 100px")
          div(v-if="show_admin")
            q-item(v-close-popup)
              q-item-section
                q-btn(
                  to="/admin_books"
                  color="negative"
                  size="10px"
                  text-color="white"
                  label="Панель администратора"
                )
          q-item(v-close-popup)
            q-item-section {{ user.first_name }}
            q-item-section {{ user.last_name }}
          q-separator
          q-item(clickable v-close-popup)
            q-item-section
              | Item_1
          q-separator
          q-item(clickable v-close-popup)
            q-item-section
              | Item_2
          q-separator
          q-item(v-close-popup)
            q-item-section
              q-btn(
                to="/users/sign_out"
                color="primary"
                size="10px"
                text-color="white"
                label="Выйти"
              )
</template>

<script>
	import { currentUser } from '../api/index'

	export default {
		data: function () {
			return {
				user: {},
        show_admin: true
			}
		},
		created() {
			this.fetchUser();
		},
		methods: {
			fetchUser() {
				currentUser()
					.then((response) => {
						this.user = response.data.user
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
			backendCurrentUser: currentUser
		}
	}
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
