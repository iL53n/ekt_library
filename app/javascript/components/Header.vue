<template lang="pug">
  div
    q-header(elevated class="bg-primary glossy text-white" view="hHh lpR fFf")
      q-toolbar
        q-btn(flat round dense icon="menu" @click="left = !left")
        a(href="/")
          img(src="../images/Logo.png" alt="EKTlibrary" width="50" align="middle")
        q-toolbar-title БИБЛИОТЕКА ЕКТ
          q-badge(align="top" color="orange") v1.0.0b
        div
          profile-menu

    q-drawer(show-if-above v-model="left" side="left" elevated)
        q-scroll-area(class="fit")
          div(class="q-pa-sm")
            q-tabs(v-model="tab" vertical class="text-teal")
              admin-left-menu
</template>

<script>
  import ProfileMenu from './Profile'
  import AdminLeftMenu from './AdminLeftMenu'

	export default {
		data: function () {
			return {
			  left: false
      }
		},
		created() {
		},
		methods: {
		},
		components: {
      ProfileMenu,
      AdminLeftMenu
		}
	}
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
