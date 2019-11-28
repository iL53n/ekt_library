<template lang="pug">
  div(class="q-pa-md q-gutter-y-sm")
    q-toolbar(class="bg-primary text-white")
      q-btn(flat round dense icon="menu")
      a(href="/")
        img(src="../images/Logo.png" alt="EKTlibrary" width="50" align="middle")
      q-toolbar-title EKT group library
        q-badge(align="top" color="orange") v1.0.0b
      | {{ user.email }}
      q-btn(flat round dense icon="more_vert")
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
