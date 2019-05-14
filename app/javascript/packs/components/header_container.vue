<template>
  <header>
    <div class="container">
      <nav class="navbar navbar-expand-lg navbar-dark">
        <router-link to="/" class="navbar-brand">Qiita</router-link>
        <button
          class="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item">
              <router-link class="nav-link" :to="{ name: 'sign_in'}">サインイン</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" :to="{ name: 'article_new'}">投稿</router-link>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#" @click="signOut">サインアウト</a>
            </li>
          </ul>
          <form class="form-inline my-2 my-lg-0">
            <input
              class="form-control mr-sm-2"
              type="text"
              placeholder="Search"
              aria-label="Search"
            >
          </form>
        </div>
      </nav>
    </div>
  </header>
</template>

<script lang="ts">
  import axios from "axios";
  import { Vue, Component } from "vue-property-decorator"
  import VueRouter from "vue-router"
  import BootstrapVue from "bootstrap-vue"
  import "bootstrap/dist/css/bootstrap.css"
  import "bootstrap-vue/dist/bootstrap-vue.css"
  Vue.use(BootstrapVue)
  Vue.use(VueRouter)

  @Component
  export default class HeaderContainer extends Vue {
    currentStorage = {
      headers: {
        "access-token": localStorage["access-token"],
        "client": localStorage["client"],
        "uid": localStorage["uid"]
      }
    }

    async signOut(): Promise<void> {
      await axios.delete("/api/v1/auth/sign_out", this.currentStorage).then(() => {
        localStorage.clear();
        alert("サインアウト")
        this.$router.push({ name: "sign_in" })
      }).catch(() => {
        alert("サインアウト失敗")
      })
    }
  }
</script>

<style scoped>
  header {
    background-color: #00acee;
  }
</style>