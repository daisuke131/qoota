<template>
  <div id="article-container">
    <div>タイトル：{{article.title}}</div>
    <div>内容：{{article.body}}</div>
    <router-link :to="{ name : 'post_edit', params : { id: article.id }}">修正</router-link>
    <a class="nav-link" href="#" @click="deleteArticle">削除</a>
  </div>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"

  @Component
  export default class ArticleContainer extends Vue {
    article: String[] = []
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
      await axios.get(`/api/v1/articles/${ this.$route.params.id }`).then((response) => {
        this.article = response.data
      })
    }

    async deleteArticle(): Promise<void> {
      axios.delete(`/api/v1/articles/${this.$route.params.id}`, this.currentStorage).then((response) => {
        alert("削除")
        this.$router.push({ name: "home" })
      })
    }
  }
</script>

<style scoped>
ul li {
  padding: 10px;
  border-bottom: 1px solid #ccc;
  list-style: none;
}
</style>