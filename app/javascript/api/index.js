import axios from 'axios'

// users
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

// books
export function backendGetBooks (params) {
	return axios.get('/books', { params: params });
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

// categories
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

// Posts
export function indexPosts () {
	return axios.get('/posts');
}
export function createPost (post) {
	return axios.post('/posts', post);
}
// export function showPost (id) {
// 	return axios.get('/posts/' + id);
// }
// export function updatePost (post) {
// 	return axios.patch('/posts/' + post.id, post);
// }
// export function destroyPost (id) {
// 	return axios.delete('/posts/' + id);
// }


