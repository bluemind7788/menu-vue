<template>
  <div id="app">
    <transition name="fade" mode="out-in">
      <router-view class="view"></router-view>
    </transition>
  </div>
</template>

<style lang="stylus">
body
  font-family Arial,Helvetica,sans-serif;
  background-color #fff
  overflow-y scroll

  .clearfix:after
    content "."
    display block
    clear both
    visibility hidden
    line-height 0
    height 0

  

</style>
