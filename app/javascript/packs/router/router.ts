import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import HomeContainer from '../components/home_container.vue'
import SigninContainer from '../components/signin_container.vue'

Vue.use(VueRouter)
export default new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', name: 'home', component: HomeContainer },
    { path: '/sign_in', name: 'sign_in', component: SigninContainer },
  ],
})