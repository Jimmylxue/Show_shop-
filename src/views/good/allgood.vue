<template>
  <div class="root">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>商品管理</el-breadcrumb-item>
      <el-breadcrumb-item>商品列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <el-col :span="8">
          <el-input v-model="msg" placeholder="根据商品名称查询">
            <el-button slot="append" @click="search" icon="el-icon-search"></el-button>
          </el-input>
        </el-col>
        <el-col :span="6">
          <el-button type="primary" @click="$router.push('/addGood')">添加商品</el-button>
        </el-col>
      </el-row>
      <el-table v-loading="loading" :data="goods" style="width: 100%">
        <el-table-column type="expand">
          <template slot-scope="props">
            <el-form label-position="left" inline class="demo-table-expand">
              <el-form-item label="商品名称">
                <span>{{ props.row.goodname }}</span>
              </el-form-item>
              <el-form-item label="邮费">
                <span>{{ props.row.firight }}</span>
              </el-form-item>
              <el-form-item label="商品 ID">
                <span>{{ props.row.goodid }}</span>
              </el-form-item>
              <el-form-item label="商品类型">
                <span>{{ props.row.classify }}</span>
              </el-form-item>
              <el-form-item label="产品分类">
                <span>{{ props.row.type }}</span>
              </el-form-item>
              <el-form-item label="商品品牌">
                <span>{{ props.row.brand }}</span>
              </el-form-item>
              <el-form-item label="商品描述">
                <span>{{ props.row.gooddesc }}</span>
              </el-form-item>
              <el-form-item label="商品价格">
                <span>{{ props.row.price }}</span>
              </el-form-item>
              <el-form-item label="商品图片">
                <div>
                  <img :src="props.row.goodimg" alt />
                </div>
              </el-form-item>
            </el-form>
          </template>
        </el-table-column>
        <el-table-column label="商品 ID" prop="goodid"></el-table-column>
        <el-table-column label="商品名称" prop="goodname"></el-table-column>
        <el-table-column label="描述" prop="gooddesc"></el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
import { mapState, mapActions } from 'vuex'
export default {
  data() {
    return {
      loading: true,
      goods: [],
      msg: '小米'
    }
  },
  methods: {
    ...mapActions(['getGoods']),
    // 获取页面数据
    getGood() {
      this.getGoods()
      setTimeout(() => {
        this.goods = this.$store.state.goods.goodsMsg
      }, 1000)
    },
    // 根据搜索框查询数据
    search() {
      this.goods = this.goods.filter(
        item => item.goodname.indexOf(this.msg) !== -1
      )
    },
    // 控制loadding的开关
    loadfun() {
      let interval = setInterval(() => {
        if (this.goods.length !== 0) {
          this.loading = false
          clearInterval(interval)
        }
      }, 500)
    }
  },
  computed: {
    ...mapState({ goodsMsg: state => state.goods.goodsMsg })
  },
  mounted() {
    this.loadfun()
    this.getGood()
  },
  watch: {
    msg(newval) {
      if (newval === '') {
        this.goods = this.$store.state.goods.goodsMsg
      }
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

.demo-table-expand {
  font-size: 0;
}
.demo-table-expand label {
  width: 90px;
  color: #99a9bf;
}
.demo-table-expand .el-form-item {
  margin-right: 0;
  margin-bottom: 0;
  width: 50%;
}

.block {
  padding-top: 10px;
}
</style>