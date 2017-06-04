<template>
  <v-ons-page>
    <tool-bar :action="toggleMenu" :right_btn_action="show_dialog" right_btn_label="Add">Group List</tool-bar>
    <v-ons-list>
      <v-ons-list-item v-for="item in options.groups" :key="item.id" @click="go_show_page(item.id)" modifier="chevron" tappable>{{ item.name }}</v-ons-list-item>
    </v-ons-list>
  </v-ons-page>
</template>

<script>
import axios from '../../axios'
import ToolBar from '../toolbar'
import ShowGroup from './show'

export default {
  props: ['options', 'toggle-menu', 'page-stack'],
  components: { ToolBar, ShowGroup },
  data: function () {
    return {
      items: [],
      group_id: null,
      currentPage: this,
    }
  },
  created() {
    axios.get('/api/groups')
      .then((res) => {
        this.options.groups = res.data
      })
      .catch((err) => {
      })
  },
  methods: {
    show_dialog() {
      this.$ons.notification.prompt("Input group's name", {cancelable: true})
        .then((name) => {
          if (name) this.submit(name)
        })
    },
    submit(name) {
      axios.post('/api/groups', { name })
        .then((res) => {
          this.options.groups.push(res.data)
          this.$ons.notification.alert('Created!')
        })
        .catch((err) => {
          console.log(err)
          this.$ons.notification.alert('Error!')
        })
    },
    go_show_page(id) {
      this.pageStack.push(ShowGroup)
      this.options.group_id = id
    }
  }
}
</script>

<style scoped>
</style>
