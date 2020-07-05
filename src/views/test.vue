<template>
  <div class="test">
    <imgLoad></imgLoad>
  </div>
</template>

<script>
import imgLoad from '@/components/imgLoad/imgLoad.vue'
export default {
  components: {
    imgLoad
  }
}
</script>

<style lang="less" scoped>
.test {
  width: 100vw;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.25);
}
</style>