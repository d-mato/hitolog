<template>
  <v-ons-page>
    <v-ons-navigator :page-stack="pageStack">
      <component :is="page" v-for="page, index in pageStack" :key="index" :page-stack="pageStack" :toggle-menu="toggleMenu" :options="options"></component>
    </v-ons-navigator>

  </v-ons-page>
</template>

<script>
import axios from '../../axios'
import ToolBar from '../toolbar'
import List from './list'

export default {
  props: ['toggle-menu'],
  components: { List },
  data: function () {
    return {
      items: [],
      pageStack: [List],
      options: {
        groups: [],
        group_id: null,
      },
    }
  },
}
</script>

<style scoped>
</style>
