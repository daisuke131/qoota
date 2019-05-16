<template>
  <div class="container">
    <ArticleForm
    title = ""
    body = ""
    :status = "statusSelect"
    @submit="postNew"
    ></ArticleForm>
  </div>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"
  import ArticleForm from './article_form_container.vue'

  const STATUS_SELECT = "published"

  @Component ({
    components: { ArticleForm },
  })
  export default class NewArticleContainer extends Vue {
    statusSelect = STATUS_SELECT
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