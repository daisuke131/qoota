<template>
  <div class="container">
    <PostForm
    title = ""
    body = ""
    :status = "status_select"
    @submit="postNew"
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
  export default class NewPostContainer extends Vue {
    status_select = STATUS_SELECT
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