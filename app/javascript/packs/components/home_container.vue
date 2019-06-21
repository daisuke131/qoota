<template>
  <div id="home-container">
    <ul>
      <li v-for="article in articles" :key="article.id">
        <router-link :to="{ name : 'article', params: { id: article.id }}">
          <div>{{article.title}}</div>
        </router-link>
        <div>{{article.body}}</div>
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"
  import VueRouter from 'vue-router'
  Vue.use(VueRouter);

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
  ul li {
    padding: 10px;
    border-bottom: 1px solid #ccc;
  }
</style>