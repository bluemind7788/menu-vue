import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

import MenuView from '../views/MenuView.vue'
import Cooker from '../views/Cooker.vue'

export default new Router({
  mode: 'history',
  scrollBehavior: () => ({ y: 0 }),
  routes: [
  	{ path: '/', component: MenuView},
    { path: '/view/menu/:id/:id', component: MenuView},
    { path: '/view/cooker', component: Cooker},

    
  ]
})
