<template>
  <div class="container">
    <div class="devise_form">
      <div class="field">
        <h2>Sign in!</h2>
      </div>
      <form v-on:submit.prevent="signIn">
        <div class="field">
          <input type="text" name="email" placeholder="email" v-model="email">
        </div>
        <div class="field">
          <input type="password" name="password" placeholder="password" v-model="password">
        </div>
        <div class="field">
          <button type="submit">Sign in</button>
        </div>
      </form>
    </div>
  </div>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"
  import Router from "../router/router"

  const SIGNIN_ERROR_MESSAGE = "メールアドレスかパスワードが間違ってますけども！"

  @Component
  export default class LoginContainer extends Vue {
    email: string
    password: string

    async signIn(): Promise<void> {
      const params = { email: this.email, password: this.password }
      await axios.post("/api/v1/auth/sign_in", params ).then((response) => {
        localStorage.setItem("access-token", response.headers["access-token"]);
        localStorage.setItem("uid", response.headers["uid"]);
        localStorage.setItem("client", response.headers["client"]);
        Router.push({ name: "home" })
      }).catch(() => {
        alert(SIGNIN_ERROR_MESSAGE)
      })
    }
  }
</script>

<style scoped>
</style>