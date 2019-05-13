<template>
  <div class="container">
    <form>
      <div class="field">
        <input class="w-100" type="text" name="title" placeholder="タイトル" v-model="title">
      </div>
      <div class="d-flex">
        <div class="field col-6 p-0">
          <textarea class="w-100" name="body" v-model="body"/>
        </div>
        <div class="field col-6 p-0 border">
          {{ body }}
        </div>
      </div>
      <div class="field">
        <select name="status" v-model="status">
          <option selected value="published">公開</option>
          <option value="draft">下書き</option>
        </select>
      </div>
      <button type="submit" class="btn btn-primary" @click.prevent="submit">投稿</button>
    </form>
  </div>
</template>

<script lang="ts">
  import axios from "axios"
  import { Vue, Component, Prop, Emit } from "vue-property-decorator"

  @Component
  export default class PostContainer extends Vue {
    form_data = {}
    @Prop(String)title
    @Prop(String)body
    @Prop(String)status
    @Emit()
    submit() {
      return this.form_data = { title: this.title, body: this.body, status: this.status }
    }
  }
</script>

<style scoped>
</style>