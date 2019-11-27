import axios from 'axios'

export function backendGetUser () {
	return axios.get('/users/index/user');
}
