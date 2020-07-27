<template>
  <div class="video">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>视频管理</el-breadcrumb-item>
      <el-breadcrumb-item>首页视频</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-table> </el-table>
    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    return {}
  },
  mounted() {
    this.getVideoList()
  },
  methods: {
    async getVideoList() {
      let res = await this.$api.video.getVideoLsit()
      console.log(res)
    },
  },
}
</script>

<style lang="less" scoped>
.video {
  padding: 20px;
}
.el-card {
  margin-top: 15px;
  .el-table {
    margin-top: 15px;
  }
}
</style>
