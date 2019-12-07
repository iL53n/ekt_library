import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter);
import AdminBooks from '../javascript/components/Tables/AdminBooksTable'
import AdminUsers from '../javascript/components/Tables/AdminUsersTable'
import Books from '../javascript/components/Tables/BooksTable'
import CreateBook from '../javascript/components/BooksForm/CreateBook'
import EditBook from "../javascript/components/BooksForm/EditBook"
import ShowBook from "../javascript/components/BooksForm/ShowBook"


export default new VueRouter({
	mode: 'history',
	hashbang: false,
	routes: [
		{ path: '/', redirect: '/list_books' },
		{
			path: '/list_books', component: Books,
			children: [
				{ path: ':id/', component: ShowBook, name: 'showBook' }
			],
		},
		{ path: '/admin_books', component: AdminBooks,
			children: [
				{ path: 'create', component: CreateBook, name: 'createBook' },
				{ path: ':id/edit', component: EditBook, name: 'editBook' },
			],
		},
		{ path: '/users', component: AdminUsers,
			children: [
				// { path: 'create', component: CreateBook, name: 'createBook' },
				// { path: ':id/edit', component: EditBook, name: 'editBook' },
			],
		}
	]
})