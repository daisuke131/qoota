<template>
  <header>
    <div class="container">
      <b-navbar toggleable="lg" type="dark">
        <b-navbar-brand to="/">Qiita</b-navbar-brand>
        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>
        <b-collapse id="nav-collapse" is-nav>

          <b-navbar-nav class="ml-auto">
            <b-nav-item-dropdown right v-if="isSignedIn()">
              <template slot="button-content"><em>{{ name }}</em></template>
              <b-dropdown-item :to="{ name: 'user', params: { id: currentUserId }}">ユーザー情報</b-dropdown-item>
              <b-dropdown-item @click="signOut">サインアウト</b-dropdown-item>
            </b-nav-item-dropdown>
            <b-nav-item v-else :to="{ name: 'sign_in'}">サインイン</b-nav-item>
            <router-link class="mr-3 btn btn-success" :to="{ name: 'article_new'}">投稿</router-link>
            <b-nav-form>
              <b-form-input size="sm" class="mr-sm-2" placeholder="Search"></b-form-input>
            </b-nav-form>
          </b-navbar-nav>

        </b-collapse>
      </b-navbar>
    </div>
  </header>
</template>

<script lang="ts">
  import axios from "axios";
  import { Vue, Component } from "vue-property-decorator"
  import VueRouter from "vue-router"
  import { isSignIn, getHeaders } from "../utils/auth"
  import BootstrapVue from "bootstrap-vue"
  import "bootstrap/dist/css/bootstrap.css"
  import "bootstrap-vue/dist/bootstrap-vue.css"
  Vue.use(BootstrapVue)
  Vue.use(VueRouter)

  @Component
  export default class HeaderContainer extends Vue {
    currentUserId = localStorage.getItem("current-user-id")
    user = []
    name = ""

    async signOut(): Promise<void> {
      await axios.delete("/api/v1/auth/sign_out", getHeaders()).then(() => {
        localStorage.clear();
        alert("サインアウト")
        this.$router.push({ name: "sign_in" })
        window.location.reload();
      }).catch(() => {
        alert("サインアウト失敗")
        localStorage.clear();
        this.$router.push({ name: "sign_in" })
        window.location.reload();
      })
    }

    getUserName() {
      axios.get(`/api/v1/users/${ this.currentUserId }`).then((response) => {
        this.name = response.data.name
      }).catch(() => {
        alert("タイムアウト")
        this.$router.push({ name: "sign_in" })
      })
    }

    // サインインしてるかどうかの判定
    isSignedIn() {
      const signedInFlg = isSignIn()
      if(signedInFlg) {
        this.getUserName()
      }
      return signedInFlg
    }
  }
</script>

<style scoped>
  header {
    background-color: #00acee;
  }
</style>