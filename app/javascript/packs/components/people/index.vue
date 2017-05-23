<template>
  <div>
    <tool-bar title="People List"></tool-bar>
    <div style="margin-top: 60px">
      Groups:
      <ul class="list-inline">
        <li class="list-inline-item" v-bind:class="{ active: selected_group_id == null}"><a href="#" @click.prevent="selected_group_id = null">All</a></li>
        <li class="list-inline-item" v-for="group in used_groups" v-bind:class="{ active: selected_group_id == group.id}"><a href="#" @click.prevent="selected_group_id = group.id">{{ group.name }}</a></li>
      </ul>
    </div>

    <table class="table table-hover">
      <thead>
        <tr>
          <th>Name</th><th>Sex</th><th>Groups</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="person in filtered_people">
          <td><router-link :to="`/people/${person.id}`">{{ person.name }}</router-link></td>
          <td>{{ person.sex }}</td>
          <td><span class="badge badge-default" v-for="group in person.groups">{{ group.name }}</span></td>
        </tr>
      </tbody>
    </table>

    <button @click="show_new_person = !show_new_person" class="btn btn-primary btn-new-person">New</button>
    <new-person v-if="show_new_person" v-on:close="show_new_person = false" v-on:created="$ons.notification.alert('Hello World!')" class="new-person-modal"></new-person>
  </div>
</template>

<script>
import axios from '../../axios'
import NewPerson from './new'
import ToolBar from '../toolbar'

export default {
  components: { NewPerson, ToolBar },
  data: function () {
    return {
      people: [],
      groups: [],
      selected_group_id: null,
      show_new_person: false,
    }
  },
  created() {
    axios.get('/api/people')
      .then((res) => {
        this.people = res.data
      })
      .catch((err) => {
      })
  },
  computed: {
    filtered_people() {
      if (this.selected_group_id)
        return this.people.filter((person) => {
          return person.groups.map((group) => group.id).includes(this.selected_group_id)
        })
      else
        return this.people
    },
    used_groups() {
      let unique_ids = []
      return this.people.reduce((prev, person) => {
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
.btn-new-person {
  position: fixed;
  bottom: 25px;
  right: 25px;
}
.new-person-modal {
  position: fixed;
  top: 20vh;
  left: 5%;
  width: 90%;
  background: #fff;
  padding: 1em;
  box-shadow: 2px 2px 10px 1px;
}

</style>
