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
      <el-table :data="lista" border stripe>
        <el-table-column type="expand">
          <template slot-scope="scope">
            <el-form label-position="left" block class="demo-table-expand">
              <el-form-item label="买家昵称">
                <span>{{ scope.row.persion }}</span>
              </el-form-item>
              <el-form-item label="联系电话">
                <span>{{ scope.row.phone }}</span>
              </el-form-item>
              <el-form-item label="商品名称">
                <span>{{ scope.row.good }}</span>
              </el-form-item>
              <el-form-item label="购买数量">
                <span>{{ scope.row.count }} 件</span>
              </el-form-item>
              <el-form-item label="收获地址">
                <span>{{ scope.row.address }}</span>
              </el-form-item>
            </el-form>
          </template>
        </el-table-column>
        <el-table-column label="订单编号" prop="id"></el-table-column>
        <el-table-column label="订单价格" prop="price"></el-table-column>
        <el-table-column label="是否付款" prop="payment">
          <template slot-scope="scope">
            <!-- scopr是一个对象 也就是当前遍历的这个item行的对象 -->
            <el-tag type="success" v-show="scope.row.payment">已付款</el-tag>
            <el-tag type="danger" v-show="!scope.row.payment">未付款</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="是否发货" prop="send">
          <template slot-scope="scope">
            <el-tag type="success" v-show="scope.row.send">已发货</el-tag>
            <el-tag type="danger" v-show="!scope.row.send">未发货</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="下单时间" prop="time"></el-table-column>
        <el-table-column label="操作">
          <template slot-scope>
            <el-button
              type="primary"
              @click="dialogVisible = true"
              size="mini"
              icon="el-icon-edit"
            ></el-button>
            <el-button
              type="success"
              size="mini"
              icon="el-icon-location"
            ></el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 修改地址对话框 -->
      <el-dialog title="提示" :visible.sync="dialogVisible" width="30%">
        <!-- <el-form>
          <el-form-item label="省市区/县">
            <el-input>
          </el-form-item>
          <el-form-item label="详细地址">
            <el-input>
          </el-form-item>
        </el-form>-->
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="dialogVisible = false"
            >确 定</el-button
          >
        </span>
      </el-dialog>
    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
      lista: [
        {
          id: '_jimmylovexuexue15120',
          persion: 'Jimmy',
          phone: '19905076109',
          good:
            '【限时享24期免息向往的生活同款】小米10Pro5g手机骁龙865处理器5G手机学生拍照小米官方旗舰店官网正品米10',
          count: 1,
          price: 520,
          payment: true,
          send: true,
          time: '2017-11-07 20:08:46',
          address: '福建省福州市晋安区双翔新村3座301',
        },
        {
          id: '_jimmylovexuexue15120',
          persion: 'Jimmy',
          phone: '19905076109',
          good:
            '【限时享24期免息向往的生活同款】小米10Pro5g手机骁龙865处理器5G手机学生拍照小米官方旗舰店官网正品米10',
          count: 1,
          price: 520,
          payment: false,
          send: true,
          time: '2017-11-07 20:08:46',
          address: '福建省福州市晋安区双翔新村3座301',
        },
        {
          id: '_jimmylovexuexue15120',
          persion: 'Jimmy',
          phone: '19905076109',
          good:
            '【限时享24期免息向往的生活同款】小米10Pro5g手机骁龙865处理器5G手机学生拍照小米官方旗舰店官网正品米10',
          count: 1,
          price: 520,
          payment: true,
          send: true,
          time: '2017-11-07 20:08:46',
          address: '福建省福州市晋安区双翔新村3座301',
        },
        {
          id: '_jimmylovexuexue15120',
          persion: 'Jimmy',
          phone: '19905076109',
          good:
            '【限时享24期免息向往的生活同款】小米10Pro5g手机骁龙865处理器5G手机学生拍照小米官方旗舰店官网正品米10',
          count: 1,
          price: 520,
          payment: true,
          send: true,
          time: '2017-11-07 20:08:46',
          address: '福建省福州市晋安区双翔新村3座301',
        },
        {
          id: '_jimmylovexuexue15120',
          persion: 'Jimmy',
          phone: '19905076109',
          good:
            '【限时享24期免息向往的生活同款】小米10Pro5g手机骁龙865处理器5G手机学生拍照小米官方旗舰店官网正品米10',
          count: 1,
          price: 520,
          payment: true,
          send: true,
          time: '2017-11-07 20:08:46',
          address: '福建省福州市晋安区双翔新村3座301',
        },
      ],
      dialogVisible: false,
    }
  },
  methods: {
    handleClose() {
      this.$confirm('确认关闭？')
        .then(_ => {
          this.dialogVisible = false
        })
        .catch(_ => {})
    },
  },
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
</style>
