<template>
  <div>
    <h2>Person Detail</h2>
    <template v-if="!edit_mode">
      <ul>
        <li>Name: {{ person.name }}</li>
        <li>Sex: {{ person.sex }}</li>
        <li>Updated at: {{ person.updated_at }}</li>
      </ul>

      <button @click="edit_mode = true">edit</button>
      <button @click="del">del</button>
    </template>

    <template v-if="edit_mode">
      edit
      <form @submit.prevent="save">
        <div>
          Name: <input v-model="person.name">
        </div>
        <div>
          Sex:
          <select v-model="person.sex">
            <option value=""></option>
            <option value="male">Male</option>
            <option value="female">Female</option>
          </select>
        </div>
        <input type="submit" value="save">
      </form>

      <button @click="edit_mode = false">Cancel</button>
    </template>

    <p>{{ message }}</p>
  </div>
</template>

<script>
import axios from '../../axios'
export default {
  data: function () {
    return {
      edit_mode: false,
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
    save() {
      axios.patch(`/api/people/${this.$route.params.id}`, this.person)
        .then((res) => {
          this.message = 'Success'
          this.edit_mode = false
        })
        .catch((err) => {
          this.message = 'Error'
          console.log(err)
        })
    },

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
