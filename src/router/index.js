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
import ui from '@/views/ui/ui.vue'
import video from '@/views/video'

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
      { path: '/main', meta: { auth: true }, component: main },
      { path: '/user', meta: { auth: true }, component: user },
      { path: '/admin', meta: { auth: true }, component: admin },
      { path: '/goods', meta: { auth: true }, component: allGood },
      {
        path: '/addGood',
        meta: { auth: true },
        component: addGood,
      },
      { path: '/stock', meta: { auth: true }, component: stock },
      { path: '/list', meta: { auth: true }, component: list },
      { path: '/classify', meta: { auth: true }, component: classify },
      { path: '/chat', meta: { auth: true }, component: chat },
      { path: '/print', meta: { auth: true }, component: ui },
      { path: '/video', meta: { auth: true }, component: video },
    ],
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes,
})

router.beforeEach((to, from, next) => {
  if (to.meta.auth) {
    const token = localStorage.getItem('token')
    if (token) {
      next()
    } else {
      next({
        path: '/login?redirect',
        query: { redirect: to.path },
      })
    }
  } else {
    next()
  }
})

export default router
