<template lang="pug">
  div
    q-btn(color='primary' rounded label="Новая книга")
      q-menu(anchor="center right" self="bottom left")
        q-card(style="width: 300px")
          q-form
            q-card-section(class="q-gutter-y-md column")
              q-input(
                filled
                ref="title"
                label="Наименование *"
                placeholder="Наименование книги"
                v-model="book.title"
                type="text"
                lazy-rules
                :rules="[val => val !== null && val !== '' || 'Наименование не может быть пустым']"
                :dense="dense"
              )
                q-input(
                  filled
                  ref="title"
                  label="Автор *"
                  placeholder="Автор(-ы) книги"
                  v-model="book.author"
                  type="text"
                  lazy-rules
                  :rules="[val => val !== null && val !== '' || 'Поле автор не может быть пустым']"
                  :dense="dense"
                )
                  q-input(
                    filled
                    ref="title"
                    label="Статус *"
                    placeholder="ВРЕМЕННОЕ поле_удл_статусы - реализация другой итерации"
                    v-model="book.status"
                    type="text"
                    :dense="dense"
                  )
              q-btn(
                color="primary"
                label="СОХРАНИТЬ"
                @click=""
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
	export default {
		data: function () {
			return {}
		},
		created() {
		},
		methods: {
		},
		components: {
		}
	}
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
