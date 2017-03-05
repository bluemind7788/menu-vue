import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

import MenuView from '../views/MenuView.vue'

export default new Router({
  mode: 'history',
  scrollBehavior: () => ({ y: 0 }),
  routes: [
    { path: '/menu', component: MenuView},
    { path: '/', redirect: '/menu' },
    
  ]
})
