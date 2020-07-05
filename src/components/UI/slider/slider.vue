<template>
  <div class="slider">
    <div class="show">
      <el-carousel :interval="5000" arrow="always">
        <el-carousel-item v-for="item in sliders" :key="item.id">
          <img :src="item.sliderimg" width="100%" height="100%" alt />
        </el-carousel-item>
      </el-carousel>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      sliders: []
    }
  },
  mounted() {
    this.getSlider()
  },
  methods: {
    async getSlider() {
      let res = await this.$api.slider.getSlider()
      this.sliders = res.data
    }
  }
}
</script>

<style lang="less" scoped>
.slider {
  .show {
    width: 920px;
    height: 500px;
    .el-carousel__item h3 {
      color: #475669;
      font-size: 18px;
      opacity: 0.75;
      line-height: 300px;
      margin: 0;
    }

    .el-carousel__item:nth-child(2n) {
      background-color: #99a9bf;
    }

    .el-carousel__item:nth-child(2n + 1) {
      background-color: #d3dce6;
    }
  }
}
</style>