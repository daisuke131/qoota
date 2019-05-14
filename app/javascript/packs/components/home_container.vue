<template>
  <div class="container">
    <a v-if="token != null" href="#" @click="signOut">サインアウト</a>
    <ul>
      <li v-for="article in articles" :key="article.id">
        <div>タイトル：{{article.title}}</div>
        <div>内容：{{article.body}}</div>
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"
  import Router from "../router/router"

  @Component
  export default class HomeContainer extends Vue {
    articles: String[] = []
    token: string = localStorage["access-token"]
    currentStorage = {
      headers: {
        "access-token": localStorage["access-token"],
        "client": localStorage["client"],
        "uid": localStorage["uid"]
      }
    }

    async mounted(): Promise<void> {
      await this.fetchHome();
    }

    async fetchHome(): Promise<void> {
      await axios.get("/api/v1/articles").then((response) => {
        response.data.map((article: any) => {
          this.articles.push(article);
        })
      })
    }

    async signOut(): Promise<void> {
      await axios.delete("/api/v1/auth/sign_out", this.currentStorage).then(() => {
        localStorage.clear();
        alert("サインアウト")
        Router.push({ name: "sign_in" })
      }).catch(() => {
        alert("サインアウト失敗")
      })
    }
  }
</script>

<style scoped>
  ul li {
    padding: 10px;
    border-bottom: 1px solid #ccc;
  }
</style>