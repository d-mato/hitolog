<template>
  <div>
    <h2>People List</h2>
    Groups:
    <ul class="list-inline">
      <li class="list-inline-item" v-bind:class="{ active: selected_group_id == null}"><a href="#" @click.prevent="selected_group_id = null">All</a></li>
      <li class="list-inline-item" v-for="group in groups" v-bind:class="{ active: selected_group_id == group.id}"><a href="#" @click.prevent="selected_group_id = group.id">{{ group.name }}</a></li>
    </ul>

    <ul>
      <li v-for="person in filter">
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
      people: [],
      groups: [],
      selected_group_id: null
    }
  },
  created() {
    axios.get('/api/groups')
      .then((res) => {
        this.groups = res.data
      })

    axios.get('/api/people')
      .then((res) => {
        this.people = res.data
      })
      .catch((err) => {
      })
  },
  computed: {
    filter() {
      if (this.selected_group_id)
        return this.people.filter((person) => {
          return person.groups.map((group) => group.id).includes(this.selected_group_id)
        })
      else
        return this.people
    }
  },
  methods: {
    filter() {
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
