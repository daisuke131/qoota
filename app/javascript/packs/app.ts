import Vue from 'vue/dist/vue.esm'
import Router from './router/router'
import headernavi from './components/header_container.vue'

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#app',
    router: Router,
    components: {
      headernavi,
    }
  })
})