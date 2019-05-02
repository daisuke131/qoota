import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import HomeContainer from '../components/home_container.vue'

Vue.use(VueRouter)
export default new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: HomeContainer },
  ],
})