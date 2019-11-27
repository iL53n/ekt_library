<template lang="pug">
  div(class="q-pa-md q-gutter-y-sm")
    q-toolbar(class="bg-grey-3")
      q-btn(flat round dense icon="menu")
      q-toolbar-title
        | Test
        | {{ user.email }}
      q-btn(flat round dense icon="more_vert")
</template>

<script>
  import { backendGetUser } from './api/index'

  export default {
    data: function () {
      return {
      	user: {
      		email: '123'
        }
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
						console.log('<>');
						console.log(response.data);
						console.log('<>');
					})
					.catch((error) => {
						console.log(error);
						//this.error = true
					})
					.finally(() => {
						//this.loading = false
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
