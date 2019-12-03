import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter);
import AdminBooks from '../javascript/components/Tables/AdminBooksTable'
import Books from '../javascript/components/Tables/BooksTable'
import CreateBook from '../javascript/components/BooksForm/CreateBook'
import EditBook from "../javascript/components/BooksForm/EditBook";

export default new VueRouter({
	mode: 'history',
	hashbang: false,
	routes: [
		{ path: '/', redirect: '/books' },
		{ path: '/books', component: Books },
		{ path: '/admin_books', component: AdminBooks,
			children: [
				{ path: 'create', component: CreateBook, name: 'createBook' },
				{ path: ':id/edit', component: EditBook, name: 'editBook' }
			],
		}
	]
})