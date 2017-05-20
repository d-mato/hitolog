import Vue from 'vue/dist/vue.esm'
import Router from 'vue-router/dist/vue-router.esm'
import Index from './components/people/index'
import New from './components/people/new'
import Show from './components/people/show'

Vue.use(Router)

export default new Router({
  routes: [
    { path: '/people', component: Index },
    { path: '/people/new', component: New },
    { path: '/people/:id', component: Show },
  ]
})
