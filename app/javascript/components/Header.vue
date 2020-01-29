<template lang="pug">
  div
    q-header(elevated class="bg-primary text-white" view="hHh lpR fFf" container)
      q-toolbar
        q-btn(flat round dense icon="menu" @click="left = !left")
        a(href="/")
          img(src="../images/Logo.png" alt="EKTlibrary" width="50" align="middle")

        q-toolbar-title БИБЛИОТЕКА ЕКТ
          q-badge(align="top" color="orange") v1.0.0b

        div
          profile-menu

    q-drawer(
      v-model="left"
      show-if-above

      :mini="miniState"
      @mouseover="miniState = false"
      @mouseout="miniState = true"
      mini-to-overlay

      :width="220"
      :breakpoint="500"
      bordered
      content-class="bg-grey-3")
      q-scroll-area(class="fit")
        q-separator
        user-left-menu

</template>

<script>
  import ProfileMenu from './Profile'
  import UserLeftMenu from './Tables/User/UserLeftMenu'

	export default {
		data: function () {
			return {
			  left: false,
        miniState: true
      }
		},
		created() {
		},
		methods: {
		},
		components: {
      ProfileMenu,
      UserLeftMenu
		}
	}
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
