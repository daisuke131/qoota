<template>
  <div id="signin-container">
    <div class="devise_form">
      <div class="field">
        <h2>Sign in!</h2>
      </div>
      <form>
        <div class="field">
          <input type="text" name="email" placeholder="email" v-model="email">
        </div>
        <div class="field">
          <input type="password" name="password" placeholder="password" v-model="password">
        </div>
        <div class="field">
          <button type="submit" class="btn btn-primary" @click.prevent="signIn">Sign in</button>
        </div>
      </form>
    </div>
  </div>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"
  import { localStorageSetitem } from "../utils/auth"
  const SIGNIN_ERROR_MESSAGE = "メールアドレスかパスワードが間違ってますけども！"

  @Component
  export default class LoginContainer extends Vue {
    email = ""
    password = ""

    async signIn(): Promise<void> {
      const params = { email: this.email, password: this.password }
      await axios.post("/api/v1/auth/sign_in", params ).then((response) => {
        localStorageSetitem(response)
        this.$router.push({ name: "home" })
      }).catch(() => {
        alert(SIGNIN_ERROR_MESSAGE)
      })
    }
  }
</script>