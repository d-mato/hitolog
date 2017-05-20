<template>
  <div>
    <h2>Person Detail</h2>
    <template v-if="!edit_mode">
      <a href="#" @click.prevent="$router.go(-1)">back</a>
      <ul>
        <li>Name: {{ person.name }}</li>
        <li>Sex: {{ person.sex }}</li>
        <li>Groups:
          <span class="badge badge-default" v-for="group in person.groups">{{ group.name }}</span>

        </li>
        <li>Updated at: {{ person.updated_at }}</li>
      </ul>

      <button class="btn btn-primary" @click="edit_mode = true">edit</button>
      <button class="btn btn-danger" @click="del">del</button>
    </template>

    <template v-if="edit_mode">
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
        <div>
          <label v-for="group in groups"><input type="checkbox" :value="group.id" v-model="group_ids">{{group.name}}</label>
        </div>
        <input type="submit" value="save" class="btn btn-primary">
      </form>

      <button @click="edit_mode = false" class="btn btn-default">Cancel</button>
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
      group_ids: [],
      person: {},
      groups: [],
      message: ''
    }
  },
  created() {
    axios.get('/api/groups')
      .then((res) => {
        this.groups = res.data
      })

    axios.get(`/api/people/${this.$route.params.id}`)
      .then((res) => {
        this.person = res.data
        this.group_ids = this.person.groups.map( (group) => group.id )
      })
      .catch((err) => {
        console.log(err)
      })
  },
  methods: {
    save() {
      let params = {
        person: {
          name: this.person.name,
          sex: this.person.sex,
        },
        group_ids: this.group_ids
      }
      axios.patch(`/api/people/${this.$route.params.id}`, params)
        .then((res) => {
          this.person = res.data
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
