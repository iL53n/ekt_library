<template lang="pug">
  div
    q-header
      q-toolbar(class="bg-primary glossy text-white")
        q-btn(flat round dense icon="menu")
        a(href="/")
          img(src="../images/Logo.png" alt="EKTlibrary" width="50" align="middle")
        q-toolbar-title EKT group library
          q-badge(align="top" color="orange") v1.0.0b
        div
          profile-menu
        q-btn(flat round dense icon="more_vert")
</template>

<script>
  import ProfileMenu from './Profile'

	export default {
		data: function () {
			return {}
		},
		created() {
		},
		methods: {
		},
		components: {
      ProfileMenu
		}
	}
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
