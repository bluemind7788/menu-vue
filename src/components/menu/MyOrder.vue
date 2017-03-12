<template>
  <div class="order-submit">
    <header class="header">
      <div class="back-page" @click="onBackPage">返回</div>
      <h1>我的订单</h1>
    </header>

    <div class="main">
      <div class="order-table">
        <ul>
          <li v-for="item in cart" class="order-item clearfix">
            <span class="food-name">
            	{{ item.name }}
            	<button class="food-start" :class="{'status-notstarted' : !item.status, 'status-ongoing' : item.status == 1, 'status-finished' : item.status == 2}">{{ !item.status ? '未开始' : item.status == 1 ? '已下厨' : '已完成' }}</button>
            </span>
          <span class="food-price">¥{{ item.price }}</span>
          <span class="food-num">x{{ item.num }}</span>
          <button v-if="!item.status" class="food-remove" @click="onRemove(item)">取消</button>
          </li>
        </ul>
      </div>
  </div>
  <div class="footer">
    <span class="total-price">共 ¥{{ totalPrice }}</span>
  </div>
  </div>
</template>

<script>
export default {
  name: 'my-order',
  components: {  },
  props: {
    cart: {
      type: Array
    }
  },
  computed: {
    totalPrice() {
      let total = 0;
      this.cart.forEach((item) => {
        total += item.price*item.num;
      })
      return total
    }
  },
  methods: {
    onBackPage() {
      this.$emit('backPage')
    },
    onRemove(item) {
    	this.$emit('remove', item)
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
    padding-top 10px
    width 100%
    background #f7f7f7
    .order-table
    	background #fff

	    .order-item
	    	&:first-child
	    		border-top solid 1px #ddd
	    	padding 0 10px
	    	border-bottom solid 1px #ddd
	    	font-size 0
	    	line-height 50px
	    	span
	    		float left
	    		height 50px
	    		line-height 50px
	    		font-size 16px
	    		padding 0
	    	.food-name
	    		width 250px
	    		white-space nowrap
	    		overflow hidden
	    		text-overflow ellipsis
	    	.food-num
	    		width 25px
	    	.food-price
	    		width 50px
	    	.food-remove
	    		display inline-block
	    		width 30px
	    		height 20px
	    		vertical-align middle
	    		border none
	    		background #ffd300
	    	.food-start
	    		display inline-block
	    		width 40px
	    		height 20px
	    		vertical-align middle
	    		border none
	    		color #fff
	    		font-size 12px
	    		&.status-notstarted
	    			background #ddd
	    		&.status-ongoing
	    			background #ffd300
	    		&.status-finished
	    			background #42b983
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
