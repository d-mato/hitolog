// Webpack CSS import
import 'onsenui/css/onsenui.css';
import 'onsenui/css/onsen-css-components.css';

import Vue from 'vue/dist/vue.esm'
import App from './app.vue'

import router from './router'
import Router from 'vue-router/dist/vue-router.esm'
Vue.use(Router)

import 'onsenui'
import VueOnsen from 'vue-onsenui'
Vue.use(VueOnsen)

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('app'))
  let v = new Vue({
    el: 'app',
    template: '<App/>',
    router,
    components: { App }
  })
  console.log(v)
})
