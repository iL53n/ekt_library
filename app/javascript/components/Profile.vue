<template lang="pug">
  div
    | {{ user.email }}
    q-btn(color="white" size="10px")
      a(:href="'/users/sign_out'" data-method="delete") Выйти
</template>

<script>
	import { backendGetUser } from '../api/index'

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
				backendGetUser()
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
			backendGetUser
		}
	}
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
