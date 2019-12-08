import axios from 'axios'

export function backendCurrentUser () {
	return axios.get('/users/index/me');
}

export function backendGetUsers () {
	return axios.get('/users/index');
}

export function backendPostUser (params) {
	return axios.post('/users/index', params);
}

export function backendDeleteUser (id) {
	return axios.delete('/users/index/' + id);
}

export function backendGetBooks () {
	return axios.get('/books');
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


