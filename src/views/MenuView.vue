<template>
  <div class="menu-view">
    <div v-if="status == 0" class="choose-page">
      <header class="rest-name">
        <h1>{{ restInfo.restname }}</h1>
      </header>
      <section class="main">
        <div class="rest-tags">
          <div class="tag">
            <ul>
              <li v-for="item in menuList" class="tag-item" :class="{ active: activeTag == item.tagid }" @click="onTagClick(item.tagid)">
                {{ item.tagname }}
              </li>
            </ul>
          </div>
        </div>
          <!-- <food-list></food-list> -->
        <div ref="foodMenu" class="food-menu" @scroll="onMenuScroll">
          <ul>
            <li v-for="item in menuList" class="menu-item" :tagid="item.tagid">
              <div class="tag-name"><h3>{{ item.tagname }}</h3></div>
              <div class="food-list">
                <ul class="">
                  <li v-for="food in item.foods" class="food-item clearfix">
                    <div class="img-wraper">
                      <img :src="food.image">
                    </div>
                    <div class="info">
                      <div class="name">{{ food.name }}</div>
                      <div class="price">¥{{ food.price }}</div>
                    </div>
                    <num-input :cart="cart" :food="food" @addFood="onAddFood" @minusFood="onMinusFood" class="action"></num-input>
                  </li>
                </ul>
              </div>
            </li>
          </ul>
        </div>
      </section>
      <div class="cart">
        <div class="cart-img-wrap">
          <img src="../assets/images/cart.png">
          <div class="food-choosed-total-num">{{ choosedTotalNum }}</div>
        </div>
        <div class="food-choosed-total-price">共 {{ choosedTotalPrice }} 元</div>
        <div class="complete" @click="status = 1">选好了</div>
      </div>
    </div>
    <order-submit v-else-if="status == 1" :cart="cart" @backPage="status = 0" @forward="onSubmitOrder"></order-submit>
    <my-order v-else-if="status == 2" :cart="cart" @backPage="status = 1" @remove="onRemove"></order-submit>
  </div>
</template>

<script>
import NumInput from '../components/menu/NumInput.vue'
import OrderSubmit from '../components/menu/OrderSubmit.vue'
import MyOrder from '../components/menu/MyOrder.vue'
import { RestApi, MenuApi } from '../api/index.js'

import io from 'socket.io-client'


export default {
  name: 'menu-view',
  components: {
    NumInput,
    OrderSubmit,
    MyOrder
  },
  created() {
    RestApi.fetchRestInfo({ id: '10001'}, (restinfo) => {
      this.restInfo = restinfo;
      MenuApi.fetchMenu({ id: '10001'}, (menu) => {
        console.log(menu)
        this.menuList = menu
        this.activeTag = this.menuList[0].tagid
      })
    });


    
  },
  props: {
  },
  data() {
    return {
      restInfo: {},
      menuList: [],
      cart: [],
      activeTag: '',
      status: 0
    }
  },

  computed: {
    choosedTotalNum() {
      let num = 0;
      this.cart.forEach((item) => {
        num += item.num;
      })
      return num
    },
    choosedTotalPrice() {
      let total = 0;
      this.cart.forEach((item) => {
        total += item.price*item.num;
      })
      return total
    }
  },
  filters: {

  },
  mounted() {
    this.socket = io()
    this.socket.on('food-status', (food) => {
      for(let i=0;i < this.cart.length;i++) {
        if(this.cart[i].foodid == food.foodid) {
          // this.cart[i].status = food.status
          this.$set(this.cart[i], 'status', food.status)

          break;
        }
        
      }
    });
  },
  methods: {
    onMenuScroll() {
      let menus = this.$refs.foodMenu.querySelectorAll('.menu-item')
      for(let i = menus.length-1;i >= 0;i--) {
        if(menus[i].offsetTop - this.$refs.foodMenu.scrollTop < 2) {
          this.activeTag = menus[i].getAttribute('tagid')
          break;
        }
      }
    },
    onTagClick(tagid) {
      console.log(tagid)
      this.activeTag = tagid
      let tarMenu = this.$refs.foodMenu.querySelector('[tagid="' + tagid + '"]')

      this.$refs.foodMenu.scrollTop = tarMenu.offsetTop
    },
    
    getFoodChooseNum(foodid) {
      let rsl = 0;
      for(let k in this.cart) {
        let c = this.cart[k]
        if(c.foodid == foodid) {
          rsl = c.num
          break;
        }
      }
      return rsl;
    },

    onAddFood(food) {
      let has = false, k;
      for(k in this.cart) {
        if(this.cart[k].foodid == food.id) {
          has = true;
          break;
        }
      }
      if(has) {
        this.cart[k].num++
      } else {
        this.cart.push({
          foodid: food.id,
          name: food.name,
          price: food.price,
          num: 1
        })
      }
    },
    onMinusFood(food) {
      let has = false, k;
      for(k in this.cart) {
        if(this.cart[k].foodid == food.id) {
          has = true;
          break;
        }
      }
      if(has) {
        let c = this.cart[k]
        if(c.num == 1) {
          this.cart.splice(k, 1)
        } else {
          this.cart[k].num--
        }
      }
    },
    onSubmitOrder() {
      this.socket.emit('order', this.cart);
      this.status = 2
    },
    onRemove(item) {
      let idx;
      for(let k in this.cart) {
        let c = this.cart[k]
        if(c.foodid == item.foodid) {
          idx = k
          break;
        }
      }
      if(idx >= 0) {
        this.cart.splice(idx, 1)
        this.socket.emit('order-item-remove', item)
      }
      
    }
  }
}
</script>

