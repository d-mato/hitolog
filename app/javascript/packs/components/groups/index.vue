<template>
  <div>
    <tool-bar title="Group List"></tool-bar>
    <div style="margin-top: 60px"></div>

    <button class="btn btn-primary" v-if="!new_mode" @click="new_mode = true">New</button>
    <template v-if="new_mode">
      <form @submit.prevent="submit">
        Name: <input class="form-control" v-model="new_group.name">
        <input type="submit" class="btn btn-primary" value="Submit">
        <input type="reset" class="btn btn-default" @click="new_mode = false" value="Cancel">
      </form>
    </template>

    <p>{{ message }}</p>

    <div class="list-group">
      <router-link v-for="item in items" :to="`/groups/${item.id}`" :key="item.id" class="list-group-item list-group-item-action">{{ item.name }}</router-link>
    </div>
  </div>
</template>

<script>
import axios from '../../axios'
import ToolBar from '../toolbar'

export default {
  components: { ToolBar },
  data: function () {
    return {
      new_mode: false,
      new_group: {},
      items: [],
      message: ''
    }
  },
  created() {
    axios.get('/api/groups')
      .then((res) => {
        this.items = res.data
      })
      .catch((err) => {
      })
  },
  methods: {
    submit() {
      axios.post('/api/groups', this.new_group)
        .then((res) => {
          this.items.push(res.data)
          this.new_group = {}
          this.new_mode = false
          this.$ons.notification.alert('Created!')
        })
        .catch((err) => {
          console.log(err)
          this.message = 'Error!'
        })
    }
  }
}
</script>

<style scoped>
</style>
