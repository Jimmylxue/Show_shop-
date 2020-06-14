<template>
  <div class="root stock">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>商品管理</el-breadcrumb-item>
      <el-breadcrumb-item>库存信息</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <el-col :span="8">
          <el-input placeholder="请输入商品ID">
            <el-button slot="append" icon="el-icon-search"></el-button>
          </el-input>
        </el-col>
      </el-row>
      <el-table v-loading="loading" :data="stock" border stripe>
        <el-table-column label="商品编号" type="index" width="90">
          <template slot-scope="scope">{{ scope.row.goodid }}</template>
        </el-table-column>
        <el-table-column label="商品图片" width="120" align="center">
          <template slot-scope="scope">
            <img :src="scope.row.goodimg" width="100px" height="100px" alt />
          </template>
        </el-table-column>
        <el-table-column label="商品名称" prop="goodname"></el-table-column>
        <el-table-column label="商品规格" prop="capacity"></el-table-column>
        <el-table-column label="商品类型" prop="type"></el-table-column>
        <el-table-column label="销售情况" prop="sale">
          <template slot-scope="scope">
            <div class="cont">
              <span>{{ scope.row.sale }}</span>
              <el-progress
                type="circle"
                :percentage="
                  scope.row.count === 0
                    ? 100
                    : (scope.row.sale / scope.row.count) * 100
                "
              ></el-progress>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="剩余库存" prop="count">
          <template slot-scope="scope">
            <div class="cont">
              <span>
                {{
                scope.row.count === 0 ? 0 : scope.row.count - scope.row.sale
                }}
              </span>
              <el-progress
                type="circle"
                :percentage="
                  scope.row.count === 0
                    ? 0
                    : ((scope.row.count - scope.row.sale) / scope.row.count) *
                      100
                "
                :color="penterColor(scope.row.count,scope.row.sale)"
              ></el-progress>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="240">
          <template slot-scope="scope">
            <el-button
              type="success"
              size="mini"
              icon="el-icon-edit"
              @click="toEdit(scope.row.goodid)"
            >修改库存</el-button>
            <el-button
              type="danger"
              size="mini"
              @click="clearStock(scope.row.goodid)"
              icon="el-icon-delete"
            >清空库存</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
    <!-- 修改库存 -->
    <el-dialog title="修改库存" :visible.sync="dialogVisible" width="30%">
      <div class="change">
        <span>{{nowname}}</span>
        <span>目前个数：{{nowcount}}</span>
        <el-input-number v-model="nowcount" @change="handleChange" :min="1" label="描述文字"></el-input-number>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="Edit">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { mapState, mapActions } from 'vuex'
export default {
  data() {
    return {
      stock: [],
      dialogVisible: false,
      num: 1,
      wannaEditCountId: '123456',
      nowname: '',
      nowcount: 50,
      beforEdit: 0,
      loading: true
    }
  },
  computed: {
    ...mapState({ countMsg: state => state.goods.countMsg })
  },
  async mounted() {
    this.getAllCount()
  },
  methods: {
    ...mapActions(['selctCount']),
    async getAllCount() {
      this.loadFun()
      this.selctCount()
      let res = await (await this.$api.good.getCount()).data
      this.stock = res
    },
    async clearStock(id) {
      this.$confirm('此操作将清空改商品的库存，确定继续吗？')
        .then(_ => {
          this.$api.good.clearStock(id).then(res => {
            if ((res.data.code = 1)) {
              this.$message({
                message: '删除成功',
                type: 'success'
              })
              this.getAllCount()
              return
            }
            this.$message({
              message: '清空失败~',
              type: 'warning'
            })
          })
        })
        .catch(_ => {})

      // let code = await (await this.$api.good.clearStock(id)).data.code
      // if (code === 1) {
      //   this.$message({
      //     message: '删除成功',
      //     type: 'success',
      //   })
      //   return
      // }
      // this.$message({
      //   message: '清空失败~',
      //   type: 'warning',
      // })
    },
    handleChange() {},
    penterColor(count, sale) {
      let conent = count === 0 ? 0 : ((count - sale) / count) * 100
      if (conent >= 50) {
        return '#13CE66'
      } else if (conent < 50 && conent >= 25) {
        return '#E6A23C'
      } else {
        return '#FF4949'
      }
    },
    toEdit(id) {
      this.wannaEditCountId = id
      this.nowname = this.stock.filter(item => item.goodid == id)[0].goodname
      this.beforEdit =
        this.stock.filter(item => item.goodid == id)[0].count -
        this.stock.filter(item => item.goodid == id)[0].sale
      this.nowcount =
        this.stock.filter(item => item.goodid == id)[0].count -
        this.stock.filter(item => item.goodid == id)[0].sale
      this.dialogVisible = true
    },
    async Edit() {
      if (this.nowcount !== this.beforEdit) {
        let res = await this.$api.good.editStockCount(
          this.wannaEditCountId,
          this.nowcount
        )
        if (res.data.code === 1) {
          this.$message({
            showClose: true,
            message: '更新成功',
            type: 'success'
          })
          this.dialogVisible = false
          this.getAllCount()
          return
        }
        this.$message({
          message: '更新失败~',
          type: 'warning'
        })
        return
      }
      this.$message({
        showClose: true,
        message: '未作出修改',
        type: 'warning'
      })
      this.dialogVisible = false
    },
    loadFun() {
      this.loading = true
      let interval = setInterval(() => {
        if (this.stock.length !== 0) {
          this.loading = false
          clearInterval(interval)
        }
      }, 1000)
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

.change {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  span {
    margin-bottom: 20px;
  }
}
</style>
