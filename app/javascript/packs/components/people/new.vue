<template>
  <div>
    <h2>New Person</h2>
    <form @submit.prevent="submit">
      Name: <input class="form-control" v-model="name">
      <input type="submit" class="btn btn-primary" value="Submit">
      <input @click="$emit('close')" type="reset" class="btn btn-default" value="Cancel">
    </form>
    <p>{{ message }}</p>
  </div>
</template>

<script>
import axios from '../../axios'
export default {
  data: function () {
    return {
      name: '',
      message: ''
    }
  },
  methods: {
    submit(e) {
      axios.post('/api/people', {
        name: this.name,
      })
        .then((res) => {
          this.message = 'Success!'
          this.name = ''
          this.$emit('created')
          this.$router.push(`/people/${res.data.id}`)
        })
        .catch((err) => {
          this.message = 'Error..'
          console.log(err)
        })
    }
  }
}
</script>

<style scoped>

</style>
