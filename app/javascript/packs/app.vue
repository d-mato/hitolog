<template>
  <v-ons-splitter>
    <v-ons-splitter-side
      swipeable width="150px" collapse="" side="left"
      :open.sync="openSide"
    >
      <v-ons-page>
        <v-ons-toolbar>
          <div class="center">Menu</div>
        </v-ons-toolbar>
        <v-ons-list>
          <v-ons-list-item v-for="page in pages"
            tappable modifier="chevron"
            @click="openSide = false; $router.push({ name: page })"
          >
            <div class="center">{{ page }}</div>
          </v-ons-list-item>
        </v-ons-list>
      </v-ons-page>
    </v-ons-splitter-side>

    <v-ons-splitter-content>
      <router-view></router-view>
    </v-ons-splitter-content>
  </v-ons-splitter>
</template>

<script>
import AppMenu from './app-menu'
import PeopleIndex from './components/people/index'
import GroupsIndex from './components/groups/index'

export default {
  components: { PeopleIndex, GroupsIndex },
  data() {
    return {
      title: '',
      pages: ['PeopleIndex', 'GroupsIndex'],
      openSide: false,
    }
  },
  components: { AppMenu }
}
</script>

<style>
h2 {
  font-size: 2em;
  text-align: center;
}
</style>
