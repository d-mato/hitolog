<template>
  <div>
    <app-menu></app-menu>
    <router-view></router-view>
  </div>
</template>

<script>
import AppMenu from './app-menu'

export default {
  data: function () {
    return {
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
