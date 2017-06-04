<template>
  <v-ons-page>
    <tool-bar :back="true">Group Detail</tool-bar>

    <v-ons-list>
      <v-ons-list-header>Name</v-ons-list-header>
      <v-ons-list-item>
        <div class="center">
          <v-ons-input placeholder="Group name" float v-ons-model="group.name" />
        </div>
      </v-ons-list-item>

      <button class="btn btn-primary" @click="save">save</button>
      <button class="btn btn-danger" @click="del">del</button>
    </v-ons-list>

    <p>{{ message }}</p>
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
      group: {},
      message: ''
    }
  },
  created() {
    axios.get(`/api/groups/${this.options.group_id}`)
      .then((res) => {
        this.group = res.data
      })
      .catch((err) => {
        this.$ons.notification.toast('Error!', { timeout: 1500 })
        console.log(err)
      })
  },
  methods: {
    save() {
      axios.patch(`/api/groups/${this.options.group_id}`, this.group)
        .then((res) => {
          this.group = res.data
          this.$ons.notification.toast('Updated!', { timeout: 1500 })
          this.options.groups = this.options.groups.map((group) => {
            return (group.id == res.data.id) ? res.data : group
          })
        })
        .catch((err) => {
          this.$ons.notification.toast('Error!', { timeout: 1500 })
          console.log(err)
        })
    },

    del() {
      if (confirm('Are you sure?')) {
        axios.delete(`/api/groups/${this.options.group_id}`)
          .then((res) => {
            this.$ons.notification.toast('Deleted!', { timeout: 1500 })
            this.pageStack.pop()
            this.options.groups = this.options.groups.filter((group) => {
              return group.id != this.options.group_id
            })
          })
          .catch((err) => {
            this.$ons.notification.toast('Error!', { timeout: 1500 })
            console.log(err)
          })
      }
    }
  }
}
</script>

<style scoped>
</style>
