<template>
  <div class="classify">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>商品管理</el-breadcrumb-item>
      <el-breadcrumb-item>商品类别管理</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <div class="title">
        <span>当前栏目：</span>
        <el-select @change="changesel" v-model="value" placeholder="请选择">
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          ></el-option>
        </el-select>
      </div>
      <el-table border stripe :data="entershow" style="width:100%">
        <el-table-column label="商品ID" width="140" prop="goodid"></el-table-column>
        <el-table-column label="商品图片" width="120" align="center" prop="goodimg">
          <template slot-scope="scope">
            <img :src="scope.row.goodimg" width="100px" height="100px" alt />
          </template>
        </el-table-column>
        <el-table-column label="商品名称" prop="goodname"></el-table-column>
        <el-table-column label="商品栏目" prop="tag">
          <template slot-scope="scope">
            <div>
              <el-tag
                :type="scope.row.tag==='recommand'?'success':'danger'"
                class="mytag"
              >{{scope.row.tag}}</el-tag>
              <span v-show="scope.row.tag==='recommand'">推荐区</span>
              <span v-show="scope.row.tag==='discount '">闪购区</span>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="现价" prop="nowPrice">
          <template slot-scope="scope">
            <span v-show="scope.row.nowPrice===0">{{scope.row.price}}</span>
            <span v-show="scope.row.nowPrice!=0">{{scope.row.nowPrice}}</span>
          </template>
        </el-table-column>
        <el-table-column label="原价" prop="price"></el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <div>
              <el-button @click="changeplate(scope.row)" type="primary">切换栏目</el-button>
            </div>
          </template>
        </el-table-column>
      </el-table>
      <div class="block">
        <span class="demonstration">总数</span>
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page.sync="currentPage1"
          :page-size="onepageSize"
          layout="total, prev, pager, next"
          :total="recommandgood.length"
        ></el-pagination>
      </div>
    </el-card>
    <el-dialog title="修改栏目" :visible.sync="dialogVisible" width="30%">
      <div>
        <el-form :model="changplate">
          <el-form-item label="商品名称">
            <el-input v-model="changplate.goodname"></el-input>
          </el-form-item>
          <el-form-item label="商品当前栏目">
            <el-input v-model="changplate.tag"></el-input>
          </el-form-item>
          <el-form-item label="商品当前价格">
            <el-input v-model="changplate.price"></el-input>
          </el-form-item>
          <el-form-item label="调整为">
            <br />
            <div class="side">
              <el-select @change="changesex" v-model="values" placeholder="请选择">
                <el-option
                  v-for="item in optionschange"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                ></el-option>
              </el-select>
              <el-input
                v-show="values==='选项2'"
                v-model="changplate.nowPrice"
                placeholder="清输入打折后价格"
              ></el-input>
            </div>
          </el-form-item>
        </el-form>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="tochange">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { mapActions, mapState } from 'vuex'
export default {
  data() {
    return {
      recommandgood: [],
      onepageSize: 5,
      currentPage1: 1,
      entershow: [],
      // 下拉框
      options: [
        {
          value: '选项1',
          label: 'recommand 推荐区'
        },
        {
          value: '选项2',
          label: 'discount 闪购区'
        }
      ],
      optionschange: [
        {
          value: '选项1',
          label: 'recommand 推荐区'
        },
        {
          value: '选项2',
          label: 'discount 闪购区'
        },
        {
          value: '选项3',
          label: '请选择'
        }
      ],
      values: '选项3',
      value: '选项1',
      nowsel: 'recommand 推荐区',
      // change
      dialogVisible: false,
      changesela: '',
      changplate: {}
    }
  },
  computed: {},
  watch: {
    currentPage1(newval) {
      this.entershow.length = 0
      this.recommandgood.forEach(item => {
        if (
          this.recommandgood.indexOf(item) >= (newval - 1) * 5 &&
          this.recommandgood.indexOf(item) < newval * 5
        ) {
          this.entershow.push(item)
        }
      })
    },
    nowsel() {
      this.gain()
    }
  },
  mounted() {
    this.getgood()
    this.gain()
  },
  methods: {
    ...mapActions(['getGoods']),
    getgood() {
      this.getGoods()
    },
    // gain
    gain() {
      setTimeout(() => {
        this.recommandgood = this.$store.state.goods.goodsMsg.filter(
          item => item.tag === this.nowsel.split(' ')[0]
        )
        this.entershow.length = 0
        if (this.recommandgood.length > this.onepageSize - 1) {
          for (let i = 0; i < this.onepageSize; i++) {
            this.entershow.push(this.recommandgood[i])
          }
        } else {
          this.recommandgood.forEach(item => {
            this.entershow.push(item)
          })
        }
      }, 1000)
    },
    // 分页
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`)
    },
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`)
    },
    // 栏目的修改
    changesel(e) {
      this.nowsel = this.options.filter(item => item.value === e)[0].label
    },
    changesex(e) {
      this.changesela = this.optionschange.filter(
        item => item.value === e
      )[0].label
    },
    changeplate(e) {
      this.changplate = e
      this.dialogVisible = true
    },
    async tochange(e) {
      if (this.changesela === '') {
        console.log('未改变')
        return
      }
      let res = await this.$api.good.changetag(
        this.changplate.goodid,
        this.changesela.split(' ')[0],
        this.changplate.nowPrice,
        this.changplate.price
      )
      if (res.data.code === 1) {
        this.$message({
          message: '栏目修改成功',
          type: 'success'
        })
        location.reload()
        this.dialogVisible = false
        return
      }
      this.$message.error('栏目修改失败')
    }
  }
}
</script>

<style lang="less" scoped>
.classify {
  padding: 20px;
}
.el-card {
  margin-top: 15px;
  .el-table {
    margin-top: 15px;
  }
}

.mytag {
  margin-right: 10px;
}

.side {
  display: flex;
}
</style>