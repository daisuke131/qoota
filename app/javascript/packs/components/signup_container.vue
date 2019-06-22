<template>
  <div id="signup-container">
    <div class="devise_form">
      <div class="field">
        <h2>Sign up!</h2>
      </div>
      <div
        class="error-message"
        v-for="errorMessage in errorMessages"
        :key="errorMessage"
      >{{ errorMessage }}</div>
      <form>
        <div class="field">
          <input type="text" name="name" placeholder="name" v-model="name">
        </div>
        <div class="field">
          <input type="text" name="email" placeholder="email" v-model="email">
        </div>
        <div class="field">
          <input type="password" name="password" placeholder="password" v-model="password">
        </div>
        <div class="field">
          <button type="submit" class="btn btn-primary" @click.prevent="signUp">Sign up</button>
        </div>
      </form>
    </div>
  </div>
</template>

<script lang="ts">
import axios from "axios";
import { Vue, Component } from "vue-property-decorator";
const SIGNIN_ERROR_MESSAGE = "メールアドレスかパスワードが間違ってますけども！";

@Component
export default class SignupContainer extends Vue {
  name: string = "";
  email: string = "";
  password: string = "";
  errorMessages: string[] = [];

  async signUp(): Promise<void> {
    const params = {
      name: this.name,
      email: this.email,
      password: this.password
    };
    await axios
      .post("/api/v1/auth", params)
      .then(response => {
        this.$router.push({ name: "sign_in" });
      })
      .catch(error => {
        this.errorMessages = error.response.data.errors.full_messages;
      });
  }
}
</script>