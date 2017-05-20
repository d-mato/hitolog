<template>
  <div>
    <h2>People List</h2>
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
        <tr v-for="person in filtered_people">
          <td><router-link :to="`/people/${person.id}`">{{ person.name }}</router-link></td>
          <td>{{ person.sex }}</td>
          <td><span class="badge badge-default" v-for="group in person.groups">{{ group.name }}</span></td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from '../../axios'
export default {
  data: function () {
    return {
      people: [],
      groups: [],
      selected_group_id: null
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
</style>
