<template>
  <div class="root stock">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>商品管理</el-breadcrumb-item>
      <el-breadcrumb-item>库存信息</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-table :data="coundata" border stripe>
        <el-table-column type="index"></el-table-column>
        <el-table-column label="商品名称" prop="goodname"></el-table-column>
        <el-table-column label="商品规格" prop="capacity"></el-table-column>
        <el-table-column label="商品类型" prop="type"></el-table-column>
        <el-table-column label="销售情况" prop="sale">
          <template slot-scope="scope">
            <div class="cont">
              <span>{{scope.row.sale}}</span>
              <el-progress
                type="circle"
                :percentage="(scope.row.sale/scope.row.count)*100"
                color="#13CE66"
              ></el-progress>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="剩余库存" prop="count">
          <template slot-scope="scope">
            <div class="cont">
              <span>{{scope.row.count-scope.row.sale}}</span>
              <el-progress
                type="circle"
                :percentage="(scope.row.count - scope.row.sale)/scope.row.count*100"
                color="#13CE66"
              ></el-progress>
            </div>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
      coundata: [
        {
          goodname: '小米10 Pro',
          capacity: '12+256',
          type: '全新',
          sale: 50,
          count: 100
        },
        {
          goodname: '苹果AirPods Pro',
          capacity: 'AirPod+保护壳',
          type: '全新',
          sale: 18,
          count: 40
        },
        {
          goodname: 'Redmi Note 8 Pro',
          capacity: '8+128',
          type: '全新',
          sale: 85,
          count: 100
        }
      ]
    }
  }
}
</script>

<style lang="less" scoped>
.root {
  padding: 20px;
}
.el-card {
  margin-top: 15px;
  .el-table {
    margin-top: 15px;
  }
}

.cont {
  width: 126px;
  height: 126px;
  position: relative;
  span {
    position: absolute;
    display: flex;
    width: 30px;
    height: 30px;
    justify-content: center;
    align-items: center;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }
}
</style>