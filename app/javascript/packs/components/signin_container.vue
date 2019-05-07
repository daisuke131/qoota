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
      debugger
      await axios.post("/api/v1/auth/sign_in", params ).then((response) => {
        Router.push({ name: "home" })
      }).catch(() => {
        alert(SIGNIN_ERROR_MESSAGE)
      })
    }
  }
</script>

<style scoped>
.container {
  padding: 20px;
}
</style>