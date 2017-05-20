<template>
  <ul>
    <li><router-link to="/people">List</router-link></li>
    <li><router-link to="/people/new">New</router-link></li>
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
/*p {
  font-size: 2em;
  text-align: center;
}*/
</style>
