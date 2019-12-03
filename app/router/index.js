import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter);
import AdminBooks from '../javascript/components/AdminBooksTable'
import Books from '../javascript/components/BooksTable'

export default new VueRouter({
	mode: 'history',
	hashbang: false,
	routes: [
		{ path: '/', redirect: '/books' },
		{ path: '/books', component: Books },
		{ path: '/admin_books', component: AdminBooks }
	]
})