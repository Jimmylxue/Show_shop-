<template>
  <div class="ui">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>界面设置</el-breadcrumb-item>
      <el-breadcrumb-item>系统界面</el-breadcrumb-item>
    </el-breadcrumb>
    <el-tabs :tab-position="tabPosition" style="margin-top:20px">
      <el-tab-pane label="登录背景界面">
        <loginBg></loginBg>
      </el-tab-pane>
      <el-tab-pane label="轮播图">
        <slider></slider>
      </el-tab-pane>
      <el-tab-pane label="首页搜索栏">
        <searchBtn></searchBtn>
      </el-tab-pane>
      <el-tab-pane label="首页模块">
        <function-mode></function-mode>
      </el-tab-pane>
      <el-tab-pane label="视频模块">
        <myVideo></myVideo>
      </el-tab-pane>
      <el-tab-pane label="广告图片">角色管理</el-tab-pane>
      <!-- <el-tab-pane label="定时任务补偿">定时任务补偿</el-tab-pane> -->
    </el-tabs>
  </div>
</template>

<script>
import loginBg from '@/components/UI/loginBg/loginBg.vue'
import myVideo from '@/components/UI/videoMode/myVideo.vue'
import searchBtn from '@/components/UI/searchBtn/searchBtn.vue'
import slider from '@/components/UI/slider/slider.vue'
import functionMode from '@/components/UI/functionMode/functionMode.vue'
export default {
  components: {
    loginBg,
    slider,
    searchBtn,
    functionMode,
    myVideo
  },
  data() {
    return {
      tabPosition: 'left'
    }
  }
}
</script>

<style lang="less" scoped>
.ui {
  padding: 20px;
}

// .lunbo {
//   .show {
//     width: 920px;
//     height: 500px;
//     .el-carousel__item h3 {
//       color: #475669;
//       font-size: 18px;
//       opacity: 0.75;
//       line-height: 300px;
//       margin: 0;
//     }

//     .el-carousel__item:nth-child(2n) {
//       background-color: #99a9bf;
//     }

//     .el-carousel__item:nth-child(2n + 1) {
//       background-color: #d3dce6;
//     }
//   }
// }
</style>