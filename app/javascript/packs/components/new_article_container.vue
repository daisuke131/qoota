<template>
  <div class="container">
    <ArticleForm
    title = ""
    body = ""
    :status = "status_select"
    @submit="postNew"
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
  export default class NewArticleContainer extends Vue {
    status_select = statusSelect
    currentStorage = {
      headers: {
        "access-token": localStorage["access-token"],
        "client": localStorage["client"],
        "uid": localStorage["uid"]
      }
    }

    postNew(params) {
      axios.post("/api/v1/articles", params, this.currentStorage).then((response) => {
        this.$router.push({ name: "home" })
      }).catch(() => {
        alert("だめ")
      })
    }
  }
</script>