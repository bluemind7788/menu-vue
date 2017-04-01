<template>
  <div class="order-submit">
    <header class="header">
      <h1>清单</h1>
    </header>

    <ul class="main">
      <li class="cook-item" v-for="deskData in showFoodList">
        <template >
          <div class="cook-table" >
          	<div class="desk">{{ deskData.desknum }}号桌</div>
            <ul>
              <li v-for="item in deskData.list" class="order-item clearfix" :class="{'item-finished' : item.salestatus == 2, 'item-unstarted' : item.salestatus == 0, 'item-ongoing' : item.salestatus == 1}">
            	<span class="food-name">{{ item.name }}</span>
            	<span class="food-num">x{{ item.num }}</span>
            	<button class="food-start" @click="onAction(item)">{{ item.salestatus == 0 ? '开始' : '结束' }}</button>
              </li>
            </ul>
          </div>
        </template>
      </li>
     
  </ul>
  </div>
</template>

<script>
import { OrderApi, SaleApi } from '../api/index.js'

import io from 'socket.io-client'

export default {
  name: 'oder-submit',
  components: {  },
  props: {
  },
  data() {
  	return {
  		foodList: []
  	}
  },
  computed: {
    showFoodList() {
      let result = [];
      for(let i=0;i < this.foodList.length;i++ ) {
        let deskData = this.foodList[i];
        let should = false;
        for(let j=0;j < deskData.list.length;j++ ) {
          if(deskData.list[j].salestatus != 2) {
            should = true;
            break;
          }
        }
        if(should) {
          result.push(deskData)
        }
        
      }
      return result;
    },
  },
  created() {
    let sps = this.$route.path.split('/')
    this.restId = parseInt(sps[sps.length-1], 36)

    this.fetchOrders()
  },
  mounted() {
  	this.socket = io();
    // 加入房间
    this.socket.on('connect', () => {
      // this.socket.emit('join-room', {});
    });
  	this.socket.on('new-order', (orderInfo) => {
      // OrderApi.queryOrderById({
      //   restid: orderInfo.restId,
      //   status: 0
      // }, (res) => {
      //   console.log(res)

      // })  
      this.fetchOrders()
      // if(orders && orders.length > 0) {
      // 	orders.forEach((or) => {
      // 		or.status = 0
      // 		this.cart.push(or)
      // 	})
      // }
      window.scrollTo(0, document.body.scrollHeight);
    });
    this.socket.on('order-item-remove', (item) => {
	  	// let reIdx;
	  	// for(let i=0;i<this.cart.length;i++) {
	  	// 	if(this.cart[i].foodid == item.foodid) {
	  	// 		reIdx = i;
	  	// 		break;
	  	// 	}
	  	// }
	  	// if(reIdx) {
	  	// 	this.cart.splice(reIdx, 1)
	  	// }
      for(let i=0;i < this.foodList.length;i++ ) {
        let deskData = this.foodList[i];
        let removeIdx = -1;
        for(let j=0;j < deskData.list.length;j++ ) {
          if(deskData.list[j].saleid == item.saleid) {
            removeIdx = j;
            break;
          }
        }
        if(removeIdx != -1) {
          deskData.list.splice(removeIdx, 1);
          break;
        }
        
        
      }
      
    });
  },
  filters: {
    // shouldDeskShow(deskData) {
    //   let should = true;
    //   for(let i=0;i < deskData.list;i++ ) {
    //     if(deskData.list[i].salestatus !== 2) {
    //       should = false;
    //       break;
    //     }
    //   }
    //   return should;

    // }
  },
  methods: {
    onBackPage() {
      this.$emit('backPage')
    },
    onSubmit() {
      this.$emit('forward')
    },
    onAction(item) {
    	if(item.salestatus < 2) {
    		item.salestatus++
        SaleApi.updateSaleStatus({
          saleid: item.saleid,
          status: item.salestatus
        }, () => {
          this.socket.emit('food-status', item);
        });
    		
    	}
    },
    fetchOrders() {
      this.foodList.splice(0, this.foodList.length)
      OrderApi.getOrderByRestIdAndStatus({
        restid: this.restId,
        status: 0
      }, (orders) => {
        console.log(orders)
        if(orders && orders.length > 0) {
          orders.forEach((or) => {
            let o = {
                name: or.foodname,
                num: or.num,
                saleid: or.saleid,
                salestatus: or.salestatus,
            }

            let find = false, i=0;
            for(i=0;i<this.foodList.length;i++) {
              if(this.foodList[i].desknum == or.desknum) {
                find = true
                break;
              }
            }
            if(find) {
              this.foodList[i].list.push(o)
            } else {
               this.foodList.push({
                desknum: or.desknum,
                list: [o]
               })
            }
           
          });
          console.log(this.foodList)
      }
      })  
    }
  }
}
</script>

<style lang="stylus">
.order-submit

  .header
    position fixed
    top 0
    left 0
    width 100%
    border-bottom solid 1px #ddd
    background #fff
    z-index 9
    h1
      width 100%
      line-height 42px
      text-align center
      font-size 19px /*px*/
      font-weight bold
    .back-page
      position absolute
      left: 10px
      width 50px
      line-height 42px
      font-size 19px /*px*/
  .main
    position absolute
    top 42px
    bottom 51px
    padding-top 30px
    width 100%
    background #f7f7f7
    .cook-item
      position relative
      margin-bottom 30px
      .cook-table
        background #fff
      	.desk
      		position absolute
      		top -15px
      		right 4px
      		width 40px
  		    height 24px
  		    background #eee
  		    border-radius 10px
  		    font-size 14px
  		    line-height 2
  		    text-align center
  		    font-size 12px


  	    .order-item
  	    	&:first-child
  	    		border-top solid 1px #ddd
  	    	line-height 50px
  	    	padding 0 10px
  	    	border-bottom solid 1px #ddd
  	    	font-size 0
  	    	&.item-ongoing
  	    		color #ffd300
  	    		.food-start 
  	    			background #ffd300
  	    	&.item-finished
  	    		color #ddd
  	    		.food-start 
  	    			background #ddd
  	    	span
  	    		float left
  	    		height 50px
  	    		line-height 50px
  	    		font-size 16px
  	    		padding 0
  	    	.food-name
  	    		width 200px
  	    		white-space nowrap
  	    		overflow hidden
  	    		text-overflow ellipsis
  	    	.food-num
  	    		width 25px
  	    	.food-price
  	    		width 50px
  	    	.food-start
  	    		display inline-block
  	    		margin-left 30px
  	    		width 60px
  	    		height 30px
  	    		vertical-align middle
  	    		background #42b983
  	    		border none
  	    		color #fff
  	    		font-size 16px
  	    		font-weight bold
  .footer
  	position fixed
  	bottom 0
  	width 100%
  	height 50px
  	line-height 50px
  	padding-left 10px
  	border-top solid 1px #cacaca
  	background #fff
  	font-size 16px
  	.submit
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
