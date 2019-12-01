import axios from 'axios'

export function backendGetUser () {
	return axios.get('/users/index/user');
}

export function backendGetBooks () {
	return axios.get('/books');
}

export function backendPostBook (params) {
	return axios.post('/books', params);
}


