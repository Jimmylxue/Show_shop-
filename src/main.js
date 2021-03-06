import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

import ElementUI from 'element-ui'
import sweetalert from './plugins/swrrtalert2'
import Video from 'video.js'

import 'element-ui/lib/theme-chalk/index.css'
import './assets/css/global.css'
import 'video.js/dist/video-js.css'

import 'font-awesome/css/font-awesome.css'
import './assets/css/global.css'
import '@/assets/css/resetUI.css'

import VueSocketIo from 'vue-socket.io'

Vue.use(
  new VueSocketIo({
    debug: true,
    connection: 'http://localhost:666',
  })
)

import interceptors from './interceptors'

import api from '@/service/api'
Vue.prototype.$api = api
Vue.prototype.$video = Video

Vue.use(ElementUI)
Vue.use(sweetalert)
Vue.config.productionTip = false

const vm = new Vue({
  router,
  store,
  render: h => h(App),
}).$mount('#app')

interceptors(vm)
