import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import HomeContainer from '../components/home_container.vue'
import SigninContainer from '../components/signin_container.vue'
import ArticleContainer from '../components/article_container.vue'
import PostNewContainer from '../components/post_new_container.vue'
import PostEditContainer from '../components/post_edit_container.vue'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', name: 'home', component: HomeContainer },
    { path: '/sign_in', name: 'sign_in', component: SigninContainer },
    { path: '/article/:id', name: 'article', component: ArticleContainer },
    { path: '/post/new', name: 'post_new', component: PostNewContainer, meta: { requiresAuth: true } },
    { path: '/post/edit/:id', name: 'post_edit', component: PostEditContainer, meta: { requiresAuth: true } },
  ],
})

export default router