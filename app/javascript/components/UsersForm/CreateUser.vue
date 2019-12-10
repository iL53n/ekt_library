<template lang="pug">
  div
    q-dialog(
      :value="true"
      @hide="afterShow()"
      position="left"
      transition-show="flip-right"
    )
      q-card(style="width: 500px")
        q-form
          q-card-section(class="q-gutter-y-md column")
            q-item-section
            q-input(
              filled
              ref="first_name"
              label="Имя *"
              placeholder="Имя пользователя"
              v-model="user.first_name"
              type="text"
            )
            q-input(
              filled
              ref="first_name"
              label="Фамилия *"
              placeholder="Фамилия пользователя"
              v-model="user.last_name"
              type="text"
            )
            q-input(
              filled
              ref="email"
              label="Email *"
              v-model="user.email"
              suffix="@ekt.by"
              type="email"
            )
            q-input(
              filled
              ref="password"
              label="Пароль *"
              placeholder="Пароль пользователя"
              v-model="user.password"
              type="text"
            )
            q-toggle(
              color="blue"
              ref="admin"
              label="Администратор"
              v-model="user.admin"
              val="true"
            )
            q-btn(
              color="primary"
              label="СОХРАНИТЬ"
              @click="addUser"
              type="submit"
              v-close-popup="hide"
            )
            q-btn(
              flat
              color="primary"
              label="Закрыть"
              v-close-popup
            )
</template>

<script>
  import { backendPostUser } from '../../api'
  import { Notify } from 'quasar'

	export default {
		data: function () {
			return {
				user: {},
        errors: {},
        hide: true
      }
		},
		created() {
		},
		methods: {
			addUser() {
        backendPostUser(this.user)
					.then((response) => {
						Notify.create({
							message: "Пользователь '" + this.user.email + "' создан!",
							color: 'positive',
							position: 'top'
						});
						this.$emit('add-user');
						this.user = {};
						this.errors = {};
						// this.$refs.title.resetValidation();
					})
					.catch((error) => {
            console.log(error)
						this.errors = true;
					});
      },
      afterShow() {
				this.$router.push("/admin_users");
      }
		},
		components: {
			backendPostUser,
      Notify
		}
	}
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
