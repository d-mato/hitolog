<template>
  <div>
    <h2>Group List</h2>

    <button @click="new_mode = true">New</button>
    <template v-if="new_mode">
      <form @submit.prevent="submit">
        Name: <input v-model="new_group.name">
        <input type="submit">
      </form>
      <button @click="new_mode = false">Cancel</button>
    </template>

    <p>{{ message }}</p>

    <ul>
      <li v-for="item in items">
        <router-link :to="`/groups/${item.id}`">{{ item.name }}</router-link>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from '../../axios'
export default {
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
