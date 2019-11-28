<template lang="pug">
  div
    | {{ user.email }}
    q-btn(
      type="a"
      href="/users/sign_out"
      color="white"
      size="10px"
      text-color="primary"
      label="Выйти"
    )
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
