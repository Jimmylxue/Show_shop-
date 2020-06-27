<template>
  <div class="root">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>商品管理</el-breadcrumb-item>
      <el-breadcrumb-item>添加商品</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <el-col :span="8">
          <el-input placeholder="请输入内容">
            <el-button slot="append" icon="el-icon-search"></el-button>
          </el-input>
        </el-col>
      </el-row>
      <!-- 订单列表 -->
      <el-table v-loading="loading" :data="orderList" border stripe>
        <el-table-column type="expand">
          <template slot-scope="scope">
            <el-form label-position="left" block class="demo-table-expand">
              <el-form-item label="买家昵称">
                <span>{{ scope.row.buyname }}</span>
              </el-form-item>
              <el-form-item label="收件人">
                <span>{{ scope.row.username }}</span>
              </el-form-item>
              <el-form-item label="联系电话">
                <span>{{ scope.row.phone }}</span>
              </el-form-item>
              <el-form-item label="购买数量">
                <span>{{ scope.row.goodcount }} 件</span>
              </el-form-item>
              <el-form-item label="收获地址">
                <span>{{ scope.row.province }}{{scope.row.city}}{{scope.row.area}}{{scope.row.detail}}</span>
              </el-form-item>
            </el-form>
          </template>
        </el-table-column>
        <el-table-column label="订单编号" prop="orderid"></el-table-column>
        <el-table-column label="订单价格" prop="orderprice"></el-table-column>
        <el-table-column label="是否付款" prop="paystates">
          <template slot-scope="scope">
            <!-- scopr是一个对象 也就是当前遍历的这个item行的对象 -->
            <el-tag type="success" v-show="scope.row.paystatus === 1">已付款</el-tag>
            <el-tag type="danger" v-show="scope.row.paystatus === 0">未付款</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="是否发货" prop="send">
          <template slot-scope="scope">
            <el-tag type="success" v-show="scope.row.send === 1">已发货</el-tag>
            <el-tag type="danger" v-show="scope.row.send === 0">未发货</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="下单时间" prop="payTime">
          <template slot-scope="scope">{{scope.row.createtime}}</template>
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button
              type="primary"
              @click="tochange(scope.row.id)"
              size="mini"
              icon="el-icon-edit"
            >修改地址</el-button>
            <el-button
              type="success"
              size="mini"
              @click="tosend(scope.row)"
              icon="el-icon-location"
            >发货</el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 修改地址对话框 -->
      <el-dialog title="修改订单信息" :visible.sync="dialogVisible" width="30%">
        <el-form
          :model="select"
          :rules="rules"
          ref="changes"
          label-width="100px"
          class="demo-ruleForm"
        >
          <el-form-item label="订单编号" prop="id">
            <el-input disabled v-model="select.id"></el-input>
          </el-form-item>
          <el-form-item label="地址" prop="address">
            <el-input v-model="select.address"></el-input>
          </el-form-item>
          <el-form-item label="收件人" prop="person">
            <el-input v-model="select.person"></el-input>
          </el-form-item>
          <el-form-item label="电话号码" prop="phone">
            <el-input v-model="select.phone"></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="change">确 定</el-button>
        </span>
      </el-dialog>
      <!-- 确认发货对话框 -->
      <el-dialog title="发货信息" :visible.sync="sendGood" width="60%">
        <div class="Detail">
          <h3>请按照下列商品列表配货</h3>
          <p>订单清单</p>
          <div class="msgcontain" v-for="(item,index) in good" :key="index">
            <div>
              <img :src="item.goodimg" width="200px" height="200px" alt />
            </div>
            <div>
              <p>{{ item.goodname }}</p>
              <p>{{ item.gooddesc }}</p>
              <p>{{ item.capacity }}</p>
            </div>
            <div>
              <span>{{ item.price }}</span>
              ×{{ select.goodcount }}
            </div>
          </div>
          <div class="usermsg">
            <h3>请按照下列信息发货</h3>
            <p>地址:{{ select.province }}{{select.city}}{{select.area}}{{select.detail}}</p>
            <p>收货人:{{ select.username }}</p>
            <p>电话号码:{{ select.phone }}</p>
          </div>
        </div>
        <span slot="footer" class="dialog-footer send">
          <el-button type="primary" @click="send" plain>确认发货并提醒用户</el-button>
        </span>
      </el-dialog>
    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
      orderList: [],
      good: [],
      select: {},
      // 编辑flag
      dialogVisible: false,
      // 发货flag
      sendGood: false,
      loading: true,
      rules: {
        person: [
          { required: true, message: '收件人不能为空', trigger: 'blur' }
        ],
        address: [{ required: true, message: '地址不能为空', trigger: 'blur' }],
        phone: [
          { required: true, message: '请输入正确的手机号', trigger: 'blur' }
        ]
      }
    }
  },
  mounted() {
    this.getList()
    this.loadFun()
  },
  methods: {
    async getList() {
      let res = await this.$api.order.getList()
      this.orderList = res.data
      console.log(';lll', this.orderList)
    },
    handleClose() {
      this.$confirm('确认关闭？')
        .then(_ => {
          this.dialogVisible = false
        })
        .catch(_ => {})
    },
    async tosend(row) {
      let goodid = row.goodid.split('-')
      goodid.splice(0, 1)
      console.log(goodid)
      let res = await this.$api.good.getSomeGood({
        ids: JSON.stringify(goodid)
      })
      this.good = res.data
      // console.log(items)
      console.log(this.good)
      this.select = row
      // this.detailstatus = true
      this.sendGood = true
      // this.select = this.orderList.filter(item => item.id === id)[0]
    },
    send() {
      this.sendGood = false
      this.$swal('哟吼~', '发货成功~', 'success')
    },
    loadFun() {
      this.loading = true
      let interval = setInterval(() => {
        if (this.orderList.length !== 0) {
          this.loading = false
          clearInterval(interval)
        }
      }, 1000)
    },
    tochange(id) {
      this.dialogVisible = true
      this.select = this.orderList.filter(item => item.id === id)[0]
    },
    async change() {
      this.dialogVisible = false
      this.$refs.changes.validate(valid => {
        if (valid) {
          this.$api.order.changeMsg(this.select).then(res => {
            if (res.data.code === 1) {
              this.$swal('哟吼~', '更新成功~', 'success')
              return
            }
            this.$swal('哎哟~', '更新失败~', 'warning')
          })
          return
        }
        this.$swal('哎哟~', '信息不符~', 'warning')
      })
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

.Detail {
  font-size: 16px;
  & > p {
    margin-top: 20px;
    border-bottom: 2px solid rgb(188, 188, 188);
    padding-bottom: 10px;
  }
  .msgcontain {
    display: flex;
    border-bottom: 2px solid rgb(240, 240, 240);
    & > div:nth-child(2) {
      padding-top: 30px;
      & > p:nth-child(1) {
        font-weight: bold;
      }
      & > p:nth-child(2) {
        padding-top: 10px;
        font-weight: bold;
        margin-bottom: 40px;
      }
    }
    & > div:nth-child(3) {
      width: 250px;
      text-align: center;
      padding-top: 40px;
      span {
        color: rgb(254, 62, 68);
        font-weight: bold;
        font-size: 16px;
      }
    }
  }
  .usermsg {
    margin-top: 50px;
    & > h3 {
      margin-bottom: 15px;
    }
    & > p {
      margin-top: 5px;
    }
  }
}
.send {
  display: flex;
  justify-content: center;
  padding-bottom: 5px;
}
</style>
