<template>
  <v-ons-page>
    <tool-bar :action="toggleMenu" :right_btn_action="show_dialog" right_btn_label="Add">People List</tool-bar>

    Groups:
    <ul class="list-inline">
      <li class="list-inline-item" v-bind:class="{ active: selected_group_id == null}"><a href="#" @click.prevent="selected_group_id = null">All</a></li>
      <li class="list-inline-item" v-for="group in used_groups" v-bind:class="{ active: selected_group_id == group.id}"><a href="#" @click.prevent="selected_group_id = group.id">{{ group.name }}</a></li>
    </ul>

    <table class="table table-hover">
      <thead>
        <tr>
          <th>Name</th><th>Sex</th><th>Groups</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="person in filtered_people" :key="person.id" @click="go_show_page(person.id)">
          <td>{{ person.name }}</td>
          <td>{{ person.sex }}</td>
          <td><span class="badge badge-default" v-for="group in person.groups">{{ group.name }}</span></td>
        </tr>
      </tbody>
    </table>

  </v-ons-page>
</template>

<script>
import axios from '../../axios'
import ShowPerson from './show'
import ToolBar from '../toolbar'

export default {
  props: ['options', 'toggle-menu', 'page-stack'],
  components: { ShowPerson, ToolBar },
  data: function () {
    return {
      groups: [],
      selected_group_id: null,
    }
  },
  computed: {
    filtered_people() {
      if (this.selected_group_id)
        return this.options.people.filter((person) => {
          return person.groups.map((group) => group.id).includes(this.selected_group_id)
        })
      else
        return this.options.people
    },
    used_groups() {
      let unique_ids = []
      return this.options.people.reduce((prev, person) => {
        if (!person.groups) return prev
        let uniq = person.groups.filter((group) => {
          if (unique_ids.includes(group.id)) {
            return false
          } else {
            unique_ids.push(group.id)
            return true
          }
        })
        return prev.concat(uniq)
      }, [])
    }
  },
  methods: {
    show_dialog() {
      this.$ons.notification.prompt("Input name", {cancelable: true})
        .then((name) => {
          if (name) this.submit(name)
        })
    },
    submit(name) {
      axios.post('/api/people', { name })
        .then((res) => {
          this.$ons.notification.toast('Created!', { timeout: 1500 })
          this.options.people.push(res.data)
          this.options.person_id = res.data.id
          this.pageStack.push(ShowPerson)
        })
        .catch((err) => {
          console.log(err)
          this.$ons.notification.alert('Error!')
        })
    },
    go_show_page(id) {
      this.pageStack.push(ShowPerson)
      this.options.person_id = id
    }
  }
}
</script>

<style scoped>
ul.list-inline {
  display: inline;
  li.active a {
    color: #000;
    text-decoration: none;
  }
}
</style>
