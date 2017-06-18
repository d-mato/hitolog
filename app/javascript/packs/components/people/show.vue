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

    <h3>Impressions</h3>
    <ul class="list-unstyled">
      <li v-for="impression in person.impressions" :key="impression.id" @click="delete_impression(impression)">
        <label>[{{ impression.date }}]</label>
        {{ impression.comment }}
      </li>
    </ul>

    <v-ons-list>
      <v-ons-list-header>Date</v-ons-list-header>
      <v-ons-list-item>
        <input type="date" v-model="new_impression.date" class="text-input" />
      </v-ons-list-item>
      <v-ons-list-header>Comment</v-ons-list-header>
      <v-ons-list-item>
        <textarea v-model="new_impression.comment" class="textarea" rows="3" /></textarea>
      </v-ons-list-item>
    </v-ons-list>
    <v-ons-button @click="add_impression">save</v-ons-button>
  </v-ons-page>
</template>

<script>
import dateformat from 'dateformat'
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
    this.reset_new_impression()
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
          this.reset_new_impression()
          this.person.impressions = res.data
          this.$ons.notification.toast('Created!', { timeout: 1500 })
        })
        .catch((err) => {
          this.$ons.notification.toast('Error!', { timeout: 1500 })
          console.log(err)
        })
    },
    delete_impression(impression) {
      if (!confirm(`Are you sure to delete "${impression.comment}"`)) return false
      axios.delete(`/api/impressions/${impression.id}`)
        .then((res) => {
          const index = this.person.impressions.indexOf(impression)
          this.person.impressions.splice(index, 1)
          this.$ons.notification.toast('Deleted!', { timeout: 1500 })
        })
        .catch((err) => {
          this.$ons.notification.toast('Error!', { timeout: 1500 })
          console.log(err)
        })
    },
    reset_new_impression() {
      this.new_impression = {
        date: dateformat(new Date(), 'yyyy-mm-dd'),
        comment: ''
      }
    }
  }
}
</script>

<style scoped>
textarea {
  width: 100%;
}
</style>
