<template>
  <ul class="list-inline">
    <li class="list-inline-item"><router-link to="/people">People</router-link></li>
    <li class="list-inline-item"><router-link to="/groups">Group</router-link></li>
  </ul>
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped>
</style>
