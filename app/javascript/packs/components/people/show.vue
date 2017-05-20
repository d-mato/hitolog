<template>
  <div>
    <h2>Person Detail</h2>
    <ul>
      <li>Name: {{ person.name }}</li>
      <li>Sex: {{ person.sex }}</li>
      <li>Updated at: {{ person.updated_at }}</li>
    </ul>

    <button @click.prevent="del">del</button>
    <p>{{ message }}</p>
  </div>
</template>

<script>
import axios from '../../axios'
export default {
  data: function () {
    return {
      person: {},
      message: ''
    }
  },
  created() {
    axios.get(`/api/people/${this.$route.params.id}`)
      .then((res) => {
        this.person = res.data
      })
      .catch((err) => {
        console.log(err)
      })
  },
  methods: {
    del() {
      if (confirm('Are you sure?')) {
        axios.delete(`/api/people/${this.$route.params.id}`)
          .then((res) => {
            this.message = 'Success'
            this.$router.push('/people')
          })
          .catch((err) => {
            this.message = 'Error'
            console.log(err)
          })
      }
    }
  }
}
</script>

<style scoped>
</style>
