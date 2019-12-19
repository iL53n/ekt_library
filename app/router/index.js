import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter);
import AdminBooks from '../javascript/components/Tables/Admin/AdminBooksTable'
import AdminUsers from '../javascript/components/Tables/Admin/AdminUsersTable'
import AdminCategories from '../javascript/components/Tables/Admin/AdminCategoriesTable'
import Books from '../javascript/components/Tables/User/BooksTable'
import ReadingBooks from '../javascript/components/Tables/User/ReadingTable'
import CreateBook from '../javascript/components/BooksForm/CreateBook'
import CreateUser from '../javascript/components/UsersForm/CreateUser'
import CreateCategory from '../javascript/components/CategoriesForm/CreateCategory'
import EditBook from '../javascript/components/BooksForm/EditBook'
import EditUser from '../javascript/components/UsersForm/EditUser'
import EditCategory from '../javascript/components/CategoriesForm/EditCategory'
import ShowBook from '../javascript/components/BooksForm/ShowBook'
import GiveOutBook from '../javascript/components/BooksForm/BookingMenu'


export default new VueRouter({
	mode: 'history',
	hashbang: false,
	routes: [
		{ path: '/', redirect: '/list_books' },
		{
			path: '/list_books', component: Books,
			children: [
				{ path: ':id/', component: ShowBook, name: 'showBook' },
			],
		},
		{ path: '/reading_books', component: ReadingBooks, name: 'readingBooks' },
		{ path: '/admin_books', component: AdminBooks,
			children: [
				{ path: 'create', component: CreateBook, name: 'createBook' },
				{ path: ':id/edit', component: EditBook, name: 'editBook' },
				{ path: ':id/give_out', component: GiveOutBook, name: 'giveOutBook' },
			],
		},
		{ path: '/admin_users', component: AdminUsers,
			children: [
				{ path: 'create', component: CreateUser, name: 'createUser' },
				{ path: ':id/edit', component: EditUser, name: 'editUser' },
			],
		},
		{ path: '/admin_categories', component: AdminCategories,
			children: [
				{ path: 'create', component: CreateCategory, name: 'createCategory' },
				{ path: ':id/edit', component: EditCategory, name: 'editCategory' },
			],
		}
	]
})