<template>
  <v-ons-page>
    <tool-bar :back="true">Person Detail</tool-bar>

    <div v-show="!edit_mode">
      <ul>
        <li>Name: {{ person.name }}</li>
        <li>Sex: {{ person.sex }}</li>
        <li>Encountered at: {{ person.encountered_at }}</li>
        <li>Groups:
          <span class="badge badge-default" v-for="group in person.groups">{{ group.name }}</span>

        </li>
        <li>Updated at: {{ person.updated_at }}</li>
      </ul>

      <button class="btn btn-primary" @click="edit_mode = true">edit</button>
      <button class="btn btn-danger" @click="del">del</button>
    </div>

    <div v-show="edit_mode">
      <form @submit.prevent="save">
        <div>
          Name: <input v-model="person.name" class="form-control">
        </div>
        <div>
          Sex:
          <select v-model="person.sex" class="form-control">
            <option value=""></option>
            <option value="male">Male</option>
            <option value="female">Female</option>
          </select>
        </div>
        <div>
          Encountered at:
          <input type="datetime-local" v-model="person.encountered_at" class="form-control">
        </div>
        <div>
          <div v-for="group in groups" class="form-check form-check-inline">
            <label class="form-check-label">
              <input type="checkbox" :value="group.id" v-model="group_ids" class="form-check-input">{{group.name}}
            </label>
          </div>
        </div>
        <input type="submit" value="Save" class="btn btn-primary">
        <input @click="edit_mode = false" type="reset" value="Cancel" class="btn btn-default">
      </form>

    </div>
    <ul>
      <li v-for="impression in person.impressions" :key="impression.id">
        {{ impression.date }}
        {{ impression.comment }}
      </li>
    </ul>

    <input type="date" placeholder="Date" v-model="new_impression.date" />
    <input placeholder="Comment" v-model="new_impression.comment" />
    <button class="btn btn-primary" @click="add_impression">save</button>
  </v-ons-page>
</template>

<script>
import axios from '../../axios'
import ToolBar from '../toolbar'

export default {
  props: ['options', 'toggle-menu', 'page-stack'],
  components: { ToolBar },
  data: function () {
    return {
      edit_mode: false,
      group_ids: [],
      person: {},
      groups: [],
      new_impression: {}
    }
  },
  created() {
    axios.get('/api/groups')
      .then((res) => {
        this.groups = res.data
      })

    axios.get(`/api/people/${this.options.person_id}`)
      .then((res) => {
        this.person = res.data
        this.group_ids = this.person.groups.map( (group) => group.id )
      })
      .catch((err) => {
        this.$ons.notification.toast('Error!', { timeout: 1500 })
        console.log(err)
      })
  },
  methods: {
    save() {
      let params = {
        person: this.person,
        group_ids: this.group_ids
      }
      axios.patch(`/api/people/${this.options.person_id}`, params)
        .then((res) => {
          this.person = res.data
          this.$ons.notification.toast('Updated!', { timeout: 1500 })
          this.edit_mode = false
          this.options.people = this.options.people.map((person) => {
            return (person.id == res.data.id) ? res.data : person
          })
        })
        .catch((err) => {
          this.$ons.notification.toast('Error!', { timeout: 1500 })
          console.log(err)
        })
    },

    del() {
      if (confirm('Are you sure?')) {
        axios.delete(`/api/people/${this.options.person_id}`)
          .then((res) => {
            this.$ons.notification.toast('Deleted!', { timeout: 1500 })
            this.options.people = this.options.people.filter((person) => {
              return person.id != this.options.person_id
            })
            this.pageStack.pop()
          })
          .catch((err) => {
            this.$ons.notification.toast('Error!', { timeout: 1500 })
            console.log(err)
          })
      }
    },
    add_impression(e) {
      axios.post(`/api/people/${this.options.person_id}/impressions`, this.new_impression)
        .then((res) => {
          this.new_impression = {}
          this.person.impressions.push(res.data)
          this.$ons.notification.toast('Created!', { timeout: 1500 })
        })
        .catch((err) => {
          this.$ons.notification.toast('Error!', { timeout: 1500 })
          console.log(err)
        })
    }
  }
}
</script>

<style scoped>
</style>
