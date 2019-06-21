import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import HomeContainer from '../components/home_container.vue'
import SigninContainer from '../components/signin_container.vue'
import SignupContainer from '../components/signup_container.vue'
import UserContainer from '../components/user_container.vue'
import EditUserContainer from '../components/edit_user_container.vue'
import ArticleContainer from '../components/article_container.vue'
import NewArticleContainer from '../components/new_article_container.vue'
import EditArticleContainer from '../components/edit_article_container.vue'
import { isSignIn } from '../utils/auth'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', name: 'home', component: HomeContainer },
    { path: '/sign_in', name: 'sign_in', component: SigninContainer },
    { path: '/sign_up', name: 'sign_up', component: SignupContainer },
    { path: '/user/:id', name: 'user', component: UserContainer },
    { path: '/user/edit/:id', name: 'user_edit', component: EditUserContainer },
    { path: '/article/:id', name: 'article', component: ArticleContainer },
    { path: '/article/new', name: 'article_new', component: NewArticleContainer, meta: { requiresAuth: true } },
    { path: '/article/edit/:id', name: 'article_edit', component: EditArticleContainer, meta: { requiresAuth: true } },
  ],
})

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (!isSignIn()) {
      alert("ログインして")
      next({
        path: '/sign_in',
        query: { redirect: to.fullPath }
      })
    } else {
      next()
    }
  } else {
    next()
  }
})

export default router