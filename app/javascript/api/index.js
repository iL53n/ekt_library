import axios from 'axios'

export function backendGetUser () {
	return axios.get('/users/index/user');
}

export function backendGetBooks () {
	return axios.get('/books');

}export function backendGetBook (id) {
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


