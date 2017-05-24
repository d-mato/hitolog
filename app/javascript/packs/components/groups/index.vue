<template>
  <v-ons-page>
    <tool-bar :action="toggleMenu" :right_btn_action="show_dialog" right_btn_label="Add">Group List</tool-bar>

    <v-ons-list>
      <v-ons-list-item v-for="item in items" :key="item.id" modifier="chevron" tappable>{{ item.name }}</v-ons-list-item>
    </v-ons-list>
  </v-ons-page>
</template>

<script>
import axios from '../../axios'
import ToolBar from '../toolbar'

export default {
  props: ['toggle-menu'],
  components: { ToolBar },
  data: function () {
    return {
      items: [],
    }
  },
  created() {
    axios.get('/api/groups')
      .then((res) => {
        this.items = res.data
      })
      .catch((err) => {
      })
  },
  methods: {
    show_dialog() {
      this.$ons.notification.prompt("Input group's name")
        .then((name) => this.submit(name))
    },
    submit(name) {
      if (name == '') return false
      axios.post('/api/groups', { name })
        .then((res) => {
          this.items.push(res.data)
          this.$ons.notification.alert('Created!')
        })
        .catch((err) => {
          console.log(err)
          this.$ons.notification.alert('Error!')
        })
    }
  }
}
</script>

<style scoped>
</style>
