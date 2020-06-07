<template>
  <div class="root">
    <div class="aside">
      <div class="breadcrumb">
        <el-breadcrumb separator="/">
          <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
          <el-breadcrumb-item>个人信息</el-breadcrumb-item>
        </el-breadcrumb>
      </div>
      <div class="photoContainer">
        <img src="../../assets/img/portrait.jpg" alt="" />
      </div>
    </div>
    <div class="main">
      <div class="textContainer">
        <div class="lineContainer">
          <i class="el-icon-user-solid"></i><span>Jimmy</span>
        </div>
        <br /><br />
        <div class="lineContainer">
          <i class="el-icon-s-tools"></i><span>超级管理员</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {}
</script>

<style lang="less" scoped>
.root {
  width: 100%;
  height: 100%;
  display: flex;
  .aside {
    width: 35%;
    height: 100%;
    background-color: #3498db;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    position: relative;
    .breadcrumb {
      position: absolute;
      top: 20px;
      left: 20px;
    }
    .photoContainer {
      width: 250px;
      height: 250px;
      background-color: #f1c40f;
      img {
        width: 100%;
        height: 100%;
        border-radius: 50%;
      }
    }
  }
  .main {
    width: 65%;
    height: 100%;
    background-color: #2ecc71;
    display: flex;
    align-items: center;
    .textContainer {
      display: flex;
      flex-direction: column;
      justify-content: center;
      width: 300px;
      height: 300px;
      .lineContainer {
        display: flex;
        align-items: center;
        margin-left: 30px;
        i {
          font-size: 30px;
        }
        span {
          font-size: 20px;
        }
      }
    }
  }
}
</style>
