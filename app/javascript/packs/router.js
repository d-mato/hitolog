import Router from 'vue-router/dist/vue-router.esm'
import Index from './components/people/index'
import New from './components/people/new'
import Show from './components/people/show'
import GroupsIndex from './components/groups/index'

export default new Router({
  routes: [
    { path: '/people', component: Index, name: 'PeopleIndex' },
    { path: '/people/new', component: New },
    { path: '/people/:id', component: Show },
    { path: '/groups', component: GroupsIndex, name: 'GroupsIndex' },
  ]
})
