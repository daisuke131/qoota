<template>
  <div class="container">
    <ArticleForm title body :status="statusSelect" @submit="postNew"></ArticleForm>
  </div>
</template>

<script lang="ts">
import axios from "axios";
import { Vue, Component } from "vue-property-decorator";
import ArticleForm from "./article_form_container.vue";
import { getHeaders } from "../utils/auth";

const STATUS_SELECT = "published";

@Component({
  components: { ArticleForm }
})
export default class NewArticleContainer extends Vue {
  statusSelect: string = STATUS_SELECT;

  postNew(params) {
    axios
      .post("/api/v1/articles", params, getHeaders())
      .then(response => {
        this.$router.push({ name: "home" });
      })
      .catch(error => {
        alert("だめ");
      });
  }
}
</script>