<template>
  <div id="signup-container">
    <div class="devise_form">
      <div class="field">
        <h2>Edit user</h2>
      </div>
      <div
        class="error-message"
        v-for="errorMessage in errorMessages"
        :key="errorMessage"
      >{{ errorMessage }}</div>
      <form>
        <div class="form-label">username</div>
        <div class="field">
          <input type="text" name="name" placeholder="name" v-model="name">
        </div>
        <div class="form-label">email</div>
        <div class="field">
          <input type="text" name="email" placeholder="email" v-model="email">
        </div>
        <div class="form-label">password</div>
        <div class="field">
          <input type="password" name="password" placeholder="password" v-model="password">
        </div>
        <div class="field">
          <button type="submit" class="btn btn-primary" @click.prevent="editUser">Edit</button>
        </div>
      </form>
    </div>
  </div>
</template>

<script lang="ts">
import axios from "axios";
import { Vue, Component } from "vue-property-decorator";
import { getHeaders } from "../utils/auth";

@Component
export default class EditUserContainer extends Vue {
  name: string = "";
  email: string = "";
  password: string = "";
  errorMessages: string[] = [];

  async mounted(): Promise<void> {
    await this.fetchHome();
  }

  async fetchHome(): Promise<void> {
    await axios.get(`/api/v1/users/${this.$route.params.id}`).then(response => {
      this.name = response.data.name;
      this.email = response.data.email;
    });
  }

  async editUser(): Promise<void> {
    const params = { name: this.name, email: this.email };
    await axios
      .patch(`/api/v1/users/${this.$route.params.id}`, params, getHeaders())
      .then(response => {
        this.$router.push({
          name: "user",
          params: { id: this.$route.params.id }
        });
        localStorage.setItem("uid", this.email);
        window.location.reload();
      })
      .catch(error => {
        this.errorMessages = error.response.data.errors.full_messages;
      });
  }
}
</script>

<style scoped lang="scss">
.form-label {
  text-align: left;
  color: white;
  padding: 0 10px;
}
</style>