import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import './assets/css/global.css'

import 'font-awesome/css/font-awesome.css'
import './assets/css/global.css'
import '@/assets/css/resetUI.css'

import interceptors from './interceptors'

Vue.use(ElementUI)
Vue.config.productionTip = false

const vm = new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount('#app')

interceptors(vm)
