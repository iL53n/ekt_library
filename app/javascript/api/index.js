import axios from 'axios'

export function backendCurrentUser () {
	return axios.get('/users/index/me');
}

export function backendGetUsers () {
	return axios.get('/users/index');
}

export function backendGetUser (id) {
	return axios.get('/users/index/' + id);
}

export function backendPostUser (params) {
	return axios.post('/users/index', params);
}

export function backendPatchUser (user) {
	return axios.patch('/users/index/' + user.id, user);
}

export function backendDeleteUser (id) {
	return axios.delete('/users/index/' + id);
}

export function backendGetBooks () {
	return axios.get('/books');
}

export function backendGetReadingBooks () {
	return axios.get('/books/reading');
}

export function backendGetReservedBooks () {
	return axios.get('/books/reserved');
}

export function backendGetReadedBooks () {
	return axios.get('/books/readed');
}

export function backendGetBook (id) {
	return axios.get('/books/' + id);
}

export function backendPostBook (params) {
	return axios.post('/books', params);
}

export function backendPatchBook (book) {
	return axios.patch('/books/' + book.id, book);
}

export function backendDeleteBook (id) {
	return axios.delete('/books/' + id);
}

export function backendGetCategories () {
	return axios.get('/categories');
}

export function backendGetCategory (id) {
	return axios.get('/categories/' + id);
}

export function backendPostCategory (params) {
	return axios.post('/categories', params);
}

export function backendPatchCategory (category) {
	return axios.patch('/categories/' + category.id, category);
}

export function backendDeleteCategory (id) {
	return axios.delete('/categories/' + id);
}

export function backendBookingBook (book) {
	return axios.patch('/books/' + book.id + '/booking');
}

export function backendGiveOutBook (book) {
	return axios.patch('/books/' + book.id + '/give_out', book);
}

export function backendReturnBook (book) {
	return axios.patch('/books/' + book.id + '/return');
}
