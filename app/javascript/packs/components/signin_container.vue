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
      <router-link :to="{ name: 'sign_up'}">アカウント作成</router-link>
    </div>
  </div>
</template>

<script lang="ts">
import axios from "axios";
import { Vue, Component } from "vue-property-decorator";
import { localStorageGetitem } from "../utils/auth";
import VueRouter from "vue-router";
Vue.use(VueRouter);
const SIGNIN_ERROR_MESSAGE = "メールアドレスかパスワードが間違ってますけども！";

@Component
export default class SigninContainer extends Vue {
  email: string = "";
  password: string = "";

  async signIn(): Promise<void> {
    const params = { email: this.email, password: this.password };
    await axios
      .post("/api/v1/auth/sign_in", params)
      .then(response => {
        localStorageGetitem(response);
        this.$router.push({ name: "home" });
        window.location.reload();
      })
      .catch(() => {
        alert(SIGNIN_ERROR_MESSAGE);
      });
  }
}
</script>