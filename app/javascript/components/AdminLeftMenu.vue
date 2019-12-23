<template lang="pug">
  div
    h5(align="center") Администрирование
    q-route-tab(to="/admin_books" name="books" icon="library_books" label="Книги")
    q-route-tab(to="/admin_categories" name="categories" icon="all_inbox" label="Категории")
    q-route-tab(to="/admin_users" name="users" icon="supervised_user_circle" label="Пользователи")
</template>