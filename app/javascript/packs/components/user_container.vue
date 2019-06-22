<template>
  <div id="user-container">
    <h2>{{ user.name }}</h2>
    <router-link
      :to="{ name: 'user_edit', params: { id: this.$route.params.id }}"
      class="btn btn-primary"
    >ユーザー情報編集</router-link>
    <b-tabs class="mt-5" content-class="mt-3">
      <b-tab title="記事一覧" active>
        <ul>
          <li class="article" v-for="article in articles" :key="article.id">
            <router-link :to="{ name : 'article', params: { id: article.id }}">
              <div>{{ article.title }}</div>
            </router-link>
            <div>{{ article.body }}</div>
          </li>
        </ul>
        <infinite-loading @infinite="infiniteHandler"></infinite-loading>
      </b-tab>
      <b-tab title="いいね一覧">
        <p>未実装</p>
      </b-tab>
    </b-tabs>
  </div>
</template>

<script lang="ts">
import axios from "axios";
import { Vue, Component } from "vue-property-decorator";
import InfiniteLoading from "vue-infinite-loading";
Vue.use(InfiniteLoading);

@Component
export default class UserContainer extends Vue {
  user: string[] = [];
  articles: string[] = [];
  articlesList: string[] = [];
  page: number = 0;

  //記事一覧無限スクロール
  infiniteHandler($state) {
    axios
      .get(`/api/v1/users/${this.$route.params.id}`, {
        params: {
          page: this.page
        }
      })
      .then(({ data }) => {
        this.user = data;
        this.articlesList = data.articles.slice(this.page, this.page + 10);
        if (this.articlesList.length) {
          this.articles.push(...this.articlesList);
          this.page += 10;
          $state.loaded();
        } else {
          $state.complete();
        }
      });
  }
}
</script>

<style scoped lang="scss">
.article {
  border-bottom: 1px solid #ccc;
  padding: 10px;
}
</style>