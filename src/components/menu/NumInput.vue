<template>
<div class="num-input">
	<div class="add" @click="onAddFood"><img src="../../assets/images/add.png"></div>
    <div v-show="foodNum > 0" class="food-num">{{ foodNum }}</div>
    <div v-show="foodNum > 0" class="minus"  @click="onMinusFood"><img src="../../assets/images/minus.png"></div>
</div>
</template>

<script>


export default {
  name: 'num-input',
  components: {  },
  props: {
  	cart: {
  		type: Array,
  	},
  	food: {
  		type: Object
  	}
  },
  data() {
    return {

    }
  },
  computed: {
    foodNum() {
		for(let k in this.cart) {
			let c = this.cart[k]
			if(c.foodid == this.food.id) {
			  return c.num
			}
		}
    	return 0;
    }
  },
  methods: {
  	onAddFood() {
  		this.$emit('addFood', this.food);
    },
    onMinusFood() {
    	this.$emit('minusFood', this.food);
    }
  }
}
</script>

<style lang="stylus">
.num-input
  .add
	  float right
	  width 25px
	  height 25px
	  img
	    width 100%
	    height 100%
	.food-num
	  float right
	  line-height 25px
	  padding 0 5px
	.minus
	  float right
	  width 25px
	  height 25px
	  img
	    width 100%
	    height 100%
</style>