<style lang="stylus">
.menu-view
  .choose-page
    .rest-name
      position fixed
      top 0
      left 0
      width 100%
      border-bottom solid 1px #ddd
      background #fff
      z-index 9
      h1
        line-height 42px
        text-align center
        font-size 19px /*px*/
        font-weight bold
    .main
      position absolute
      top 42px
      bottom 51px
      width 100%
      .rest-tags
        float left
        width 85px
        background #efefef
        height 100%
        overflow-y auto
        -webkit-overflow-scrolling touch
        font-size 14px
        .tag-item
          position relative
          padding 0 6px
          border-bottom 1px dotted #bfbfbf
          line-height 60px
          text-align center
          &.active
            background #fff
            &:before
              position absolute
              content ''
              top 18px
              left 0
              width 4px
              height 23px
              background #ffd300

      .food-menu
        margin-left 85px
        height 100%
        overflow-y auto
        -webkit-overflow-scrolling touch
        font-size 16px
        .tag-name
          padding-left 10px
          line-height 30px
          background #f7f7f7
          font-size 12px
          color #333
        .food-list
          padding-left 10px
          .food-item
            position relative
            padding 15px 0 10px
            height 90px
            box-sizing border-box
            border-bottom 1px solid #f0f0f0
            
            .img-wraper
              float left
              width 62px
              height 62px
              img
                width 100%
                height 100%
            .info
              float left
              margin-left 10px
              .name
                margin-top 4px
                font-size 16px
                color #2f2f2f
              .price
                margin-top 10px
                font-size 18px
                color #fe4d3e
            .action
              position absolute
              bottom 10px
              right 10px
    .cart
      position fixed
      bottom 0
      width 100%
      height 50px
      border-top solid 1px #cacaca
      background #fff
      z-index 9
      .cart-img-wrap
        position absolute
        left 10px
        top -16px
        width 50px
        height 50px
        img
          width 100%
          height 100%
        .food-choosed-total-num
          position absolute
          top 2px
          right 0
          border-radius 50% 50%
          background-color #ff6900
          width 15px
          height 15px
          line-height 16px
          font-size 12px
          text-align center
          color #fff
      .food-choosed-total-price
        margin-left 70px
        margin-right 110px
        line-height 50px
        text-align center
        font-size 16px
        color #fb4e44
      .complete
        position absolute
        top 0
        right 0
        width 110px
        height 100%
        line-height 50px
        background #ffd300
        text-align center
        font-size 14px




      



</style>
