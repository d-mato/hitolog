<template>
  <v-on-page>
    <v-ons-navigator :page-stack="pageStack">
      <component :is="page" v-for="page, index in pageStack" :key="index" :page-stack="pageStack" :toggle-menu="toggleMenu" :options="options" :reload-people="get_index"></component>
    </v-ons-navigator>
  </v-on-page>
</template>

<script>
import axios from '../../axios'
import List from './list'

export default {
  props: ['toggle-menu'],
  components: { List },
  data: function () {
    return {
      pageStack: [List],
      options: {
        people: [],
        person_id: null,
      },
    }
  },
  methods: {
    get_index() {
      axios.get('/api/people')
        .then((res) => {
          this.options.people = res.data
        })
        .catch((err) => {
        })
    }
  }
}
</script>
