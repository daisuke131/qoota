<template>
  <div class="container">
    <PostForm
    :title = "article.title"
    :body = "article.body"
    :status = "article.status"
    @submit="postEdit"
    ></PostForm>
  </div>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component } from "vue-property-decorator"
  import PostForm from './post_form_container.vue'

  const STATUS_SELECT = "published"

  @Component ({
    components: { PostForm },
  })
  export default class EditPostContainer extends Vue {
    article: String[] = []
    status = STATUS_SELECT
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