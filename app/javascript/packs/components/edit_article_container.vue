<template>
  <div class="container">
    <ArticleForm
    :title = "article.title"
    :body = "article.body"
    :status = "article.status"
    @submit="postEdit"
    ></ArticleForm>
  </div>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"
  import ArticleForm from './article_form_container.vue'

  const statusSelect = "published"

  @Component ({
    components: { ArticleForm },
  })
  export default class EditArticleContainer extends Vue {
    article: String[] = []
    status = statusSelect
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

    postEdit(params) {
      axios.put(`/api/v1/articles/${ this.$route.params.id }`, params, this.currentStorage).then((response) => {
        this.$router.push({ name: "home" })
      }).catch(() => {
        alert("だめ")
      })
    }
  }
</script>