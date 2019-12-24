<template lang="pug">
  div
    q-list(padding)
      q-item(v-ripple)
        q-item-section(avatar)
          q-icon(color="red" name="warning")
        q-item-section
          | ADMIN mode
      q-item(to="/admin_books" v-ripple)
        q-item-section(avatar)
          q-icon(name="library_books")
        q-item-section
          | Книги
      q-item(to="/admin_categories" v-ripple)
        q-item-section(avatar)
          q-icon(name="all_inbox")
        q-item-section
          | Категории
      q-item(to="/admin_users" v-ripple)
        q-item-section(avatar)
          q-icon(name="supervised_user_circle")
        q-item-section
          | Пользователи
</template>