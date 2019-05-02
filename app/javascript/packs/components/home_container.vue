<template>
  <div id="home-container">
    <ol>
      <li v-for="article in articles" b-bind:key="article.id">
        <div>タイトル：{{article.title}}</div>
        <div>内容：{{article.body}}</div>
      </li>
    </ol>
  </div>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"

  @Component
  export default class HomeContainer extends Vue {
    articles: String[] = []

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
  }
</script>

<style scoped>
ol li {
  padding: 10px;
  border-bottom: 1px solid #ccc;
}
</style>