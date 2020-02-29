<template lang="pug">
  div
    q-header(elevated class="bg-primary text-white" view="hHh lpR fFf" container)
      q-toolbar(class="toolbar")
        q-btn(flat round dense icon="menu" @click="left = !left")
        a(href="/")
          img(src="../images/Logo.png" alt="EKTlibrary" width="50" align="middle")

        q-toolbar-title БИБЛИОТЕКА ЕКТ
          q-badge(align="top" color="orange") v1.0.0b



        div(class="toolbar-input-container justify-center")
          q-input(dark dense standout v-model="search_text" input-class="text-left" class="q-ml-md")
            template(v-slot:append)
              q-icon(v-if="search_text === ''" name="search")
              q-icon(v-else name="clear" class="cursor-pointer" @click="search_text = ''")

        q-space

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
        miniState: true,
        search_text: ''
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

  .toolbar {
    height: 60px
  }

  .toolbar-input-container {
     min-width: 100px;
     width: 55%
  }

</style>
