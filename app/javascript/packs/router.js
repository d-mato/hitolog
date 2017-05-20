import Vue from 'vue/dist/vue.esm'
import Router from 'vue-router/dist/vue-router.esm'
import People from './people.vue'
import NewPerson from './new-person.vue'

Vue.use(Router)

export default new Router({
  routes: [
    { path: '/people', component: People },
    { path: '/people/new', component: NewPerson },
  ]
})
