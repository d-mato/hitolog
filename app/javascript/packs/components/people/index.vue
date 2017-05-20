<template>
  <div>
    <h2>People List</h2>
    <ul>
      <li v-for="person in people">
        <router-link :to="`/people/${person.id}`">{{ person.name }}</router-link>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from '../../axios'
export default {
  data: function () {
    return {
      people: []
    }
  },
  created() {
    axios.get('/api/people')
      .then((res) => {
        this.people = res.data
      })
      .catch((err) => {
      })
  }
}
</script>

<style scoped>
</style>
