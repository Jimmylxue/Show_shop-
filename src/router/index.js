import Vue from 'vue'
import VueRouter from 'vue-router'
import login from '../views/login'
import register from '../views/register'
import home from '../views/home'
import user from '../views/user/user'
import admin from '../views/user/admin'
import main from '../views/main'
import allGood from '../views/good/allgood'
import addGood from '../views/good/addGood'
import stock from '../views/good/stock'
import list from '../views/order/orderList'
import classify from '../views/good/classify'
import chat from '../views/chat/chat.vue'
import test from '@/views/test.vue'
import ui from '@/views/ui/ui.vue'

Vue.use(VueRouter)

const routes = [
  { path: '/', redirect: '/login' },
  { path: '/login', component: login },
  { path: '/register', component: register },
  {
    path: '/home',
    component: home,
    redirect: '/main',
    children: [
      { path: '/main', component: main },
      { path: '/user', component: user },
      { path: '/admin', component: admin },
      { path: '/goods', component: allGood },
      {
        path: '/addGood',
        component: addGood,
      },
      { path: '/stock', component: stock },
      { path: '/list', component: list },
      { path: '/classify', component: classify },
      { path: '/chat', component: chat },
      { path: '/print', component: ui },
    ],
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes,
})

export default router
