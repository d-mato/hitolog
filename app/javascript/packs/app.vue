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
          <v-ons-list-item v-for="page, index in pages" :key="index"
            tappable modifier="chevron"
            @click="openSide = false; currentPage = page"
          >
            <div class="center">{{ page }}</div>
          </v-ons-list-item>
        </v-ons-list>
      </v-ons-page>
    </v-ons-splitter-side>

    <v-ons-splitter-content>
      <component :is="currentPage" :toggle-menu="() => openSide = !openSide"></component>
    </v-ons-splitter-content>
  </v-ons-splitter>
</template>

<script>
import AppMenu from './app-menu'
import People from './components/people/index'
import Groups from './components/groups/index'

export default {
  components: { AppMenu, People, Groups },
  data() {
    return {
      title: '',
      pages: ['People', 'Groups'],
      openSide: false,
      currentPage: 'People',
    }
  },
}
</script>

<style>
h2 {
  font-size: 2em;
  text-align: center;
}
</style>
