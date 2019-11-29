import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter);
import Test from '../javascript/components/Profile'

export default new VueRouter({
	mode: 'history',
	hashbang: false,
	routes: [
		{ path: '/profile', component: Test }
	]
})