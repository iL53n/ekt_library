<template lang="pug">
  div
    | {{ user.email }}
    q-btn(flat round dense icon="account_circle")
      q-menu(auto-close transition-show="scale" transition-hide="scale")
        q-list(style="min-width: 100px")
          div(v-if="user.admin")
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
	import { backendCurrentUser } from '../api/index'

	export default {
		data: function () {
			return {
				user: {}
			}
		},
		created() {
			this.fetchUser();
		},
		methods: {
			fetchUser() {
				backendCurrentUser()
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
			backendCurrentUser
		}
	}
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
