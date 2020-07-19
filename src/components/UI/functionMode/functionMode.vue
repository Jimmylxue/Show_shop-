<template>
  <div class="functionMode">
    <div class="mine">
      <el-card class="conts">
        <div class="user">
          <div class="header">
            <img src="@/assets/img/portrait.jpg" width="100%" height="100%" alt />
          </div>
          <!-- <div class="name">{{name===''?'请登录':name}}</div> -->
        </div>
        <div class="more">
          <div class="firstline">
            <img src="@/assets/fonts/ditie.png" alt />
            <span>地铁</span>
          </div>
          <div class="firstline">
            <img src="@/assets/fonts/city.png" alt />
            <span>城市</span>
          </div>
          <div class="firstline">
            <img src="@/assets/fonts/weather.png" alt />
            <span>天气</span>
          </div>
          <div>
            <img src="@/assets/fonts/database.png" alt />
            <span>数据库</span>
          </div>
          <div>
            <img src="@/assets/fonts/luntan.png" alt />
            <span>论坛</span>
          </div>
          <div>
            <img src="@/assets/fonts/hot.png" alt />
            <span>热搜</span>
          </div>
          <div>
            <img src="@/assets/fonts/ditie.png" alt />
            <span>地铁</span>
          </div>
        </div>
      </el-card>
    </div>
    <div class="functionContainer">
      <el-card>
        <h3>功能模块</h3>
        <el-checkbox-group v-model="arr" @change="changeStatus">
          <el-checkbox
            v-for="(item,index) in checkList"
            :key="index"
            :label="item.functionName"
            :checked="item.status==1"
          ></el-checkbox>
          <!-- <el-checkbox></el-checkbox> -->
        </el-checkbox-group>
      </el-card>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      checkList: [],
      arr: []
    }
  },
  mounted() {
    this.getFunctions()
  },
  methods: {
    async getFunctions() {
      let res = await this.$api.functionsMode.getFunctions()
      this.checkList = res.data
    },
    changeStatus(value) {
      console.log(value)
    }
  }
}
</script>

<style lang="less" scoped>
.functionMode {
  display: flex;
}
.mine {
  width: 300px;
  // height: 200px;
  .conts {
    height: 500px;
    display: flex;
    flex-direction: column;
    .user {
      width: 100%;
      height: 120px;
      border-bottom: 1px solid #ccc;
      display: flex;
      justify-content: center;
      align-items: center;
      .header {
        width: 70px;
        height: 70px;
        border-radius: 50%;
        overflow: hidden;
        margin-right: 1rem;
      }
      .name {
        font-size: 1.8rem;
      }
    }
    .more {
      width: 100%;
      // height: 100%;
      // border: 1px solid #ccc;
      display: flex;
      justify-content: space-between;
      flex-wrap: wrap;
      .firstline {
        margin-top: 20px;
      }
      div {
        height: 80px;
        display: flex;
        padding: 5px 10px;
        flex-direction: column;
        // align-items: center;
        text-align: center;
        // margin-top: 8px;
        img {
          width: 45px;
          height: 45px;
        }
        span {
          padding-bottom: 8px;
          padding-top: 5px;
          font-size: 0.9rem;
          color: rgb(42, 48, 56);
        }
        &:hover {
          border: 1px solid #ccc;
          box-shadow: 0 0 5px #ccc;
        }
      }
    }
  }
}
.functionContainer {
  width: 100%;
}
</style>