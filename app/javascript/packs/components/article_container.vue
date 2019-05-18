<template>
  <div id="article-container">
    <div>タイトル：{{article.title}}</div>
    <div>内容：{{article.body}}</div>
    <div v-if="currentUserID == userID">
      <router-link :to="{ name : 'article_edit', params : { id: article.id }}">修正</router-link>
      <a class="nav-link" href="#" @click="deleteArticle">削除</a>
    </div>
  </div>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"
  import { getHeaders } from "../utils/auth"

  @Component
  export default class ArticleContainer extends Vue {
    article: String[] = []
    userID = ""
    currentUserID = localStorage.getItem("current-user-id")

    async mounted(): Promise<void> {
      await this.fetchHome();
    }

    async fetchHome(): Promise<void> {
      await axios.get(`/api/v1/articles/${ this.$route.params.id }`).then((response) => {
        this.article = response.data
        this.userID = response.data.user_id
      })
    }

    async deleteArticle(): Promise<void> {
      axios.delete(`/api/v1/articles/${this.$route.params.id}`, getHeaders()).then((response) => {
        alert("削除")
        this.$router.push({ name: "home" })
      })
    }
  }
</script>