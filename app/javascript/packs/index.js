import Vue from 'vue/dist/vue.esm'
import App from './app.vue'
import router from './router'

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('app'))
  new Vue({
    el: 'app',
    template: '<App/>',
    router,
    components: { App }
  })
})
